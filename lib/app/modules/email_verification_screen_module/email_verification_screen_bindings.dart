import 'package:amici/app/modules/email_verification_screen_module/email_verification_screen_controller.dart';
import 'package:get/get.dart';

// GetX Template Generator - fb.com/htngu.99

class EmailVerificationScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmailVerificationController());
  }
}
