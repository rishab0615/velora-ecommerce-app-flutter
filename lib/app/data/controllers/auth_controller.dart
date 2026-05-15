import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../utils/firebase_auth_error_handler.dart';
import '../models/user_model.dart';
import '../services/firestore_service/user_service.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find<AuthController>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  // Reactive user state
  final Rx<User?> _user = Rx<User?>(null);

  User? get user => _user.value;

  bool get isLoggedIn => _user.value != null;

  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isLoggingIn = false.obs;
  final RxBool isRegistering = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Listen to auth state changes
    _user.bindStream(_auth.authStateChanges());
  }

  // LOGIN
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoggingIn.value = true;

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      debugPrint(
        'Firebase login success. UID: ${userCredential.user?.uid ?? 'unknown'}',
      );

      final user = userCredential.user;

      if (user == null) {
        await _auth.signOut();
        return 'unknown';
      }

      await user.reload();
      final refreshedUser = _auth.currentUser;

      if (!(refreshedUser?.emailVerified ?? false)) {
        debugPrint(
            'Firebase login blocked. Email not verified. UID: ${user.uid}');
        await _auth.signOut();
        return 'email-not-verified';
      }

      try {
        await _createFirestoreUserIfNeeded(refreshedUser!);
      } catch (e) {
        debugPrint('Post-login Firestore setup failed: $e');
        await _auth.signOut();
        return 'firestore-user-create-failed';
      }

      Get.offAllNamed(Routes.HOME_SCREEN);

      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint(
        'Firebase login failed. Code: ${e.code}, Message: ${e.message}',
      );

      return e.code;
    } catch (e) {
      debugPrint('Firebase login unexpected error: $e');

      return 'unknown';
    } finally {
      isLoggingIn.value = false;
    }
  }

  // REGISTER
  Future<String?> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      isRegistering.value = true;

      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      debugPrint(
        'Firebase signup success. UID: ${userCredential.user?.uid ?? 'unknown'}',
      );

      // Update display name
      await userCredential.user?.updateDisplayName(name);

      // Send verification email
      await userCredential.user?.sendEmailVerification();

      await _auth.signOut();

      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint(
        'Firebase signup failed. Code: ${e.code}, Message: ${e.message}',
      );

      return e.code;
    } catch (e) {
      debugPrint('Firebase signup unexpected error: $e');

      return 'unknown';
    } finally {
      isRegistering.value = false;
    }
  }

  // LOGOUT
  Future<void> logout() async {
    try {
      await _auth.signOut();

      Get.offAllNamed(Routes.LOGIN_SCREEN);
    } catch (e) {
      Get.snackbar("Error", "Failed to logout");
    }
  }

  // RESET PASSWORD
  Future<String?> resetPassword(String email) async {
    try {
      isLoading.value = true;

      await _auth.sendPasswordResetEmail(email: email.trim());

      return null;
    } on FirebaseAuthException catch (e) {
      return FirebaseAuthErrorMapper.message(e.code);
    } catch (e) {
      return 'Failed to send reset email';
    } finally {
      isLoading.value = false;
    }
  }

  // UPDATE PROFILE
  Future<String?> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      isLoading.value = true;

      if (displayName != null || photoURL != null) {
        await _auth.currentUser?.updateDisplayName(displayName);

        await _auth.currentUser?.updatePhotoURL(photoURL);

        await _auth.currentUser?.reload();

        _user.value = _auth.currentUser;
      }

      return null;
    } catch (e) {
      return 'Failed to update profile';
    } finally {
      isLoading.value = false;
    }
  }

  // DELETE ACCOUNT
  Future<String?> deleteAccount() async {
    try {
      isLoading.value = true;

      final user = _auth.currentUser;

      if (user == null) {
        return 'No user is currently logged in';
      }

      await user.delete();

      Get.offAllNamed(Routes.LOGIN_SCREEN);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return 'Please login again to delete your account';
      }

      return FirebaseAuthErrorMapper.message(e.code);
    } catch (e) {
      return 'Failed to delete account';
    } finally {
      isLoading.value = false;
    }
  }

  // SEND EMAIL VERIFICATION
  Future<String?> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return 'user-not-found';
      }

      await user.sendEmailVerification();

      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint(
        'Send verification email failed. Code: ${e.code}, Message: ${e.message}',
      );
      return e.code;
    } catch (e) {
      debugPrint('Send verification email unexpected error: $e');
      return 'unknown';
    }
  }

  Future<String?> resendVerificationEmail({
    required String email,
    required String password,
  }) async {
    try {
      isLoggingIn.value = true;

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        await _auth.signOut();
        return 'user-not-found';
      }

      await user.reload();

      if (_auth.currentUser?.emailVerified ?? false) {
        await _createFirestoreUserIfNeeded(_auth.currentUser!);
        Get.offAllNamed(Routes.HOME_SCREEN);
        return null;
      }

      await user.sendEmailVerification();
      debugPrint('Verification email resent. UID: ${user.uid}');
      await _auth.signOut();

      return 'verification-email-sent';
    } on FirebaseAuthException catch (e) {
      debugPrint(
        'Resend verification failed. Code: ${e.code}, Message: ${e.message}',
      );
      await _auth.signOut();
      return e.code;
    } catch (e) {
      debugPrint('Resend verification unexpected error: $e');
      await _auth.signOut();
      return 'unknown';
    } finally {
      isLoggingIn.value = false;
    }
  }

  // USER DATA
  String get displayName => _user.value?.displayName ?? 'User';

  String get email => _user.value?.email ?? '';

  String? get photoURL => _user.value?.photoURL;

  bool get isEmailVerified => _user.value?.emailVerified ?? false;

  Future<void> _createFirestoreUserIfNeeded(User user) async {
    await _userService.createUser(
      UserModel(
        uid: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? _fallbackName(user.email),
        isVerified: true,
      ),
    );
  }

  String _fallbackName(String? email) {
    final trimmedEmail = email?.trim() ?? '';

    if (trimmedEmail.isEmpty || !trimmedEmail.contains('@')) {
      return 'User';
    }

    return trimmedEmail.split('@').first;
  }
}
