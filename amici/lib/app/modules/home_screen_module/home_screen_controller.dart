import 'package:amici/app/modules/my_cart_module/my_cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api_collection/api_url_collection.dart';
import '../../../api_collection/dio_api_method.dart';
import '../profile_screen_module/profile_screen_page.dart';
import '../store_screen_module/store_screen_page.dart';

class HomeScreenController extends GetxController {
  int currentIndex = 0;
  List widgetOptions = <Widget>[
    StoreScreenPage(),
    MyCartPage(),
    ProfileScreenPage(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

}
