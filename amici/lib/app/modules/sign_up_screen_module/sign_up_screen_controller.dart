import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:country_list_pick/support/code_country.dart';
import '../../data/global_controllers/auth_controller.dart';

class SignUpScreenController extends GetxController {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  String selectedCountryCode = '';
  CountryCode selectedCountry = CountryCode(dialCode: "+234");
  bool checkBoxValue = false;

  RxBool isObscure = true.obs;
  RxBool isComfirmPassObscure = true.obs;
  RxBool isLoading = false.obs;

  void onCountryChange(CountryCode? countryCode) {
    selectedCountry = countryCode!;
    update();
  }

  /// Called when user presses SignUp button
  Future<void> handleSignUp() async {
    if (passwordController.text.trim() != confirmPassController.text.trim()) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    isLoading.value = true;

    final authController = Get.find<AuthController>();
    await authController.register(
      emailController.text.trim(),
      passwordController.text.trim(),
      companyNameController.text.trim(),
    );

    isLoading.value = false;
  }
}
