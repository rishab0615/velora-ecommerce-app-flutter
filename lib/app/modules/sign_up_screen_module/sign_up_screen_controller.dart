
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';

import '../../data/repositories/auth_repository.dart';

class SignUpScreenController extends GetxController {
  final AuthRepository _repo = AuthRepository();

  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  Country selectedCountry = Country.parse('IN');

  String get selectedCountryCode => "+${selectedCountry.phoneCode}";

  bool checkBoxValue = false;

  RxBool isObscure = true.obs;
  RxBool isComfirmPassObscure = true.obs;
  RxBool isLoading = false.obs;

  void updateCountry(Country country) {
    selectedCountry = country;
    update();
  }

  Future<void> handleSignUp() async {
    try {
      isLoading.value = true;

      await _repo.register(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: companyNameController.text.trim(),
        phone: "$selectedCountryCode${phoneController.text.trim()}",
      );

      Get.snackbar("Success", "Account created");

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}