import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:amici/app/modules/login_screen_module/login_screen_controller.dart';

import '../../helper_widgets/hex_color.dart';
import '../../helper_widgets/no_leading_whitespace.dart';
import '../../helper_widgets/submit_button_helper.dart';
import '../../helper_widgets/text_widget.dart';
import '../../helper_widgets/textfield_widget.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_colors.dart';

class LoginScreenPage extends GetView<LoginScreenController> {
  const LoginScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: [
                // Logo
                SizedBox(
                  height: 14.h,
                  child: Image.asset(
                    "assets/images/veloralight.png",
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 2.h),

                // Title
                Text(
                  "Welcome back!",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins-Bold",
                    fontSize: 20.sp,
                  ),
                ),

                SizedBox(height: 3.h),

                // Email Field
                Obx(
                  () => _LoginTextField(
                    label: "Email",
                    hint: "Enter your email",
                    icon: Icons.mail,
                    controller: controller.emailController,
                    errorText: controller.emailError.value,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: controller.onEmailChanged,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                        RegExp(
                          '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 3.h),

                // Password Field
                Obx(
                  () => _LoginTextField(
                    label: "Password",
                    hint: "Enter your password",
                    icon: Icons.lock,
                    controller: controller.passwordController,
                    obscureText: controller.isObscure.value,
                    errorText: controller.passwordError.value,
                    textInputAction: TextInputAction.done,
                    onChanged: (_) => controller.validateForm(),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                      NoSpaceFormatter(),
                    ],
                    suffixIcon: GestureDetector(
                      onTap: controller.togglePasswordVisibility,
                      child: Icon(
                        controller.isObscure.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 1.5.h),

                // 🔥 Forgot Password
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.FORGOT_PASSWORD);
                  },
                  child: Text(
                    "Forgot password?",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins-Bold",
                      fontSize: 10.sp,
                    ),
                  ),
                ),

                SizedBox(height: 4.h),

                // Login Button
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return SubmitButtonHelper(
                    text: "Log in",
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      controller.submitLogin();
                    },
                  );
                }),

                SizedBox(height: 4.h),

                // 🔥 Signup Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: "Don't have an account? ",
                      size: 12.sp,
                      alignment: TextAlign.center,
                      color: Colors.black,
                      bold: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(Routes.SIGN_UP_SCREEN);
                      },
                      child: TextWidget(
                        text: "Sign Up",
                        size: 12.sp,
                        alignment: TextAlign.center,
                        color: Colors.black,
                        bold: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginTextField extends StatelessWidget {
  const _LoginTextField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.errorText = '',
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final String errorText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldWidget(
          labelTextFontWeight: FontWeight.w600,
          hintText: hint,
          labelText: label,
          controller: controller,
          obscureText: obscureText,
          textInputFormatter: inputFormatters,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(vertical: 2.h),
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 10.sp,
          ),
          style: TextStyle(color: blackColor, fontSize: 12.sp),
          prefixIcon: _LoginFieldIcon(icon: icon),
          borderRadius: 2.w,
          textInputType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
        ),
        if (errorText.isNotEmpty) ...[
          SizedBox(height: 0.8.h),
          Text(
            errorText,
            style: TextStyle(
              color: Colors.red,
              fontSize: 9.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}

class _LoginFieldIcon extends StatelessWidget {
  const _LoginFieldIcon({
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.black),
        SizedBox(width: 4.w),
        Container(
          height: 2.8.h,
          width: 0.2.w,
          color: HexColor("#45648B"),
        ),
      ],
    );
  }
}
