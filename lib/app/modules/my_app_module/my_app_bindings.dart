import 'package:get/get.dart';

import 'my_app_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MyAppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAppController());
  }
}