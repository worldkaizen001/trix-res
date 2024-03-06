
import 'dart:convert';
import 'package:restaurant/resources/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryHelper {

  Future<Map> getCategory(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    try {
      var url = Uri.parse(route("${Endpoints.categories}/$id"));

      final response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = jsonDecode(response.body)["data"];

        return data;
      
      }
    } catch (e) {
      print(e.toString());
    }

    return {};
  }

}
