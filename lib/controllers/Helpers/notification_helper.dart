import 'dart:convert';

import 'package:restaurant/resources/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationHelper {
  Future<dynamic> getNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse(route(Endpoints.notifications));
      print(url);

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print(data);

        return data;
      }
    } catch (e) {
      print(e.toString());
    }

    return [];
  }

  Future<dynamic> getRewards() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse(
          "https://charissa.trixdesk.com/api/service/notifications?channel=points");
      print(url);

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print(data);

        return data;
      }
    } catch (e) {
      print(e.toString());
    }

    return [];
  }

  Future<dynamic> readNotification(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse(
          "https://charissa.trixdesk.com/api/service/notifications/$id?do=clear");
      print(url);

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print(data);

        return true;
      }
    } catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<dynamic> readAllNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse(
          "https://charissa.trixdesk.com/api/service/notifications/?do=clear");
      print(url);

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print(data);

        return true;
      }
    } catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<List> allUnredNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse(route(Endpoints.notifications));
      print(url);

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List data = jsonDecode(response.body)["data"];

// status

//
        var unRead = data.where((noti) => noti["status"] == "unread").toList();
        //  var unRead = data.where((noti){return noti["status"] == ["unread"];
        //  }).toList();

        return unRead;
      }
    } catch (e) {
      print(e.toString());
    }

    return [];
  }
}
