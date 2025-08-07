import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/modules/my_app_module/my_app_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyAppPage());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
