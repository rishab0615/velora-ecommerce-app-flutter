import 'package:amici/app/modules/wishlist_module/wishlist_controller.dart';
import 'package:get/get.dart';

/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class WishlistBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WishlistController());
  }
}