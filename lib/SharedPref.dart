import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String user = "user";

  Future<String> save(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value).then((saved) {
      return saved;
    });
  }

  Future<String> get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.clear();
  }
}
