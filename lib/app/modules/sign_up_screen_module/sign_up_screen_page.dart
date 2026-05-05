import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amici/app/modules/sign_up_screen_module/sign_up_screen_controller.dart';
import 'package:sizer/sizer.dart';

import 'widgets/sign_up_form_card.dart';

class SignUpScreenPage extends GetView<SignUpScreenController> {
  const SignUpScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // SizedBox(height: 2.h),

              // 🔥 Logo (balanced size)
              SizedBox(
                height: 14.h,
                child: Image.asset(
                  "assets/images/veloralight.png",
                  fit: BoxFit.fill,
                ),

              ),


              // 🔥 Form (scrollable only here)
              Expanded(
                child: SignUpFormCard(controller: controller),
              ),
            ],
          ),
        ),
      ),
    );
  }
}