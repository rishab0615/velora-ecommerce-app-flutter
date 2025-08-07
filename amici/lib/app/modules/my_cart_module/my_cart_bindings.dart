import 'package:amici/app/modules/my_cart_module/my_cart_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MyCartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyCartController());
  }
}