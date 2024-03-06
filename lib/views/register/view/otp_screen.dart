import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/widgets/dashboard.dart';
import 'package:restaurant/widgets/charissa_button.dart';
import 'package:restaurant/widgets/master_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreenn extends StatefulWidget {
  const OtpScreenn({super.key});

  @override
  State<OtpScreenn> createState() => _OtpScreennState();
}

class _OtpScreennState extends State<OtpScreenn> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      widgets: [
        Expanded(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                    height: 98.h,
                    width: 98.w,
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: ColorManager.f3f3f3,
                      elevation: 0.0,
                      child: Center(child: SvgPicture.asset(AppImages.message)),
                    )),
              ),
              // We’ve sent a 4-digit OTP to johndoe@gmail.com
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: Text(
                  'We’ve sent a 4-digit OTP to\n  johndoe@gmail.com',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    textStyle: const TextStyle(
                      color: ColorManager.pureBlack,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 35.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 27.w, right: 27.w),
                child: PinCodeTextField(
                  length: 4,
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
                    fieldHeight: 72.58.h,
                    selectedFillColor: const Color(0xffF9F9F9),
                    inactiveFillColor: const Color(0xfff9f9f9),
                    fieldWidth: 72.58.w,
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
            title: 'Get started',
            buttonColor: ColorManager.primaryColor,
            callBack: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Dashboard()));
            },
            textStyle: GoogleFonts.nunitoSans(
              textStyle: const TextStyle(
                color: ColorManager.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              print("Resend OTP");
            },
            child: Text(
              'Resend OTP',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                textStyle: const TextStyle(
                  color: Color(0xff2B2B2B),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
