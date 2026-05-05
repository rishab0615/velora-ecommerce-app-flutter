import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api_collection/dio_api_method.dart';
import '../../data/controllers/auth_controller.dart';
import '../../helper_widgets/validators.dart';

class LoginScreenController extends GetxController {
  final AuthController _authController = AuthController.instance;
  final AppValidators _validators = AppValidators();

  final loginFormKey = GlobalKey<FormState>();
  final RxBool isObscure = true.obs;
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool get isLoading => _authController.isLoggingIn;

  bool get isValid => emailError.value.isEmpty && passwordError.value.isEmpty;

  void onEmailChanged(String value) {
    emailController.value = TextEditingValue(
      text: value.toLowerCase(),
      selection: emailController.selection,
    );
    validateForm();
  }

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }

  void validateForm() {
    emailError.value = _validators.validateEmail(emailController.text) ?? '';
    passwordError.value =
        _validators.validatePassword(passwordController.text) ?? '';
  }

  Future<void> submitLogin() async {
    validateForm();
    if (!isValid) {
      DioClient.get().toAst(_firstValidationError());
      return;
    }

    await _authController.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  String _firstValidationError() {
    return [
      emailError.value,
      passwordError.value,
    ].firstWhere((error) => error.isNotEmpty);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
