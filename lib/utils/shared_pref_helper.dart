import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static Future<bool> hasLoggedIn() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(_loginKey) ?? false ;
  }

  static void setLoggedIn(bool loggedIn) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(_loginKey, loggedIn);
  }
}

const _loginKey = "login_key";



