import 'dart:convert';

import 'package:restaurant/resources/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardHelper {
  List<dynamic> stores = [];

  Future<List> getStores() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    try {
      var url = Uri.parse(route(Endpoints.stores));

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List data = jsonDecode(response.body)["data"];

        return data;
      }
    } catch (e) {
      print(e.toString());
    }

    return [];
  }

  Future<dynamic> getProducts(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse(route(Endpoints.products));
      print(url);

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print(response.statusCode);

        var data = jsonDecode(response.body);
        // var title = jsonDecode(response.body)["data"][0]["name"];
        // print(title);

        return data;
      } else if (response.statusCode == 400) {
        var data = jsonDecode(response.body)["message"];
        print(response.statusCode);
        print(data);
      } else if (response.statusCode == 404) {
        var data = jsonDecode(response.body)["message"];
        print(response.statusCode);
        print(data);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> getCategories(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse(route(Endpoints.categories));
      print(url);

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print(response.statusCode);

        var data = jsonDecode(response.body);
        // var title = jsonDecode(response.body)["data"][0]["name"];
        // print(title);

        return data;
      } else if (response.statusCode == 400) {
        var data = jsonDecode(response.body)["message"];
        print(response.statusCode);
        print(data);
      } else if (response.statusCode == 404) {
        var data = jsonDecode(response.body)["message"];
        print(response.statusCode);
        print(data);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
