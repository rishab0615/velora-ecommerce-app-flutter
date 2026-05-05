import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../data/controllers/auth_controller.dart';
import '../../helper_widgets/custom_nav_bar.dart';
import '../../helper_widgets/hex_color.dart';
import '../../helper_widgets/text_widget.dart';
import '../../routes/app_pages.dart';
import 'home_screen_controller.dart';

class HomeScreenPage extends GetView<HomeScreenController> {
  final HomeScreenController homeScreenController = Get.find<HomeScreenController>();
  final AuthController authController = Get.find<AuthController>();

  HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: homeScreenController,
      builder: (logic) {
        return GestureDetector(
          onTap: ()=>FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: 8.h,
              elevation: 0,
              backgroundColor: Colors.white,
              leadingWidth: 40.w,
              leading: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 4.w),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    TextWidget(text: "Hello,", size: 10.sp, bold: FontWeight.w400,color: HexColor("#575757"),),
                    Padding(
                      padding: EdgeInsets.only(top: 1.6.h),
                      child: Obx(()=> TextWidget(text: authController.displayName,overflow: TextOverflow.ellipsis, size: 20.sp, bold: FontWeight.w600,color: Colors.black,)),
                    ),
                  ],
                ),
              ),
              actions: [
                Container(
                    width: 34.w,
                    padding: EdgeInsets.only(right: 4.w, top: 1.6.h),
                    child: Image.asset("assets/images/velora.png")),
              ],
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                // padding: EdgeInsets.only(bottom: 1.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1), // Shadow color
                      spreadRadius: 1.8.w, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomNavBarItem(
                      svg: "assets/images/home.svg",
                      label: 'Store',
                      isSelected: homeScreenController.currentIndex == 0,
                      onTap: () {
                        homeScreenController.currentIndex = 0;
                        homeScreenController.update();
                      }, selectedSvg: 'assets/images/selectedHome.svg',
                    ),
                    CustomNavBarItem(
                      svg: "assets/images/shopping-cart-outline.svg",
                      label: 'My Cart',
                      isSelected: homeScreenController.currentIndex == 1,
                      onTap: () async{
                        homeScreenController.currentIndex = 1;
                        homeScreenController.update();
                      }, selectedSvg: "assets/images/shopping-cart-filled-commercial-symbol.svg",
                    ),
                    CustomNavBarItem(
                      svg: "assets/images/user.svg",
                      label: 'Profile',
                      isSelected: homeScreenController.currentIndex == 2,
                      onTap: () async{
                        homeScreenController.currentIndex = 2;
                        homeScreenController.update();
                      }, selectedSvg: "assets/images/selectedUser.svg",
                    ),

                  ],
                ),
              ),
            ),
            body: homeScreenController.widgetOptions.elementAt(homeScreenController.currentIndex),
          ),
        );
      },
    );
  }
}
