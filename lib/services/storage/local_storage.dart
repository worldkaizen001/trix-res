import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', value);
   
  }

  Future<void> saveUserID(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', value);
   
  }
  Future<void> getName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fname', value);
   
  }

  saveUser(resUser) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("user", resUser);
    // print("Inside saveUser");
    // print(resUser);
  }

  getSavedUser() async {
    final SharedPreferences prefs = await _prefs;
    var data = prefs.getString("user");
    return jsonDecode(data ?? "{}");
  }
}
