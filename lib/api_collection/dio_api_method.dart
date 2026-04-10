import 'package:amici/api_collection/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../app/helper_widgets/hex_color.dart';
import '../app/routes/app_pages.dart';
import 'api_url_collection.dart';
import 'package:get/get.dart' as g;
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DioClient {
  DioClient._();

  static DioClient? _instance;

  static DioClient get() {
    _instance ??= DioClient._();
    return _instance!;
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiUrl.base,
  ));

  Future dioGetMethod(String url) async {
    try {
      Response response = await _dio.get(url,
          options: Options(headers: {
            "Authorization":
                "Bearer ${await PreferenceManager.get().getAccessToken()}"
          }));
      if (response.statusCode == 200) {
        return response;
      } else {
        toAst(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      // toAst(e.toString());
      if (e.response?.statusCode == 401) {
        print("error------>>>${e.response?.statusCode}");
        await PreferenceManager.get().preferenceClear();
        g.Get.offAllNamed(Routes.LOGIN_SCREEN);
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        toAst('check your connection');
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        toAst('unable to connect to the server');
        return;
      }

      if (e.type == DioErrorType.other) {
        toAst('No Internet Connection');
        return;
      }
    } catch (e) {}
  }

  Future dioPostMethod(String url, dynamic body) async {
    try {
      Response response = await _dio.post(url,
          data: body,
          options: Options(sendTimeout: 5000, headers: {
            "Authorization":
                "Bearer ${await PreferenceManager.get().getAccessToken()}"
          }));
      if (response.statusCode == 200) {
        return response;
      } else {
        toAst(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      //toAst(e.toString());
      if (e.response?.statusCode == 401) {
        print("error------>>>${e.response?.statusCode}");
        await PreferenceManager.get().preferenceClear();
        g.Get.offAllNamed(Routes.LOGIN_SCREEN);
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        toAst('check your connection');
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        toAst('unable to connect to the server');
        return;
      }

      if (e.type == DioErrorType.other) {
        toAst('No Internet Connection');
        return;
      }
    } catch (e) {}
  }

  toAst(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black12,
        textColor: Colors.black,

        fontSize: 12.sp);
  }
}
