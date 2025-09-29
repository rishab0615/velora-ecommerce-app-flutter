import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ForgotPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // UI state
  final emailController = TextEditingController();
  final isLoading = false.obs;
  final errorText = RxnString();
  final successText = RxnString();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  bool _isValidEmail(String email) {
    final pattern = RegExp(r'^\S+@\S+\.[a-zA-Z]{2,}$');
    return pattern.hasMatch(email.trim());
  }

  Future<void> sendResetEmail() async {
    final email = emailController.text.trim();
    errorText.value = null;
    successText.value = null;

    if (email.isEmpty || !_isValidEmail(email)) {
      errorText.value = 'Please enter a valid email address.';
      return;
    }

    try {
      isLoading.value = true;
      await _auth.sendPasswordResetEmail(email: email);
      successText.value = 'Password reset link sent to $email';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          errorText.value = 'No account found for this email.';
          break;
        case 'invalid-email':
          errorText.value = 'The email address is invalid.';
          break;
        case 'too-many-requests':
          errorText.value = 'Too many attempts. Please try again later.';
          break;
        default:
          errorText.value = e.message ?? 'Failed to send reset email.';
      }
    } catch (e) {
      errorText.value = 'Something went wrong. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
}
