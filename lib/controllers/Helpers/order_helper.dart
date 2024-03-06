import 'dart:convert';

import 'package:restaurant/resources/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrdersHelper {
  Future<Map> createOrder(context, Map body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse(route(Endpoints.orders));
      print(url);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
        body: jsonEncode(body),
      );
      var data = jsonDecode(response.body);

      // if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
      // }
    } catch (e) {
      print(e.toString());
    }

    return {};
  }

  Future<dynamic> completeOrder(Map data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    int id = data['id'];
    String reference = data['reference'];

    try {
      var url = Uri.parse(
          "https://charissa.trixdesk.com/api/user/orders/$id/complete");
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
        var data = jsonDecode(response.body);

        return {"error": false, "data": data};
      }
    } catch (e) {
      print(e.toString());
    }

    return {"error": true, "data": {}};
  }

  Future<dynamic> showOrder(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse("https://charissa.trixdesk.com/api/user/orders/$id");
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

       print("inside 200 ---> data $data");
        return data;
        
      }
    } catch (e) {
      print(e.toString());
    }

    return [];
  }

  
  
  Future<dynamic> getAllOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse("https://charissa.trixdesk.com/api/user/orders");
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
        var data = jsonDecode(response.body);

        print(data);

        return data;
      }
    } catch (e) {
      print(e.toString());
    }

    return [];
  }

  Future<dynamic> getPendingOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse("https://charissa.trixdesk.com/api/user/orders");
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
        List<dynamic> orders = data['data'];
        var pendingOrders = orders.where((order) {
          return order['status'] == 'pending';
        }).toList();
        print(pendingOrders);

        return pendingOrders;
      }
    } catch (e) {
      print(e.toString());
    }

    return [];
  }

  Future<dynamic> getCancelledOrders() async {
       final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse("https://charissa.trixdesk.com/api/user/orders");
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
        List<dynamic> orders = data['data'];
        var pendingOrders = orders.where((order) {
          return order['status'] == 'cancelled';
        }).toList();
        print(pendingOrders);

        return pendingOrders;
      }
    } catch (e) {
      print(e.toString());
    }

    return [];
  }
  Future<dynamic> getCompletedOrders() async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse("https://charissa.trixdesk.com/api/user/orders");
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
        List<dynamic> orders = data['data'];
        var pendingOrders = orders.where((order) {
          return order['status'] == 'completed';
        }).toList();
        print(pendingOrders);

        return pendingOrders;
      }
    } catch (e) {
      print(e.toString());
    }

    return [];
  }
}
