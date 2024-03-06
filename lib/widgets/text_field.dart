import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/resources/app_sizes.dart';
import 'package:restaurant/resources/color_manager.dart';

class TextfieldAndTitle extends StatefulWidget {
  final String? hintext;
  final double width;
  final IconData? icon;
  final Function? callback;
  final TextEditingController? controller;
  final bool? obscure;
  final Function(String)? onChanged;

  // final String? Function(String?)? validator;

  const TextfieldAndTitle(
      {this.hintext,
      this.onChanged,
      this.icon,
      this.controller,
      this.obscure,
      this.callback,
      required this.width,
      super.key});

  @override
  State<TextfieldAndTitle> createState() => _TextfieldAndTitlState();
}

class _TextfieldAndTitlState extends State<TextfieldAndTitle> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s52.h,
      width: widget.width,
      child: TextFormField(
        // validator: widget.valiator,
        controller: widget.controller,
        obscureText: widget.obscure ?? false,
        // cursorColor: ColorManager.lightBlack,
        onChanged: widget.onChanged,
        cursorWidth: 2,
        cursorHeight: 20,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.w),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide:
                    const BorderSide(width: 0.5, color: Color(0xffDFDFDF))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                    width: 1, color: ColorManager.primaryColor)),
            hintText: widget.hintext,
            hintStyle: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                color: ColorManager.pureBlack.withOpacity(0.5),
                // fontSize: FontSize.s14,
                fontWeight: FontWeight.w400,
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                widget.callback!();
              },
              child: Icon(
                widget.icon,
                size: 14,
                // color: ColorManager.hintext,
              ),
            ),
            filled: true,
            fillColor: const Color(0xffF9F9F9),
            border: InputBorder.none),
      ),
    );
  }
}
