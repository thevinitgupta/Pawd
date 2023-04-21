import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static Future<bool> hasLoggedIn() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(_loginKey) ?? false ;
  }

  static void setLoggedIn() {

  }
}

const _loginKey = "login_key";



