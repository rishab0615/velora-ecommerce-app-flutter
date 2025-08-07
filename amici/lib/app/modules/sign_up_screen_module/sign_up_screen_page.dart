import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:amici/app/modules/sign_up_screen_module/sign_up_screen_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:country_list_pick/country_selection_theme.dart';

import '../../../api_collection/dio_api_method.dart';
import '../../helper_widgets/countryListPick.dart';
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

class SignUpScreenPage extends GetView<SignUpScreenController> {
  final SignUpScreenController signUpScreenController = Get.find<SignUpScreenController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: signUpScreenController,
        builder: (_){
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              body: GestureDetector(
                onTap: ()=>FocusScope.of(context).unfocus(),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 6.h, left: 5.w,bottom: 4.h),
                      height: 50.h,
                      width: double.maxFinite,
                      decoration:  BoxDecoration(
                          color: Colors.black.withOpacity(0.10),
                          image: DecorationImage(image: AssetImage("assets/images/Amici-Fashion.png"), fit: BoxFit.contain)
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
                      margin: EdgeInsets.only(top: 46.h),
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
                            labelText: "User Name",
                            textInputFormatter: [
                              LengthLimitingTextInputFormatter(30),
                              FilteringTextInputFormatter.deny(RegExp('(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'))

                            ],
                            controller: signUpScreenController.companyNameController,
                            contentPadding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                            hintStyle: TextStyle(color: Colors.black, fontSize: 10.sp),
                            style: TextStyle(color: blackColor, fontSize: 12.sp),
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.person,color: Colors.black,),
                                SizedBox(width: 4.w),
                                Container(
                                  height: 2.8.h,
                                  width: 0.2.w,
                                  color: HexColor("#45648B"),
                                )
                              ],
                            ),
                            borderRadius: 2.w,
                            textInputAction: TextInputAction.next,),
                          SizedBox(
                            height: 4.h,
                          ),
                          TextFieldWidget(
                            labelTextFontWeight: FontWeight.w600,
                            hintText: "Enter here",
                            labelText: "Email",
                            onChanged: (value) {
                              signUpScreenController.emailController.value = TextEditingValue(
                                  text: value.toLowerCase(),
                                  selection: signUpScreenController.emailController.selection
                              );
                            },
                            textInputFormatter: [
                              NoSpaceFormatter(),
                              FilteringTextInputFormatter.deny(RegExp('(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),

                            ],
                            controller: signUpScreenController.emailController,
                            contentPadding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                            hintStyle: TextStyle(color: Colors.black, fontSize: 10.sp),
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
                            textInputAction: TextInputAction.next,),
                          SizedBox(
                            height: 4.h,
                          ),
                          TextFieldWidget(
                            labelTextFontWeight: FontWeight.w600,
                            hintText: "Enter here",
                            labelText: "Phone",
                            controller: signUpScreenController.phoneController,
                            contentPadding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                            hintStyle: TextStyle(color: Colors.black, fontSize: 10.sp),
                            style: TextStyle(color: blackColor, fontSize: 12.sp),
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.phone, color: Colors.black,),
                                SizedBox(width: 4.w),
                                Container(
                                  height: 2.8.h,
                                  width: 0.2.w,
                                  color: HexColor("#45648B"),
                                ),
                                CountryListPick(
                                  appBar: AppBar(
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      centerTitle: true,
                                      actions: [
                                        GestureDetector(
                                          onTap: (){
                                            Get.back();
                                          },
                                          child: Padding(
                                            padding:  EdgeInsets.only(top: 2.h,right: 4.w),
                                            child: TextWidget(text: "Done", size: 12.sp, bold: FontWeight.w500,color: Colors.black,),
                                          ),
                                        ),
                                      ],
                                      title: TextWidget(text: "Country code", size: 12.sp, bold: FontWeight.w600,color:Colors.black,)
                                  ),
                                  theme: CountryTheme(
                                    isShowFlag: true,
                                    isShowTitle: false,
                                    isShowCode: true,
                                    isDownIcon: true,
                                    showEnglishName: true,
                                  ),
                                  initialSelection: signUpScreenController.selectedCountryCode.toString(),
                                  onChanged: signUpScreenController.onCountryChange,
                                ),
                              ],
                            ),
                            textInputType: TextInputType.phone,
                            borderRadius: 2.w,
                            textInputAction: TextInputAction.next,),
                          SizedBox(
                            height: 4.h,
                          ),
                          Obx(() =>  TextFieldWidget(
                            labelTextFontWeight: FontWeight.w600,
                            hintText: "Enter here",
                            labelText: "Password",
                            obscureText: signUpScreenController.isObscure.value,
                            textInputFormatter:[
                              LengthLimitingTextInputFormatter(30),
                              NoSpaceFormatter(),
                              // FilteringTextInputFormatter.deny(RegExp(r'[^\p{L}\p{N}\p{S}]')),
                            ],
                            suffixIcon: GestureDetector(
                              onTap: (){
                                signUpScreenController.isObscure.value = !signUpScreenController.isObscure.value;
                              },
                              child:
                              signUpScreenController.isObscure.value ?
                              Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Icon(Icons.visibility_off,color: Colors.black,)):
                              Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Icon(Icons.visibility,color: Colors.black,)),
                            ),
                            controller: signUpScreenController.passwordController,

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
                            textInputAction: TextInputAction.next,),),
                          SizedBox(
                            height: 4.h,
                          ),
                          Obx(() =>TextFieldWidget(
                            labelTextFontWeight: FontWeight.w600,
                            hintText: "Enter here",
                            labelText: "Confirm Password",
                            obscureText: signUpScreenController.isComfirmPassObscure.value,
                            textInputFormatter:[
                              LengthLimitingTextInputFormatter(30),
                              NoSpaceFormatter(),
                              // FilteringTextInputFormatter.deny(RegExp(r'[^\p{L}\p{N}\p{S}]')),
                            ],
                            suffixIcon: GestureDetector(
                              onTap: (){
                                signUpScreenController.isComfirmPassObscure.value = !signUpScreenController.isComfirmPassObscure.value;
                              },
                              child:
                              signUpScreenController.isComfirmPassObscure.value ?
                              Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Icon(Icons.visibility_off,color: Colors.black,)):
                              Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Icon(Icons.visibility,color: Colors.black,)),
                            ),
                            controller: signUpScreenController.confirmPassController,
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
                            textInputAction: TextInputAction.next,),),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.4.h),
                                ),
                                visualDensity: const VisualDensity(
                                    vertical: -4,
                                    horizontal: -4
                                ),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                checkColor: whiteColor,
                                activeColor: Colors.black,
                                value: signUpScreenController.checkBoxValue,
                                onChanged: (value) {
                                  signUpScreenController.checkBoxValue = value!;
                                  signUpScreenController.update();
                                },
                              ),
                              SizedBox(width: 2.w),
                              SizedBox(
                                width: 60.w,
                                child: RichText(
                                    maxLines: 2,
                                    text: TextSpan(
                                        text: "I Accept all ",
                                        style: TextStyle(
                                            height: 1.5,
                                            color: blackColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10.sp),
                                        children: [
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()..onTap = () {
                                              // Get.toNamed(Routes.TERMS_AND_CONDITIONS);
                                            },
                                            text: "Terms & Conditions",
                                            style: TextStyle(
                                              color: blackColor,
                                              fontWeight: FontWeight.w700,
                                              decoration: TextDecoration.underline,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " and ",
                                            style: TextStyle(
                                              color:blackColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // Get.toNamed(Routes.PRIVACY_POLICY);
                                              },
                                            text: "Privacy Policies",
                                            style: TextStyle(
                                              color: blackColor,
                                              fontWeight: FontWeight.w700,
                                              decoration: TextDecoration.underline,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ])),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          signUpScreenController.isLoading==false?
                          SubmitButtonHelper(
                              text: "Sign Up",
                              onTap: (){
                                FocusScope.of(context).unfocus();
                                if(Validators().validateCompanyName(signUpScreenController.companyNameController.text) != null){
                                   DioClient.get().toAst(Validators().validateCompanyName(signUpScreenController.companyNameController.text).toString());
                                  return;
                                }
                                if(Validators().validateEmailForm(signUpScreenController.emailController.text) != null){
                                   DioClient.get().toAst(Validators().validateEmailForm(signUpScreenController.emailController.text).toString());
                                  return;
                                }
                                if(Validators().validatePhone(signUpScreenController.phoneController.text) != null){
                                   DioClient.get().toAst(Validators().validatePhone(signUpScreenController.phoneController.text).toString());
                                  return;
                                }
                                if(Validators().validatePassword(signUpScreenController.passwordController.text) != null){
                                   DioClient.get().toAst(Validators().validatePassword(signUpScreenController.passwordController.text).toString());
                                  return;
                                }
                                if(Validators().validateConfirmPassword(signUpScreenController.confirmPassController.text, signUpScreenController.passwordController.text) != null){
                                   DioClient.get().toAst(Validators().validateConfirmPassword(signUpScreenController.confirmPassController.text,signUpScreenController.passwordController.text).toString());
                                  return;
                                }
                                if(signUpScreenController.checkBoxValue == false){
                                   DioClient.get().toAst("Please accept Terms & Conditions and Privacy Policies");
                                }
                                else{
                                  signUpScreenController.isLoading  = true;
                                  signUpScreenController.update();
                                }
                    
                              }
                          ):
                          Center(
                              child: CircularProgressIndicator(
                                color:Colors.black,)
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                  text: "Already have any account? ",
                                  size: 12.sp,
                                  alignment: TextAlign.center,
                                  color: Colors.black,
                                  bold: FontWeight.w400),
                              GestureDetector(
                                onTap: (){
                                  Get.offAllNamed(Routes.LOGIN_SCREEN);

                                },
                                child: TextWidget(
                                    text: "Login",
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
        });
  }
}
