import 'package:amici/app/modules/store_screen_module/store_screen_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class StoreScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoreScreenController());
  }
}