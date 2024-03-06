


import 'dart:convert';

import 'package:restaurant/resources/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductsHelper {

 Future<dynamic> searchProduct(String data, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            const Center(child: CircularProgressIndicator.adaptive()));

    try {
      var url = Uri.parse("https://charissa.trixdesk.com/api/service/search?query=$data");
      print(url);

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        var data = jsonDecode(response.body)["data"]["products"];
        print(data);
        print(response.statusCode);
        Navigator.pop(context);
        return {
          "status": false,
          "data": data,
        };
      }
    } catch (e) {
      print(e.toString());
              Navigator.pop(context);

    }
Navigator.pop(context);
    return {
          "status": true,
          "data": {},
        };

  }


}
