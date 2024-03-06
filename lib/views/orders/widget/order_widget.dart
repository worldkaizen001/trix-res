import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/views/cart/view/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderWidget extends StatelessWidget {
  final dynamic amount, status, date, ref;
  const OrderWidget({
    required this.amount,
    required this.status,
    required this.date,
    required this.ref,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 130.h,
        width: double.infinity,
        child: Card(
          elevation: 0.5,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.2, color: ColorManager.pureBlack),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, left: 13, right: 13, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  #ORD453753
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Order Number :',
                                style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                    color: ColorManager.A9A9A9,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Text(
                                '#ORD$ref',
                                style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                    color: ColorManager.pureBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "$date".split('T')[0] ?? "",
                            style: GoogleFonts.nunitoSans(
                              textStyle: TextStyle(
                                color: ColorManager.A9A9A9,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: ColorManager.e8E8E8,
                        height: 7,
                      ),
                      Text(
                        'Restaurant',
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: ColorManager.pureBlack,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // SizedBox(
                //   height: 10.h,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Amount :',
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              color: ColorManager.A9A9A9,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          "₦${commaValue.format(amount)}",
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              color: ColorManager.pureBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 33.h,
                        width: 117.w,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          elevation: 0.3,
                          margin: EdgeInsets.zero,
                          color: const Color(0xffF2F9F3),
                          child: Center(
                            child: Text(
                              '$status',
                              style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                  color: status == "completed"
                                      ? ColorManager.primaryColor
                                      : Colors.red,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
