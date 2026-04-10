import 'dart:async';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/services/storage_service.dart';
import '../../routes/app_pages.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SplashScreenController extends GetxController{
  final StorageService storageService = StorageService();

  @override
  void onInit() async{
    super.onInit();
    final bool hasSeenOnboarding = await storageService.hasSeenOnboarding();

    // Small splash delay for UX
    Timer(const Duration(seconds: 2), () async {
      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (!hasSeenOnboarding) {
        Get.offAllNamed(Routes.ONBOARDING_SCREEN);
        return;
      }

      // If user is already authenticated (Firebase persists sessions), keep them logged in
      if (currentUser != null) {
        if (currentUser.emailVerified) {
          Get.offAllNamed(Routes.HOME_SCREEN);
        } else {
          Get.offAllNamed(Routes.EMAIL_VERIFICATION_SCREEN);
        }
      } else {
        // Not authenticated yet
        Get.offAllNamed(Routes.LOGIN_SCREEN);
      }
    });
  }

}
