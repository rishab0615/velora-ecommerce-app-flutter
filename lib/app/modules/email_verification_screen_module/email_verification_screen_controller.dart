import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../routes/app_pages.dart';

class EmailVerificationController extends GetxController {
  var isEmailVerified = false.obs;
  var canResendEmail = false.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified.value) {
      Future.delayed(const Duration(seconds: 5), () {
        canResendEmail.value = true;
      });

      // Check every 3 seconds if email is verified
      timer = Timer.periodic(const Duration(seconds: 3), (_) async {
        await FirebaseAuth.instance.currentUser!.reload();
        isEmailVerified.value =
            FirebaseAuth.instance.currentUser!.emailVerified;

        if (isEmailVerified.value) {
          timer?.cancel();
          Get.offAllNamed(Routes.HOME_SCREEN); // Redirect to home screen
        }
      });
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      canResendEmail.value = false;
      await Future.delayed(const Duration(seconds: 5));
      canResendEmail.value = true;
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
