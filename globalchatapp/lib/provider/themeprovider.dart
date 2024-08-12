import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themeprovider extends ChangeNotifier {
  // Obtain shared preferences.
  bool isDarkModeOn = false;
  Themeprovider() {
    loadData();
  }
  void updateData({required bool data}) async {
    isDarkModeOn = data;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme', data);
    notifyListeners();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkModeOn = prefs.getBool('theme') ?? true;
    notifyListeners();
  }
}
