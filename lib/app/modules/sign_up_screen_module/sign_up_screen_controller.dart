import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../api_collection/dio_api_method.dart';
import '../../data/controllers/auth_controller.dart';
import '../../routes/app_pages.dart';
import '../../utils/firebase_auth_error_handler.dart';
import '../../utils/validators.dart';

class SignUpScreenController extends GetxController {
  final AuthController _authController = AuthController.instance;
  final AppValidators _validators = AppValidators();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxString usernameError = ''.obs;
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;
  final RxString authError = ''.obs;
  final RxBool isTermsAccepted = false.obs;
  final RxBool isPasswordObscure = true.obs;
  final RxBool isConfirmPasswordObscure = true.obs;
  RxBool get isLoading => _authController.isRegistering;

  bool get isValid =>
      usernameError.value.isEmpty &&
      emailError.value.isEmpty &&
      passwordError.value.isEmpty &&
      confirmPasswordError.value.isEmpty;

  void onEmailChanged(String value) {
    emailController.value = TextEditingValue(
      text: value.toLowerCase(),
      selection: emailController.selection,
    );
    validateForm();
  }

  void togglePasswordVisibility() {
    isPasswordObscure.value = !isPasswordObscure.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscure.value = !isConfirmPasswordObscure.value;
  }

  void setTermsAccepted(bool? value) {
    isTermsAccepted.value = value ?? false;
  }

  void validateForm() {
    authError.value = '';
    usernameError.value =
        _validators.validateUsername(usernameController.text) ?? '';
    emailError.value = _validators.validateEmail(emailController.text) ?? '';
    passwordError.value =
        _validators.validatePassword(passwordController.text) ?? '';
    confirmPasswordError.value = _validators.validateConfirmPassword(
          passwordController.text,
          confirmPasswordController.text,
        ) ??
        '';
  }

  void goToLogin() {
    Get.offAllNamed(Routes.LOGIN_SCREEN);
  }

  Future<void> submitSignUp() async {
    validateForm();
    if (!isValid) {
      DioClient.get().toAst(_firstValidationError());
      return;
    }

    if (!isTermsAccepted.value) {
      DioClient.get().toAst(
        "Please accept Terms & Conditions and Privacy Policies",
      );
      return;
    }

    final errorCode = await _authController.register(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: usernameController.text.trim(),
    );

    if (errorCode != null) {
      _showSignupAuthError(errorCode);
      return;
    }

    DioClient.get().toAst('Verification email sent. Please verify and login.');
    Get.offAllNamed(Routes.LOGIN_SCREEN);
  }

  void _showSignupAuthError(String errorCode) {
    final message = FirebaseAuthErrorMapper.message(errorCode);

    if (errorCode == 'email-already-in-use' || errorCode == 'invalid-email') {
      emailError.value = message;
      return;
    }

    if (errorCode == 'weak-password') {
      passwordError.value = message;
      return;
    }

    authError.value = message;
  }

  String _firstValidationError() {
    return [
      usernameError.value,
      emailError.value,
      passwordError.value,
      confirmPasswordError.value,
    ].firstWhere((error) => error.isNotEmpty);
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
