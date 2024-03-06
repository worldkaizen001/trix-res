import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/forget_password/view/create_new_password.dart';
import 'package:restaurant/widgets/charissa_button.dart';
import 'package:restaurant/widgets/master_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class ForgetPasswordOtp extends StatefulWidget {
  final String email;
  const ForgetPasswordOtp({required this.email, super.key});

  @override
  State<ForgetPasswordOtp> createState() => _ForgetPasswordOtpState();
}

class _ForgetPasswordOtpState extends State<ForgetPasswordOtp> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      widgets: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    AppImages.arrowb,
                  )),
              SizedBox(
                height: 28.h,
              ),
              SizedBox(
                  height: 64.h,
                  width: 64.w,
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: ColorManager.f3f3f3,
                    elevation: 0.0,
                    child: Center(
                        child: SvgPicture.asset(
                      AppImages.message,
                      height: 36,
                      width: 36,
                    )),
                  )),
              // We’ve sent a 4-digit OTP to johndoe@gmail.com
              SizedBox(
                height: 38.h,
              ),
              Text(
                'We’ve sent a 4-digit OTP to ${widget.email}',
                // textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  textStyle: const TextStyle(
                    color: ColorManager.pureBlack,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 33.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: PinCodeTextField(
                  controller: otpController,
                  length: 5,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  cursorColor: ColorManager.primaryColor,
                  animationType: AnimationType.fade,
                  // textStyle: getCustomTextStyle(
                  //     fontSize: FontSize.s24,
                  //     textColor: ColorManager.primaryColor,
                  //     fontWeight: FontWeightManager.medium),
                  autoFocus: true,
                  enableActiveFill: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                  pinTheme: PinTheme(
                    borderWidth: 0.1,
                    shape: PinCodeFieldShape.box,
                    inactiveColor: ColorManager.f3f3f3,
                    // errorBorderColor: ColorManager.red,
                    activeColor: const Color(0xfff9f9f9),
                    selectedColor: const Color(0xffE6EFFF),
                    fieldHeight: 70.58.h,
                    selectedFillColor: const Color(0xffF9F9F9),
                    inactiveFillColor: const Color(0xfff9f9f9),
                    fieldWidth: 70.58.w,
                    activeFillColor: const Color(0xfff9f9f9),
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  // errorAnimationController: errorController,
                  // controller: textEditingController,
                  onCompleted: (v) {
                    print('completed');
                    print('onComleted $v');
                    setState(() {
                      // hide = false;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      // currentText = value;
                      // print(value);
                      // print('tapped');
                      // print(currentText);
                    });
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
              ),
            ],
          ),
        )
      ],
      footer: Column(
        children: [
          RestaurantButton(
            title: 'Continue',
            buttonColor: ColorManager.primaryColor,
            callBack: () async {
              var auth = Provider.of<AuthProvider>(context, listen: false);

              var data = {
                "otp": otpController.text.trim(),
              };
              await auth.verifyOtp(data).then((isTrue) {
                if (isTrue) {
                  AlertNotification()
                      .error(context, "Otp Verified successfully");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateNewPassword(
                                otp: otpController.text,
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
        ],
      ),
    );
  }
}
