import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
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

  // Login method
  Future<void> login({
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
      Get.snackbar("Success", "Logged in successfully");
      _goToPostAuthRoute();
    } on FirebaseAuthException catch (e) {
      debugPrint(
        'Firebase login failed. Code: ${e.code}, Message: ${e.message}',
      );
      String message = _getErrorMessage(e.code);
      Get.snackbar("Login Failed", message);
    } catch (e) {
      debugPrint('Firebase login unexpected error: $e');
      Get.snackbar("Error", "An unexpected error occurred");
    } finally {
      isLoggingIn.value = false;
    }
  }

  // Register method
  Future<void> register({
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
      final uid = userCredential.user!.uid;

      final userModel = UserModel(
        uid: uid,
        email: email,
        name: name,
        isVerified: false,
      );

      await _userService.createUser(userModel);
      debugPrint(
        'Firebase signup success. UID: ${userCredential.user?.uid ?? 'unknown'}',
      );

      // Update display name
      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.sendEmailVerification();

      Get.snackbar("Success", "Account created successfully");
      Get.offAllNamed(Routes.EMAIL_VERIFICATION_SCREEN);
    } on FirebaseAuthException catch (e) {
      debugPrint(
        'Firebase signup failed. Code: ${e.code}, Message: ${e.message}',
      );
      String message = _getErrorMessage(e.code);
      Get.snackbar("Registration Failed", message);
    } catch (e) {
      debugPrint('Firebase signup unexpected error: $e');
      Get.snackbar("Error", "An unexpected error occurred");
    } finally {
      isRegistering.value = false;
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.snackbar("Success", "Logged out successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to logout");
    }
  }

  // Password reset
  Future<void> resetPassword(String email) async {
    try {
      isLoading.value = true;
      await _auth.sendPasswordResetEmail(email: email.trim());
      Get.snackbar("Success", "Password reset email sent");
    } on FirebaseAuthException catch (e) {
      String message = _getErrorMessage(e.code);
      Get.snackbar("Error", message);
    } catch (e) {
      Get.snackbar("Error", "Failed to send reset email");
    } finally {
      isLoading.value = false;
    }
  }

  // Update user profile
  Future<void> updateProfile({
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

      Get.snackbar("Success", "Profile updated successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile");
    } finally {
      isLoading.value = false;
    }
  }

  // Get user display name
  String get displayName => _user.value?.displayName ?? 'User';

  // Get user email
  String get email => _user.value?.email ?? '';

  // Get user photo URL
  String? get photoURL => _user.value?.photoURL;

  // Check if email is verified
  bool get isEmailVerified => _user.value?.emailVerified ?? false;

  // Send email verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
      Get.snackbar("Success", "Verification email sent");
    } catch (e) {
      Get.snackbar("Error", "Failed to send verification email");
    }
  }

  // Helper method to get user-friendly error messages
  String _getErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'Password should be at least 6 characters';
      case 'email-already-in-use':
        return 'An account already exists for this email';
      case 'user-not-found':
        return 'No user found for this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This user account has been disabled';
      case 'too-many-requests':
        return 'Too many requests. Try again later';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled';
      default:
        return 'An error occurred. Please try again';
    }
  }

  // Delete user account
  Future<void> deleteAccount() async {
    try {
      isLoading.value = true;

      final user = _auth.currentUser;
      if (user == null) {
        Get.snackbar("Error", "No user is currently logged in");
        return;
      }

      // Re-authenticate user might be needed for security-sensitive operations
      await user.delete();

      Get.snackbar("Success", "Account deleted successfully");
      Get.offAllNamed(Routes.LOGIN_SCREEN); // Navigate to login after deletion
    } on FirebaseAuthException catch (e) {
      String message = _getErrorMessage(e.code);
      if (e.code == 'requires-recent-login') {
        message =
            'Please log in again to delete your account for security reasons';
      }
      Get.snackbar("Error", message);
    } catch (e) {
      Get.snackbar("Error", "Failed to delete account. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Clean up any resources if needed
    super.onClose();
  }

  void _goToPostAuthRoute() {
    if (_auth.currentUser?.emailVerified ?? false) {
      Get.offAllNamed(Routes.HOME_SCREEN);
    } else {
      Get.offAllNamed(Routes.EMAIL_VERIFICATION_SCREEN);
    }
  }
}
