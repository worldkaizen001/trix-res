import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/login/view/login_screen.dart';
import 'package:restaurant/widgets/master_layout.dart';
import 'package:restaurant/widgets/charissa_button.dart';

import 'package:restaurant/widgets/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateNewPassword extends StatefulWidget {
  final dynamic otp;
  const CreateNewPassword({
   required this.otp,
    super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool isChecked = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
            Text(
              "Create new password",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                textStyle: const TextStyle(
                  color: ColorManager.pureBlack,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextfieldAndTitle(
              width: double.infinity,
              hintext: 'Enter password',
              controller: passwordController,
              obscure: isChecked,
              icon: isChecked ? Icons.visibility_off : Icons.visibility,
              callback: () {
                setState(() {
                  isChecked = !isChecked;
                });
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextfieldAndTitle(
              width: double.infinity,
              hintext: 'Enter password',
              controller: confirmPasswordController,
              obscure: isChecked,
              icon: isChecked ? Icons.visibility_off : Icons.visibility,
              callback: () {
                setState(() {
                  isChecked = !isChecked;
                });
              },
            ),
          ],
        ),
      )
      // SvgPicture.asset(),

      ,
      RestaurantButton(
        title: 'Create New Password',
        buttonColor: ColorManager.primaryColor,
        callBack: () async {
          var auth = Provider.of<AuthProvider>(context, listen: false);

          var data = {
            "otp": widget.otp,
            "password": passwordController.text.trim(),
            "confirmPassword": confirmPasswordController.text.trim(),
          };
          print(data);
          await auth.resetPassword(data).then((isTrue) {
            if (isTrue) {
              AlertNotification().error(context, "Otp Verified successfully");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            } else {
              AlertNotification().error(context, "something went wrong");
            }
          });
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
