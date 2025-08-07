import 'dart:async';

import 'package:get/get.dart';

import '../../../api_collection/shared_prefrences.dart';
import '../../routes/app_pages.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SplashScreenController extends GetxController{

  @override
  void onInit() async{
    var pref = await PreferenceManager.get().getAccessToken();
    var isAppAlreadyInstalled = await PreferenceManager.get().getMainOnBoardValue();
    print("token---->${await PreferenceManager.get().getAccessToken()}");
    Timer(const Duration(seconds: 3), () {
    if(pref != null){
      Get.offAllNamed(Routes.HOME_SCREEN);
    }
    else if(pref == null && isAppAlreadyInstalled != null){
    Get.offAllNamed(Routes.LOGIN_SCREEN);
    }
    else if(pref == null && isAppAlreadyInstalled == null){
    Get.offNamed(Routes.ONBOARDING_SCREEN);
    }
    else{
    Get.offAllNamed(Routes.ONBOARDING_SCREEN);
    }
    });
    super.onInit();
  }

}
