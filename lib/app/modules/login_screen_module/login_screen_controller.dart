import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class LoginScreenController extends GetxController {
  @override
  void onInit() async{}

  String deviceToken = "";
  final loginFormKey = GlobalKey<FormState>();
  RxBool isObscure = true.obs;
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

}
