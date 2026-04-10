import 'package:amici/app/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'email_verification_screen_controller.dart';

class EmailVerificationPage extends StatelessWidget {
  EmailVerificationPage({super.key});

  final controller = Get.find<EmailVerificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Verify Your Email"),
        centerTitle: true,
        elevation: 0,
        backgroundColor:blackColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Obx(() {
            if (controller.isEmailVerified.value) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified, color: Colors.green, size: 80),
                  SizedBox(height: 20),
                  Text(
                    "Your email has been verified!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.email, color: blackColor, size: 80),
                  const SizedBox(height: 20),
                  const Text(
                    "A verification email has been sent.\nPlease check your inbox.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  Obx(() => ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text("Resend Email"),
                    onPressed: controller.canResendEmail.value
                        ? controller.sendVerificationEmail
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blackColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  )),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAllNamed("/login"); // back to login
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
