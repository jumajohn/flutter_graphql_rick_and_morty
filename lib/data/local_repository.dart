import 'dart:ffi';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static Future<void> saveData(dynamic data) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      String jsonData = json.encode(data);
      await prefs.setString("initialData", jsonData);
    } catch (e) {
      throw e;
    }
  }

  static Future<List> getData() async {
    List data = [];
    try {
      final prefs = await SharedPreferences.getInstance();
      String jsonData = prefs.getString("initialData").toString();
      data = json.decode(jsonData);
      return data;
    } catch (e) {
      return data;
    }
  }
}
