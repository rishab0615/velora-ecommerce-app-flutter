import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OnboardingScreenController extends GetxController{
  @override
  void onInit() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.onInit();
  }
  List<bool> onboardList = [true, false, false];
  double percentValue = 0.33;
}
