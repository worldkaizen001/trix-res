import 'dart:convert';
import 'dart:io';

import 'package:restaurant/controllers/Helpers/location_helper.dart';
import 'package:restaurant/controllers/Helpers/order_helper.dart';
import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/controllers/providers/stores_provider.dart';
import 'package:restaurant/models/place_prediction.dart';
import 'package:restaurant/models/user_profile_model.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/services/comstants.dart';
import 'package:restaurant/services/storage/local_storage.dart';
import 'package:restaurant/views/forget_password/view/forget_password.dart';
import 'package:restaurant/widgets/dashboard.dart';
import 'package:restaurant/widgets/charissa_button.dart';
import 'package:restaurant/widgets/master_layout.dart';
import 'package:restaurant/widgets/spinner.dart';
import 'package:restaurant/widgets/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isChecked = false;
  bool isLoading = false;

  // String? deviceToken;

  
  Future<dynamic> _doLogin() async {
    if (isLoading) return;

    Spinner.show(context);

    setState(() {
      isLoading = true;
    });

    Map data = {
      "context": context,
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      // "device_id": deviceToken,
    };
    print(data);

    await AuthProvider().loginUser(data).then((response) {
      // Navigator.pop
      // Spinner.remove();

      setState(() {
        isLoading = false;
      });
      if (!response['error']) {
        print("inside naviagtor");
        // var user = Provider.of<AuthProvider>(context, listen:false).user;

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    emailController.text = 'ej@gmail.com';
    passwordController.text = '12345678';

  
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(widgets: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(AppImages.arrowb)),
            const SizedBox(
              height: 30,
            ),

            //  ElevatedButton(
            //     onPressed: _strength < 1 / 2 ? null : () {},
            //     child: const Text('Continue')),
            SizedBox(
                height: 63,
                width: 63,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: ColorManager.f3f3f3,
                  elevation: 0.0,
                  child: Center(
                      child: SvgPicture.asset(
                    AppImages.message,
                    height: 37,
                    width: 37,
                  )),
                )),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Login",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                textStyle: const TextStyle(
                  color: ColorManager.pureBlack,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),

            Text(
              "Input your login details to login to restaurant",
              // textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                textStyle: const TextStyle(
                  color: ColorManager.pureBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextfieldAndTitle(
              width: double.infinity,
              hintext: 'Email address',
              controller: emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            TextfieldAndTitle(
              width: double.infinity,
              hintext: 'Enter password',
              icon: isChecked ? Icons.visibility_off : Icons.visibility,
              controller: passwordController,
              obscure: isChecked,
              callback: () {
                setState(() {
                  isChecked = !isChecked;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const ForgetPassword())));
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Forgot password",
                  // textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    textStyle: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: ColorManager.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
      // SvgPicture.asset(),

      ,
      RestaurantButton(
        title: !isLoading ? 'Login' : 'Logging in...',
        buttonColor: ColorManager.primaryColor,
        callBack: _doLogin,
        textStyle: GoogleFonts.nunitoSans(
          textStyle: const TextStyle(
            color: ColorManager.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      // SizedBox(height: 20,),
    ]);
  }
}
