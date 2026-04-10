import 'package:get/get.dart';

import 'onboarding_screen_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class OnboardingScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingScreenController());
  }
}