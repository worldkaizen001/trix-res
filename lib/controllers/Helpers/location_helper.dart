
import 'dart:convert';
import 'package:http/http.dart' as http;



class LocationHelper {


Future<List> getLocation (String location) async {

 try {
      var url = Uri.parse("https://nominatim.openstreetmap.org/search.php?q=$location&polygon_geojson=1&format=json");
      print(url);

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        var data = jsonDecode(response.body);

        return data;
      }
    } catch (e) {
      print(e.toString());
    }

    return [];

}


static Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(
      Uri.parse(url),
    );
    // print("Place Response: ${response.body}");
    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodedData = jsonDecode(jsonData);
        return decodedData;
      } else {
        return "failed";
      }
    } catch (error) {
      return "failed";
    }
  }

}