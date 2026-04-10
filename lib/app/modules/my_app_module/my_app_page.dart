import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_theme.dart';
import 'my_app_controller.dart';

class MyAppPage extends GetView<MyAppController> {
  const MyAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder:(context, orientation, deviceType){
          return  GetMaterialApp(
            title: "Amici | Made In Italy",
            theme: appThemeData,
            initialBinding: BindingsBuilder(() {
            }),
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            getPages: AppPages.pages,
            builder: (context, widget) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!);
            },
            initialRoute: Routes.SPLASH_SCREEN,
          );
        }
    );
  }
}
