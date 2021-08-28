import 'package:shared_preferences/shared_preferences.dart';

class FeelingTodayPrefs {
  void setDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime dateToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    await prefs.setString('Date', dateToday.toString());
  }

  Future<String> getDate() async {
    String res;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    res = prefs.getString('Date') ?? "";
    return res;
  }

  void setStateOfMind(String stateOfMind) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('stateOfMind', stateOfMind);
  }

  Future<String> getStateOfMind() async {
    String res;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    res = prefs.getString('stateOfMind') ?? "";
    return res;
  }
}
