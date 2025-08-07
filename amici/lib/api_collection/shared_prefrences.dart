import 'package:amici/api_collection/preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  PreferenceManager._();
  static PreferenceManager? _instance;
  static PreferenceManager get() {
    _instance ??= PreferenceManager._();
    return _instance!;
  }

  Future setAccessToken(String token) async {
    (await SharedPreferences.getInstance()).setString(PreferenceConstants.ACCESS_TOKEN, token);
  }

  Future getAccessToken() async {
    return (await SharedPreferences.getInstance()).getString(PreferenceConstants.ACCESS_TOKEN);
  }
  Future getMainOnBoardValue() async {
    return (await SharedPreferences.getInstance()).getBool(PreferenceConstants.showOnBoard);
  }
  Future setMainOnBoardValue(bool value) async {
    (await SharedPreferences.getInstance()).setBool(PreferenceConstants.showOnBoard, value);
  }

  Future setSpecificValue(String key, String value) async {
    (await SharedPreferences.getInstance()).setString(key, value);
  }

  Future getSpecificValue(String key) async {
    return (await SharedPreferences.getInstance()).getString(key);
  }

   preferenceClear() async {
    (await SharedPreferences.getInstance()).clear();
  }

  Future removeSpecificKey(String key) async {
    return (await SharedPreferences.getInstance()).remove(key);
  }
}