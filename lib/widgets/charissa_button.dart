import 'package:restaurant/resources/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantButton extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final VoidCallback callBack;
  final Color? borderColor;
  final TextStyle? textStyle;

  const RestaurantButton({
    this.textStyle,
    this.borderColor,
    required this.title,
    required this.buttonColor,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            elevation: 0,
            side:
                BorderSide(color: borderColor ?? Colors.transparent, width: 1),
            backgroundColor: buttonColor),
        onPressed: callBack,
        child: Text(
          title,
          style: textStyle,
        ),
      ),
    );
  }
}
