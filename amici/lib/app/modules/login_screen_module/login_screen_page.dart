import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:amici/app/modules/login_screen_module/login_screen_controller.dart';

import '../../../api_collection/dio_api_method.dart';
import '../../data/global_controllers/auth_controller.dart';
import '../../helper_widgets/hex_color.dart';
import '../../helper_widgets/no_leading_whitespace.dart';
import '../../helper_widgets/submit_button_helper.dart';
import '../../helper_widgets/text_widget.dart';
import '../../helper_widgets/textfield_widget.dart';
import '../../helper_widgets/validators.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_colors.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */


class LoginScreenPage extends GetView<LoginScreenController> {
  final LoginScreenController loginScreenController = Get.find<LoginScreenController>();
  final AuthController authController = Get.find<AuthController>();
  LoginScreenPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: loginScreenController,
      builder: (logic) {
        return Scaffold(
          backgroundColor:Colors.white,
          body: SafeArea(
            child: GestureDetector(
              onTap: ()=>FocusScope.of(context).unfocus(),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 6.h, left: 5.w,bottom: 4.h),
                    height: 30.h,
                    width: double.maxFinite,
                    decoration:  BoxDecoration(
                        color: Colors.black.withOpacity(0.10),
                        image: DecorationImage(image: AssetImage("assets/images/Amici-Fashion.png"), fit: BoxFit.contain)
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
                    margin: EdgeInsets.only(top: 30.h),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(2.h),topRight: Radius.circular(2.h)),
                      color: whiteColor,
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Text("Welcome back !",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: "Poppins-Bold", fontSize: 20.sp)),
                        SizedBox(
                          height: 4.h,
                        ),
                        TextFieldWidget(
                            labelTextFontWeight: FontWeight.w600,
                            hintText: "Enter here",
                            labelText: "Email",
                            textInputFormatter: [
                              FilteringTextInputFormatter.deny(RegExp('(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'))
                            ],
                            controller: loginScreenController.emailController,
                            contentPadding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                            hintStyle: TextStyle(color: Colors.black, fontSize: 10.sp,),
                            style: TextStyle(color: blackColor, fontSize: 12.sp),
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                               Icon(Icons.mail,color: Colors.black,),
                                SizedBox(width: 4.w),
                                Container(
                                  height: 2.8.h,
                                  width: 0.2.w,
                                  color: HexColor("#45648B"),
                                )
                              ],
                            ),
                            borderRadius: 2.w,
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next),
                        SizedBox(
                          height: 4.h,
                        ),
                        Obx(() => TextFieldWidget(
                            labelTextFontWeight: FontWeight.w600,
                            hintText: "Enter here",
                            labelText: "Password",
                            textInputFormatter: [
                              LengthLimitingTextInputFormatter(30),
                              NoSpaceFormatter(),
                            ],
                            obscureText: loginScreenController.isObscure.value,
                            suffixIcon: GestureDetector(
                              onTap: (){
                                loginScreenController.isObscure.value = !loginScreenController.isObscure.value;
                              },
                              child:
                              loginScreenController.isObscure.value ?
                              Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Icon(Icons.visibility_off,color: Colors.black,)):
                              Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Icon(Icons.visibility,color: Colors.black,)),
                            ),
                            controller: loginScreenController.passwordController,
                            contentPadding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                            hintStyle: TextStyle(color: Colors.black, fontSize: 10.sp),
                            style: TextStyle(color: blackColor, fontSize: 12.sp),
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.lock,color: Colors.black,),
                                SizedBox(width: 4.w),
                                Container(
                                  height: 2.8.h,
                                  width: 0.2.w,
                                  color: HexColor("#45648B"),
                                )
                              ],
                            ),
                            borderRadius: 2.w,
                            textInputAction: TextInputAction.done)),
                        SizedBox(
                          height: 2.h,
                        ),
                        GestureDetector(
                          onTap: (){
                            // Get.toNamed(Routes.FORGOT_PASSWORD_SCREEN);
                          },
                          child: Text("Forgot password?",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.black,
                                   decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins-Bold",
                                  fontSize: 10.sp)),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Obx(() => authController.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : SubmitButtonHelper(
                          text: "Login",
                          onTap: () {
                            FocusScope.of(context).unfocus();

                            final email = loginScreenController.emailController.text.trim();
                            final password = loginScreenController.passwordController.text.trim();

                            // validate email
                            if (Validators().validateEmailForm(email) != null) {
                              Get.snackbar("Error", "Please enter a valid email.");
                              return;
                            }

                            // validate password
                            if (password.isEmpty) {
                              Get.snackbar("Error", "Password can't be empty.");
                              return;
                            }

                            // call Firebase login
                            authController.login(email, password);
                          },
                        )),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                                text: "Don't have any account? ",
                                size: 12.sp,
                                alignment: TextAlign.center,
                                color: Colors.black,
                                bold: FontWeight.w400),
                            GestureDetector(
                              onTap: (){
                                Get.offAllNamed(Routes.SIGN_UP_SCREEN);

                              },
                              child: TextWidget(
                                  text: "Sign Up",
                                  size: 12.sp,
                                  alignment: TextAlign.center,
                                  color: Colors.black,
                                  bold: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
