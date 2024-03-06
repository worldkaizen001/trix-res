import 'dart:convert';
import 'package:restaurant/controllers/Helpers/stores_helper.dart';
import 'package:restaurant/resources/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StoreProvider extends ChangeNotifier {
  List<dynamic> stores = [];

  Future<void> boot() async {

    stores = await StoresHelper().getStores();

    print("Stores data on boot $stores");

    notifyListeners();

  }

}