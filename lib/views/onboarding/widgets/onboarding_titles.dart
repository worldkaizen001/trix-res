import 'package:restaurant/resources/app_sizes.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/resources/app_sizes.dart';
import 'package:restaurant/resources/color_manager.dart';

class OnboadingImagesAndTitle extends StatelessWidget {
  final String title, description;

  const OnboadingImagesAndTitle(
      {required this.title, required this.description, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      // color: Colors.amber,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(
              textStyle: const TextStyle(
                color: ColorManager.pureBlack,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // CustomSizedBox.verticalSpace(7),
          SizedBox(
            height: AppSize.s10.h,
          ),
          Expanded(
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                textStyle: const TextStyle(
                  color: ColorManager.pureBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
