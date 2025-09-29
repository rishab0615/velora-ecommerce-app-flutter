import 'package:get/get.dart';

import '../../data/services/cart_service.dart';
import '../my_cart_module/my_cart_controller.dart';
import '../store_screen_module/store_screen_controller.dart';
import 'home_screen_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HomeScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => StoreScreenController());
    Get.lazyPut(() => CartService());
    Get.lazyPut(() => MyCartController());

  }
}