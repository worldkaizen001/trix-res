import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationWidget extends StatefulWidget {
  final String? message, image, title, status, date;
  bool? isread;
  NotificationWidget({
    required this.message,
    this.date,
    this.image,
    this.status,
    this.title,
   this.isread,
    super.key,
  });

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.isread);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 10.h,
          ),
          child: SizedBox(
            height: 95.h,
            width: double.infinity,
            child:  Card(
              color:  widget.status == "unread" 
                  ? ColorManager.primaryColor
                  : const Color(0xffF2F9F3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.r)),
              margin: EdgeInsets.zero,
              elevation: 0.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.message ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(
                          color: widget.status == "unread"
                              ? Colors.white
                              : ColorManager.pureBlack,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.date}".split('T')[0] ?? "",
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              color: widget.status == "unread"
                                  ? Colors.white
                                  : const Color(0xff717171),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          "${widget.date}".split('T')[1],
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              color: widget.status == "unread"
                                  ? Colors.white
                                  : const Color(0xff717171),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          // SizedBox(
          // height: 90.h,
          // width: double.infinity,
          //   child: Card(
          //   color: widget.status == "unread"? ColorManager.primaryColor : const Color(0xffF2F9F3),
          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.r)),
          //   margin: EdgeInsets.zero,
          //   elevation: 0.0,
          //     child:  Stack(
          //     children: [
          //   Positioned(
          //   top: 11.h,
          //   left: 10.w,
          //   child: SvgPicture.asset(AppImages.emptylogo)),
          //   Positioned(
          //   top: 16.h,
          //   left: 55.w,
          //   child: Text(widget.message ?? "",
          //   overflow: TextOverflow.ellipsis,
          //   maxLines: 1,
          //   style:
          //         GoogleFonts.nunitoSans(
          //         textStyle:  TextStyle(
          //         color: widget.status == "unread"? Colors.white : ColorManager.pureBlack,
          //         fontSize: 15,
          //         fontWeight: FontWeight.w400,
          //           ),
          //       ),),
          //   ),
          //            Positioned(
          //             left: 53,
          //             bottom: 10,
          //              child: Text("${widget.date}".split('T')[0] ?? "",
          //              style:
          //             GoogleFonts.nunitoSans(
          //             textStyle:  TextStyle(
          //             color: widget.status == "unread"? Colors.white : const Color(0xff717171),
          //             fontSize: 14,
          //             fontWeight: FontWeight.w400,
          //               ),
          //                   ),),
          //            ),
          //         Positioned(
          //          bottom: 10,
          //          right: 15,

          //           child: Text("${widget.date}".split('T')[1], style:
          //           GoogleFonts.nunitoSans(
          //           textStyle:  TextStyle(
          //           color: widget.status == "unread"? Colors.white : const Color(0xff717171),
          //           fontSize: 14,
          //           fontWeight: FontWeight.w400,
          //             ),
          //            ),),
          //         ),
          //     ],
          //     ),
          //   ),
          // ),
        ),
      ],
    );
  }
}
