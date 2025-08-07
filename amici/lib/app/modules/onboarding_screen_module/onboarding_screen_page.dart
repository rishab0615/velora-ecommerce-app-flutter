import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../api_collection/shared_prefrences.dart';
import '../../helper_widgets/custom_circlular_indicator.dart';
import '../../helper_widgets/text_widget.dart';
import '../../routes/app_pages.dart';
import 'onboarding_screen_controller.dart';

class OnboardingScreenPage extends GetView<OnboardingScreenController> {
  final OnboardingScreenController onboardingScreenController = Get.find<OnboardingScreenController>();

  OnboardingScreenPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: onboardingScreenController,
      builder: (logic) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 4.h),

                  CircleAvatar(
                    radius: 16.h,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                        onboardingScreenController.onboardList[0] && onboardingScreenController.onboardList[1] == false && onboardingScreenController.onboardList[2] == false
                            ? "assets/images/AMICIS-4-1-819x1024.jpg.webp"
                            : onboardingScreenController.onboardList[0] && onboardingScreenController.onboardList[1] && onboardingScreenController.onboardList[2] == false
                            ? "assets/images/tDSC_1312_2_2048x.jpg.webp"
                            : onboardingScreenController.onboardList[0] && onboardingScreenController.onboardList[1] && onboardingScreenController.onboardList[2]
                            ? "assets/images/amici-clothing-popup.jpeg"
                            : ""),
                  ),
                  SizedBox(height: 6.h),
                  SizedBox(
                    height: 0.6.h,
                    child: ListView.builder(
                        itemCount: onboardingScreenController.onboardList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i){
                          return Container(
                            width: 8.w,
                            margin: EdgeInsets.symmetric(horizontal: 1.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0.4.h),
                                color: onboardingScreenController.onboardList[i] ? Colors.red : Colors.black
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                      onboardingScreenController.onboardList[0] && onboardingScreenController.onboardList[1] == false && onboardingScreenController.onboardList[2] == false
                          ? "Designed in Italy — Made for You"
                          : onboardingScreenController.onboardList[0] && onboardingScreenController.onboardList[1] && onboardingScreenController.onboardList[2] == false
                          ? " New Arrivals & Wardrobe Inspiration"
                          : onboardingScreenController.onboardList[0] && onboardingScreenController.onboardList[1] && onboardingScreenController.onboardList[2]
                          ? "Shop Confidently with Free Returns"
                          : "", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: "Poppins-Bold", fontSize: 16.sp,),textAlign: TextAlign.center,),
                  SizedBox(height: 0.6.h),
                  TextWidget(
                      text:   onboardingScreenController.onboardList[0] && onboardingScreenController.onboardList[1] == false && onboardingScreenController.onboardList[2] == false
                          ? "Discover exquisite fashion crafted with natural fibres and sophisticated style"
                          : onboardingScreenController.onboardList[0] && onboardingScreenController.onboardList[1] && onboardingScreenController.onboardList[2] == false
                          ? "Stay ahead with our curated seasonal edits and styling ideas"
                          : onboardingScreenController.onboardList[0] && onboardingScreenController.onboardList[1] && onboardingScreenController.onboardList[2]
                          ? "Enjoy free click‑and‑collect, fast delivery, and easy returns"
                          : "",
                      size: 10.sp,
                      alignment: TextAlign.center,
                      color: Colors.black,
                      bold: FontWeight.w400),
                  SizedBox(height: 3.h),
                  CircularPercentIndicator(
                    radius: 5.h,
                    animation: true,
                    animationDuration: 1200,
                    animateFromLastPercent: true,
                    lineWidth: 2,
                    percent: onboardingScreenController.percentValue,
                    widgetIndicator: Padding(
                      padding:  EdgeInsets.all(1.w),
                      child: SvgPicture.asset("assets/images/smallCircle.svg",color: Colors.red,),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Colors.red,
                    progressColor: Colors.black,
                    center: GestureDetector(
                      onTap: ()async{
                        if(onboardingScreenController.onboardList[1] == false){
                          onboardingScreenController.onboardList[1] = true;
                          onboardingScreenController.percentValue = 0.66;
                        }else if(onboardingScreenController.onboardList[2] == false && onboardingScreenController.onboardList[1] == true){
                          onboardingScreenController.onboardList[2] = true;
                          onboardingScreenController.percentValue = 1.0;
                          Timer(Duration(milliseconds: 1200), () {
                            Get.offAllNamed(Routes.LOGIN_SCREEN);
                          });
                        }
                        await PreferenceManager.get().setMainOnBoardValue(true);
                        onboardingScreenController.update();
                      },
                      child: Container(
                        height: 8.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset("assets/images/next_icon.svg", height: 2.h,color: Colors.red,),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  GestureDetector(
                    onTap: ()async{
                      await PreferenceManager.get().setMainOnBoardValue(true);
                      Get.offAllNamed(Routes.LOGIN_SCREEN);
                    },
                    child: TextWidget(
                        text: "Skip",
                        size: 14.sp,
                        alignment: TextAlign.center,
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        bold: FontWeight.w400),
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}
