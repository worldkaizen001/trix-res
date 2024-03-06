import 'dart:convert';

import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartHelper {
List<dynamic> checkoutCart = [];

  Future<List> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    try {
      var url = Uri.parse(route(Endpoints.cart));

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        var data = jsonDecode(response.body)["data"];
        // cartItem = data;
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  Future<bool> addToCart(context, Map body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse(route(Endpoints.cart));
      print(url);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
        body: jsonEncode(body),
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        return true;
      }
    } catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<bool> updateCart( Map data, id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse("https://charissa.trixdesk.com/api/user/cart/$id");
      print(url);

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
        body: jsonEncode(data),
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);

        return true;
      }
    } catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<bool> deleteFromCart(dynamic id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse("https://charissa.trixdesk.com/api/user/cart/$id");
      print(url);

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);

        var data = jsonDecode(response.body);
        return true;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }


}
