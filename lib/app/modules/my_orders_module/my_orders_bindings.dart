import 'package:amici/app/modules/my_orders_module/my_orders_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MyOrdersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyOrdersController());
  }
}