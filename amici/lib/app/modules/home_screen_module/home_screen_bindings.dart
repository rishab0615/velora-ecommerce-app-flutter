import 'package:get/get.dart';

import 'home_screen_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HomeScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
  }
}