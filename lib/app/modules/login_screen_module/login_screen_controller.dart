import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api_collection/dio_api_method.dart';
import '../../data/controllers/auth_controller.dart';
import '../../utils/firebase_auth_error_handler.dart';
import '../../utils/validators.dart';

class LoginScreenController extends GetxController {
  final AuthController _authController = AuthController.instance;
  final AppValidators _validators = AppValidators();

  final loginFormKey = GlobalKey<FormState>();
  final RxBool isObscure = true.obs;
  final RxString emailError = ''.obs;
  final RxString authError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxBool canResendVerification = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool get isLoading => _authController.isLoggingIn;

  bool get isValid => emailError.value.isEmpty && passwordError.value.isEmpty;

  void onEmailChanged(String value) {
    emailController.value = TextEditingValue(
      text: value.toLowerCase(),
      selection: emailController.selection,
    );
    validateEmail();
  }

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }

  void validateEmail() {
    emailError.value = _validators.validateEmail(emailController.text) ?? '';
  }

  void validatePassword() {
    passwordError.value =
        _validators.validatePassword(passwordController.text) ?? '';
  }

  Future<void> submitLogin() async {
    authError.value = '';
    canResendVerification.value = false;

    validateEmail();
    validatePassword();

    if (!isValid) {
      DioClient.get().toAst(_firstValidationError());
      return;
    }

    final errorCode = await _authController.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (errorCode == null) {
      return;
    }

    authError.value = FirebaseAuthErrorMapper.message(errorCode);
    canResendVerification.value = errorCode == 'email-not-verified';
  }

  Future<void> resendVerificationEmail() async {
    authError.value = '';

    validateEmail();
    validatePassword();

    if (!isValid) {
      DioClient.get().toAst(_firstValidationError());
      return;
    }

    final errorCode = await _authController.resendVerificationEmail(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (errorCode == null) {
      return;
    }

    authError.value = FirebaseAuthErrorMapper.message(errorCode);
    canResendVerification.value = errorCode == 'verification-email-sent';
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
