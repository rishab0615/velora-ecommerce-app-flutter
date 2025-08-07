import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:country_list_pick/support/code_country.dart';

/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SignUpScreenController extends GetxController{
  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  String selectedCountryCode = '';
  void onCountryChange(CountryCode? countryCode) {
    selectedCountry = countryCode!;
    print("code${countryCode.dialCode}");
    print("code${countryCode.code}");
    update();
  }


  String deviceToken = "";
  CountryCode selectedCountry = CountryCode(dialCode: "+234");
  bool checkBoxValue = false;
  RxBool isObscure = true.obs;
  RxBool isComfirmPassObscure = true.obs;
  //SignUpApi
  bool isLoading = false;



}
