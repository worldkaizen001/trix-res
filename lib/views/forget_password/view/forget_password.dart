import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/forget_password/view/forget_password_otp.dart';
import 'package:restaurant/widgets/charissa_button.dart';

import 'package:restaurant/widgets/master_layout.dart';
import 'package:restaurant/widgets/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isChecked = false;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MasterScreen(widgets: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(AppImages.arrowb)),
                const Spacer(),
                Text(
                  "Forgot password",
                  // textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    textStyle: const TextStyle(
                      // decoration: TextDecoration.underline,
                      color: ColorManager.pureBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Input your email to reset password",
              // textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                textStyle: const TextStyle(
                  color: Color(0xff575757),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            TextfieldAndTitle(
              width: double.infinity,
              hintext: 'Email address',
              controller: emailController,
            ),
          ],
        ),
      ),

  
      RestaurantButton(
        title: 'Send email',
        buttonColor: ColorManager.primaryColor,
        callBack: () async {
          var auth = Provider.of<AuthProvider>(context, listen: false);
          
          var data = {
            "email": emailController.text.trim(),
          };
          emailController.text.isEmpty
              ? AlertNotification()
                  .error(context, "kindly enter email")
              : await auth.sendEmailForOtp(data, context).then((isTrue) {
                  if (isTrue) {
                    AlertNotification()
                        .error(context, "kindly check your email for otp");
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => ForgetPasswordOtp(
                    email: emailController.text,
                                )));
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
