import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {

  static Future<int> checkAndGetCurrentLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lvl = prefs.getInt("level");
    if (lvl == null) { setCurrentLevel(1); }
    return getCurrentLevel();
  }

  static Future<int> getCurrentLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("level");
  }

  static Future<bool> setCurrentLevel(int level) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt("level", level);
  }

}
