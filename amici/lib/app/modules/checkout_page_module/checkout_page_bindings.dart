import 'package:amici/app/modules/checkout_page_module/checkout_page_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CheckoutPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckoutPageController());
  }
}