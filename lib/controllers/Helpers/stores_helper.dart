
import 'dart:convert';
import 'package:restaurant/resources/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StoresHelper {

  Future<List> getStores() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    // ?show=11

    try {
      // var url = Uri.parse(route(Endpoints.stores));
            var url = Uri.parse("https://charissa.trixdesk.com/api/service/stores?show=26,27");
      // var url = Uri.parse("https://charissa.trixdesk.com/api/service/stores?show=17,20,21,19,22,23,25");


      print(url);

      final response = await http.get(url,
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

}
