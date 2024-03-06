import 'package:restaurant/controllers/Helpers/notification_helper.dart';
import 'package:restaurant/controllers/Helpers/order_helper.dart';
import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/models/user_profile_model.dart';
import 'package:restaurant/resources/app_sizes.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/orders/view/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  Future<dynamic>? getRewards;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getRewards = NotificationHelper().getRewards();
  }

  @override
  Widget build(BuildContext context) {
    UserProfileModel user = context.watch<AuthProvider>().user;

    return Scaffold(
      backgroundColor: ColorManager.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(left: AppSize.s20, right: AppSize.s20, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SvgPicture.asset(AppImages.backdrop),
                  Positioned(
                    top: 35,
                    left: 20,
                    child: Text(
                      "Balance",
                      // textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                          color: ColorManager.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 25,
                      left: 20,
                      child: Text(
                        user.wallet["balance"].toString(),
                        // "0 Pts",
                        // textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          textStyle: const TextStyle(
                            color: ColorManager.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )),
                  Positioned(
                      bottom: 30,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                            height: 43.h,
                            width: 139.w,
                            child: Card(
                              color: ColorManager.yellow,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(40)),
                              margin: EdgeInsets.zero,
                              child: Center(
                                child: Text(
                                  'Loyalty Points',
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: const TextStyle(
                                      color: ColorManager.primaryColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ))
                ],
              ),
              // Container(
              //   height: 134.h,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     gradient: const LinearGradient(
              //       begin: Alignment.topLeft,
              //       end: Alignment.bottomRight,
              //       colors: [
              //         Color(0xff387F3F),
              //         Color(0xffFADE70),
              //       ],
              //     ),
              //   ),
              //   child: Stack(
              //     children: [
              //       Positioned(
              //         top: 15,
              //         left: 20,
              //         child: Text(
              //           "Balance",
              //           // textAlign: TextAlign.center,
              //           style: GoogleFonts.nunitoSans(
              //             textStyle: const TextStyle(
              //               color: ColorManager.white,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w400,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //           bottom: 15,
              //           left: 20,
              //           child: Text(
              //             "234 Pts",
              //             // textAlign: TextAlign.center,
              //             style: GoogleFonts.nunitoSans(
              //               textStyle: const TextStyle(
              //                 color: ColorManager.white,
              //                 fontSize: 30,
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //           )),
              //       Positioned(
              //           bottom: 20,
              //           right: 20,
              //           child: SizedBox(
              //               height: 43.h,
              //               width: 139.w,
              //               child: Card(
              //                 color: ColorManager.yellow,
              //                 shape: RoundedRectangleBorder(
              //                     side: const BorderSide(
              //                         width: 2, color: Colors.white),
              //                     borderRadius: BorderRadius.circular(40)),
              //                 margin: EdgeInsets.zero,
              //                 child: Center(
              //                   child: Text(
              //                     'Redeem Points',
              //                     style: GoogleFonts.nunitoSans(
              //                       textStyle: const TextStyle(
              //                         color: ColorManager.primaryColor,
              //                         fontSize: 13,
              //                         fontWeight: FontWeight.w400,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               )))
              //     ],
              //   ),
              // ),

              SizedBox(
                height: 19.h,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 10.w, right: 10.w, top: 10.h, bottom: 10),
                  height: 231.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffF2F9F3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: FutureBuilder(
                      future: NotificationHelper().getRewards(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (snapshot.hasError) {
                          return const Text("there is an error");
                        } else if (snapshot.hasData) {
                          var data = snapshot.data;
                          var object = data["data"];
                          // print(data);
                          return object.isEmpty
                              ? const Center(
                                  child: Text("Make purchase to get points"))
                              : SizedBox(
                                  height: 400.h,
                                  child: ListView.builder(
                                      itemCount: object.length,
                                      itemBuilder: (context, index) {
                                        var title = object[index]["title"];
                                        var image = object[index]["image"];
                                        var message = object[index]["message"];
                                        var status = object[index]["status"];
                                        var date = object[index]["created_at"];

                                        // var datey = object[index]["created_at"] as DateTime;
                                        // DateFormat.yMMMEd().format(datey);

                                        return PointsWidget(
                                            message: message,
                                            title: title,
                                            date: date);
                                      }),
                                );
                        } else {
                          throw "Something went wrong";
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PointsWidget extends StatelessWidget {
  final String? message, title, date;
  const PointsWidget({
    required this.message,
    required this.title,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 116.h,
      width: double.infinity,
      child: Card(
        elevation: 0.02,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(children: [
          Positioned(
            top: 15.h,
            left: 15.w,
            right: 15.w,
            child: Text(
              message ?? "",
              style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
                  color: ColorManager.pureBlack,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            top: 43,
            right: 20,
            child: Text(
              title.toString() ?? "",
              style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
                  color: ColorManager.primaryColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10.h,
            left: 20.w,
            child: Text(
              date!.split("T")[0],
              style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
                  color: ColorManager.a898989,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
