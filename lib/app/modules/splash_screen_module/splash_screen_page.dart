import 'dart:io';
import 'package:amici/app/modules/splash_screen_module/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_colors.dart';

class SplashScreenPage extends GetView<SplashScreenController> {
  final splashScreenController = Get.find<SplashScreenController>();

  SplashScreenPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: splashScreenController,
      builder: (logic) {
        return  Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.h),
              child: Image(image: AssetImage("assets/images/velora.png")),
            )
        );
      },
    );
  }
}
