import 'package:amici/app/modules/view_all_module/view_all_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ViewAllBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewAllController());
  }
}