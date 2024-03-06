import 'dart:convert';
import 'dart:io';
import 'package:restaurant/models/user_profile_model.dart';
import 'package:restaurant/models/user_registration_model.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/endpoints.dart';
import 'package:restaurant/services/storage/local_storage.dart';
import 'package:restaurant/views/login/view/login_screen.dart';
import 'package:restaurant/views/onboarding/view/onboarding.dart';
import 'package:restaurant/widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  static dynamic userModel;
  UserProfileModel get user => userModel;

  Future<dynamic> login(Map data) async {
    print('booting... ${data['firstname']}');
    userModel = UserProfileModel.fromJson(data as Map<String, dynamic>);
    print(user.lastname);

    notifyListeners();
  }

  Future<dynamic> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse(route(Endpoints.profile));
      print(url);

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
        var data = jsonDecode(response.body);
        var userDetails = data["data"];
        login(userDetails);
        notifyListeners();
        return {"error": false, "data": data};
      } else {}
    } catch (e) {
      print(e);
    }
    return {"error": false, "data": {}};
  }

  Future<dynamic> loginUser(Map data) async {
    BuildContext context = data['context'];
    try {
      data.remove('context');

      var url = Uri.parse(route(Endpoints.login));

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data));
          print(url);

      //inspect response body
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        var user = data["data"];
        var token = data["access_token"];

        var encodedData = jsonEncode(data);

        login(user);

        LocalStorage().saveUser(encodedData);
        LocalStorage().saveToken(token);

        return {"error": false, "data": data};
      } else {
        // Navigator.pop(context);
        var data = jsonDecode(response.body)?["message"];
        // ignore: use_build_context_synchronously
        AlertNotification().error(context, data);
      }
    } on SocketException {
      // Navigator.pop(context);
      throw AlertNotification()
          .error(context, "kindly check your internet connection");
    } catch (e) {
      print(e.toString());
    }

    return {"error": true, "data": null};
  }

  Future<dynamic> registerUser(Map data, context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            const Center(child: CircularProgressIndicator.adaptive()));

    try {
      var url = Uri.parse(route(Endpoints.register));
      print(url);

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data));
      print(response.body);

      if (response.statusCode == 200) {
        print(response.statusCode);
        var data = jsonDecode(response.body);

        return {"error": false, "data": data};
      } else {
        Navigator.pop(context);
         var data = jsonDecode(response.body)?["message"];
        AlertNotification().error(context, data);
      }
    } catch (e) {
      print(e);
    }
    return {"error": false, "data": {}};
  }

  Future<dynamic> updateUser(context, Map data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            const Center(child: CircularProgressIndicator.adaptive()));
    try {
      var url = Uri.parse(route(Endpoints.profile));
      print(url);

      final response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer $token"
          },
          body: json.encode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print("inside rsponse $data");
        Navigator.pop(context);

        return {"error": false, "data": data};
      } else {
        var data = jsonDecode(response.body)?["message"];
        Navigator.pop(context);

        AlertNotification().error(context, data);
      }
    } on SocketException {
      throw AlertNotification()
          .error(context, "kindly check your internet connection");
    } catch (e) {
      print(e.toString());
    }

    return {"error": true, "data": null};
  }

  Future<bool> logOut(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            const Center(child: CircularProgressIndicator.adaptive()));

    try {
      var url = Uri.parse(route(Endpoints.logout));
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
        print(response.statusCode);
        Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()));
        return true;
      }
    } catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<bool> deactvateAccount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);

    try {
      var url = Uri.parse(route(Endpoints.deactivate));
      print(url);

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
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

  Future<dynamic> uploadPhoto(Map data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      var url = Uri.parse(route(Endpoints.profile));
      print(url);

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer $token"
          },
          body: json.encode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);

        return {"error": false, "data": data};
      } else {
        var data = jsonDecode(response.body)?["message"];
        // AlertNotification().error(context, data);
      }
    } catch (e) {
      print(e.toString());
    }

    return {"error": true, "data": null};
  }

  Future<bool> sendEmailForOtp(Map data, context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            const Center(child: CircularProgressIndicator.adaptive()));
    try {
      var url = Uri.parse(route(Endpoints.forgotInit));
      print(url);

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print("inside rsponse $data");
        Navigator.pop(context);

        return true;
      } else {
        var data = jsonDecode(response.body)?["message"];
        print(data);
        Navigator.pop(context);
      }
    } on SocketException {
      throw "socket error";
    } catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<bool> verifyOtp(Map data) async {
    try {
      var url = Uri.parse(route(Endpoints.forgotVerify));
      print(url);

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        // ignore: avoid_print
        print("inside rsponse $data");

        return true;
      } else {
        var data = jsonDecode(response.body)?["message"];
        print(data);
      }
    } on SocketException {
      throw "socket error";
    } catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<bool> resetPassword(Map data) async {
    try {
      var url = Uri.parse(route(Endpoints.forgotReset));
      print(url);

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print("inside rsponse $data");

        return true;
      } else {
        var data = jsonDecode(response.body)?["message"];
      }
    } on SocketException {
      throw "socket error";
    } catch (e) {
      print(e.toString());
    }

    return false;
  }
}
