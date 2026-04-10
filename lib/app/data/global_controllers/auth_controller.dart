import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

import '../../modules/wishlist_module/wishlist_controller.dart';
import '../../routes/app_pages.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  Rx<UserModel?> user = Rx<UserModel?>(null);
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed(Routes.LOGIN_SCREEN);
    } else {
      if (!user.emailVerified) {
        Get.offAllNamed(Routes.EMAIL_VERIFICATION_SCREEN);
      } else {
        _fetchUserData(user.uid);
        Get.offAllNamed(Routes.HOME_SCREEN);
      }
    }
  }

  // Fetch User Data
  Future<void> _fetchUserData(String uid) async {
    try {
      DocumentSnapshot doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        user.value = UserModel.fromFirestore(doc);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Register User
  Future<void> register(String email, String password, String name,String phoneNumber) async {
    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await cred.user?.sendEmailVerification();

      await firestore.collection("users").doc(cred.user!.uid).set({
        "uid": cred.user!.uid,
        "name": name,
        "phoneNumber":phoneNumber,
        "email": email,
        "createdAt": DateTime.now(),
      });

      Get.snackbar("Success", "Account created. Please verify your email.");
    } catch (e) {
      print(e);
    }
  }

  // Login
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      UserCredential cred = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = cred.user;

      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          // Keep the session active; route to verification screen
          Get.offAllNamed(Routes.EMAIL_VERIFICATION_SCREEN);
        } else {
          await _fetchUserData(user.uid);
          // Initialize wishlist after successful login
          await Get.find<WishlistController>().initialize();
          Get.offAllNamed(Routes.HOME_SCREEN);
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> deleteAccount() async {
    try {
      final user = auth.currentUser;
      if (user == null) throw Exception('No user logged in');

      // Get user data before deleting (if needed for cleanup)
      final userDoc = await firestore.collection('users').doc(user.uid).get();

      // Delete user data from Firestore
      await firestore.collection('users').doc(user.uid).delete();

      // Delete user's authentication account
      await user.delete();


    } catch (e) {
      print('Error deleting account: $e');
      rethrow; // Re-throw to handle in the UI
    }
  }
  // Logout
  Future<void> logout() async {
    try {
      // Reset wishlist before logging out
      Get.find<WishlistController>().reset();
      await auth.signOut();
      user.value = null;
      Get.offAllNamed(Routes.LOGIN_SCREEN);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar("Error", "Failed to logout. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
