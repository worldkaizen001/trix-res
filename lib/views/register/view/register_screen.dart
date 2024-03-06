import 'dart:convert';
import 'dart:io';

import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/endpoints.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/login/view/login_screen.dart';
import 'package:restaurant/views/register/view/otp_screen.dart';
import 'package:restaurant/widgets/charissa_button.dart';
import 'package:restaurant/widgets/master_layout.dart';
import 'package:restaurant/widgets/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isChecked = false;
  bool isVisible = false;

  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late String _password;
  double _strength = 0;

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  String _displayText = 'At least 6 characters';

  void _checkPassword(String value) {
    _password = value.trim();

    if (_password.isEmpty) {
      setState(() {
        _strength = 0;
        _displayText = 'At least 6 characters';
      });
    } else if (_password.length < 6) {
      setState(() {
        _strength = 1 / 4;
        _displayText = 'Your password is too short';
      });
    } else if (_password.length < 8) {
      setState(() {
        _strength = 2 / 4;
        _displayText = 'Your password is acceptable but not strong';
      });
    } else {
      if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
        setState(() {
          // Password length >= 8
          // But doesn't contain both letter and digit characters
          _strength = 3 / 4;
          _displayText = 'Your password is strong';
        });
      } else {
        // Password length >= 8
        // Password contains both letter and digit characters
        setState(() {
          _strength = 1;
          _displayText = 'Your password is great';
        });
      }
    }
  }

  Future<dynamic> _doRegister() async {
    final data = {
      "firstname": fnameController.text.trim(),
      "lastname": lnameController.text.trim(),
      "email": emailController.text.trim(),
      "telephone": phoneController.text.trim(),
      "password": passwordController.text.trim(),
      "confirmPassword": confirmPasswordController.text.trim(),
    };

    await AuthProvider().registerUser(data, context).then((response) {
      var data = response["data"];
      print(data);
      if (response["error"] == false) {
        print("inside register naviagtor");
        // AlertNotification().success(context, data);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        // AlertNotification().success(context, data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(widgets: [
      Expanded(
        child: SingleChildScrollView(
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
              SizedBox(
                  height: 60,
                  width: 60,
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: ColorManager.f3f3f3,
                    elevation: 0.0,
                    child: Center(child: SvgPicture.asset(AppImages.user)),
                  )),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Let’s get you started",
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
                "First lets create your restaurant foods account",
                style: GoogleFonts.nunitoSans(
                  textStyle: const TextStyle(
                    color: ColorManager.pureBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextfieldAndTitle(
                  width: 180.w,
                  hintext: 'First Name',
                  controller: fnameController,
                ),
                TextfieldAndTitle(
                  width: 180.w,
                  hintext: 'Last Name',
                  controller: lnameController,
                )
              ]),
              const SizedBox(
                height: 15,
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
                hintext: 'Telephone',
                controller: phoneController,
              ),
              const SizedBox(
                height: 15,
              ),
              TextfieldAndTitle(
                obscure: isVisible,
                width: double.infinity,
                hintext: 'Create password',
                controller: passwordController,
                icon: isVisible ? Icons.visibility : Icons.visibility_off,
                callback: () {
                  print("working");
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                onChanged: (value) => _checkPassword(value),
              ),
              const SizedBox(
                height: 15,
              ),
              TextfieldAndTitle(
                width: double.infinity,
                hintext: 'Confirm password',
                controller: confirmPasswordController,
                icon: isVisible ? Icons.visibility : Icons.visibility_off,
                callback: () {
                  print("working");
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Password Strength',
                style: GoogleFonts.nunitoSans(
                  textStyle: const TextStyle(
                    color: ColorManager.a737373,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              LinearProgressIndicator(
                value: _strength,
                backgroundColor: Colors.grey[300],
                color: _strength <= 1 / 4
                    ? Colors.red
                    : _strength == 2 / 4
                        ? Colors.yellow
                        : _strength == 3 / 4
                            ? Colors.blue
                            : Colors.green,
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Image.asset(AppImages.block),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    _displayText,
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                        color: ColorManager.a737373,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        }),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: "I agree with the",
                        style: const TextStyle(
                            fontSize: 14,
                            color: ColorManager.pureBlack,
                            fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {},
                              text: " Terms and Conditions ",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: ColorManager.primaryColor,
                              )),
                          const TextSpan(
                              text: 'and ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: ColorManager.pureBlack,
                              )),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {},
                              text: 'Privacy Policy,',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.primaryColor,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),

      RestaurantButton(
        title: 'Sign me up',
        buttonColor: isChecked == false
            ? const Color(0xffCBCBCB)
            : ColorManager.primaryColor,
        callBack: isChecked == false
            ? () {
                print('Accept terms and condition');
                AlertNotification()
                    .error(context, 'Kindly accept terms and condition');
              }
            : () async {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const OtpScreenn()));

                fnameController.text.isEmpty ||
                        lnameController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty
                    ? AlertNotification()
                        .error(context, 'Please fill all fields')
                    : _doRegister();

                print("register tapped");
              },
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
