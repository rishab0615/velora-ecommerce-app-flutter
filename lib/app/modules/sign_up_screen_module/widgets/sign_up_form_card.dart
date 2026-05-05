import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../helper_widgets/hex_color.dart';
import '../../../helper_widgets/no_leading_whitespace.dart';
import '../../../helper_widgets/submit_button_helper.dart';
import '../../../helper_widgets/text_widget.dart';
import '../../../helper_widgets/textfield_widget.dart';
import '../../../theme/app_colors.dart';
import '../sign_up_screen_controller.dart';

final _blockedCharactersFormatter = FilteringTextInputFormatter.deny(
  RegExp(
    '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
  ),
);

class SignUpFormCard extends StatelessWidget {
  const SignUpFormCard({
    super.key,
    required this.controller,
  });

  final SignUpScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(2.h)),
        color: whiteColor,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Text(
            "Create your account!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins-Bold",
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 2.h),
          _SignUpFieldsSection(controller: controller),
          SizedBox(height: 2.h),
          _SignUpTermsCheckbox(controller: controller),
          SizedBox(height: 2.h),
          _SignUpSubmitButton(controller: controller),
          SizedBox(height: 2.h),
          _SignUpLoginPrompt(controller: controller),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}

class _SignUpFieldsSection extends StatelessWidget {
  const _SignUpFieldsSection({
    required this.controller,
  });

  final SignUpScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => _SignUpTextField(
            label: "User Name",
            icon: Icons.person,
            controller: controller.usernameController,
            errorText: controller.usernameError.value,
            onChanged: (_) => controller.validateForm(),
            inputFormatters: [
              LengthLimitingTextInputFormatter(30),
              _blockedCharactersFormatter,
            ],
          ),
        ),
        _fieldGap,
        Obx(
          () => _SignUpTextField(
            label: "Email",
            icon: Icons.mail,
            controller: controller.emailController,
            errorText: controller.emailError.value,
            keyboardType: TextInputType.emailAddress,
            onChanged: controller.onEmailChanged,
            inputFormatters: [
              NoSpaceFormatter(),
              _blockedCharactersFormatter,
            ],
          ),
        ),
        _fieldGap,
        Obx(
          () => _SignUpTextField(
            label: "Password",
            icon: Icons.lock,
            controller: controller.passwordController,
            obscureText: controller.isPasswordObscure.value,
            errorText: controller.passwordError.value,
            onChanged: (_) => controller.validateForm(),
            suffixIcon: _VisibilityToggle(
              isObscure: controller.isPasswordObscure.value,
              onTap: controller.togglePasswordVisibility,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(30),
              NoSpaceFormatter(),
            ],
          ),
        ),
        _fieldGap,
        Obx(
          () => _SignUpTextField(
            label: "Confirm Password",
            icon: Icons.lock,
            controller: controller.confirmPasswordController,
            obscureText: controller.isConfirmPasswordObscure.value,
            errorText: controller.confirmPasswordError.value,
            onChanged: (_) => controller.validateForm(),
            suffixIcon: _VisibilityToggle(
              isObscure: controller.isConfirmPasswordObscure.value,
              onTap: controller.toggleConfirmPasswordVisibility,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(30),
              NoSpaceFormatter(),
            ],
          ),
        ),
      ],
    );
  }

  Widget get _fieldGap => SizedBox(height: 4.h);
}

class _SignUpTextField extends StatelessWidget {
  const _SignUpTextField({
    required this.label,
    required this.icon,
    required this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
    this.errorText = '',
  });

  final String label;
  final IconData icon;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final Widget? suffixIcon;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldWidget(
          labelTextFontWeight: FontWeight.w600,
          hintText: "Enter here",
          labelText: label,
          controller: controller,
          obscureText: obscureText,
          suffixIcon: suffixIcon,
          textInputFormatter: inputFormatters,
          textInputType: keyboardType,
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
          contentPadding: EdgeInsets.only(top: 2.h, bottom: 2.h),
          hintStyle: TextStyle(color: Colors.black, fontSize: 10.sp),
          style: TextStyle(color: blackColor, fontSize: 12.sp),
          borderRadius: 2.w,
          prefixIcon: _SignUpFieldIcon(icon: icon),
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

class _SignUpSubmitButton extends StatelessWidget {
  const _SignUpSubmitButton({
    required this.controller,
  });

  final SignUpScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.black));
        }

        return SubmitButtonHelper(
          text: "Sign Up",
          onTap: () {
            FocusScope.of(context).unfocus();
            controller.submitSignUp();
          },
        );
      },
    );
  }
}

class _SignUpFieldIcon extends StatelessWidget {
  const _SignUpFieldIcon({
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

class _VisibilityToggle extends StatelessWidget {
  const _VisibilityToggle({
    required this.isObscure,
    required this.onTap,
  });

  final bool isObscure;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Icon(
          isObscure ? Icons.visibility_off : Icons.visibility,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _SignUpTermsCheckbox extends StatelessWidget {
  const _SignUpTermsCheckbox({
    required this.controller,
  });

  final SignUpScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.4.h),
            ),
            visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            checkColor: whiteColor,
            activeColor: Colors.black,
            value: controller.isTermsAccepted.value,
            onChanged: controller.setTermsAccepted,
          ),
          SizedBox(width: 2.w),
          SizedBox(
            width: 60.w,
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                text: "I Accept all ",
                style: _termsStyle(FontWeight.w400),
                children: [
                  _linkSpan("Terms & Conditions"),
                  TextSpan(text: " and ", style: _termsStyle(FontWeight.w700)),
                  _linkSpan("Privacy Policies"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextSpan _linkSpan(String text) {
    return TextSpan(
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          // Get.toNamed(Routes.TERMS_AND_CONDITIONS);
        },
      text: text,
      style: _termsStyle(FontWeight.w700).copyWith(
        decoration: TextDecoration.underline,
      ),
    );
  }

  TextStyle _termsStyle(FontWeight weight) {
    return TextStyle(
      height: 1.5,
      color: blackColor,
      fontWeight: weight,
      fontSize: 10.sp,
    );
  }
}

class _SignUpLoginPrompt extends StatelessWidget {
  const _SignUpLoginPrompt({
    required this.controller,
  });

  final SignUpScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          text: "Already have any account? ",
          size: 12.sp,
          alignment: TextAlign.center,
          color: Colors.black,
          bold: FontWeight.w400,
        ),
        GestureDetector(
          onTap: controller.goToLogin,
          child: TextWidget(
            text: "Login",
            size: 12.sp,
            alignment: TextAlign.center,
            color: Colors.black,
            bold: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
