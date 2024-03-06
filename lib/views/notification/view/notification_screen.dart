import 'package:restaurant/controllers/Helpers/notification_helper.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/icon_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/notification/widget/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NotifcationScreen extends StatefulWidget {
  const NotifcationScreen({super.key});

  @override
  State<NotifcationScreen> createState() => _NotifcationScreenState();
}

class _NotifcationScreenState extends State<NotifcationScreen> {
  Future<dynamic>? getNoti;
  dynamic unRead = 0;
  bool isRead = false;

  Future<dynamic> getUnread() async {
    List allunRead = await NotificationHelper().allUnredNotification();
    setState(() {
      unRead = allunRead;
    });
    print(unRead.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUnread();
    getNoti = NotificationHelper().getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        title: Text(
          'Notifications',
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
              color: ColorManager.pureBlack,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getNoti,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return const Text("there is an error");
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              var object = data["data"];
              return object.isEmpty
                  ? Center(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          IconsManager.emptyNotification,
                          color: ColorManager.primaryColor,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Empty notification",
                          style: GoogleFonts.nunitoSans(
                            textStyle: const TextStyle(
                              color: ColorManager.pureBlack,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ))
                  : Padding(
                      padding:
                          EdgeInsets.only(left: 17.w, right: 17.w, top: 15.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                // 'Today',
                                unRead == 0
                                    ? ""
                                    : "Unread (${unRead.length.toString()})",
                                style: GoogleFonts.nunitoSans(
                                  textStyle: const TextStyle(
                                    color: ColorManager.pureBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await NotificationHelper()
                                      .readAllNotification()
                                      .then((response) {
                                    if (response) {
                                      NotificationHelper().getNotification();
                                    } else {
                                      AlertNotification().error(context,
                                          'Error updating notifcation');
                                    }
                                  });
                                },
                                child: Text(
                                  'Mark all as read',
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: const TextStyle(
                                      color: ColorManager.pureBlack,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                          Expanded(
                            child: ListView.builder(
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: false,
                              
                                itemCount: object.length,
                                itemBuilder: (context, index) {
                                  var id = object[index]["id"];
                          
                                  var title = object[index]["title"];
                                  var image = object[index]["image"];
                                  var message = object[index]["message"];
                                  var status = object[index]["status"];
                                  var date = object[index]["created_at"];
                          
                                  return GestureDetector(
                                    onTap: () async {
                                     NotificationHelper()
                                          .readNotification(id)
                                          .then((response) {
                                        if (response) {
                                          NotificationHelper()
                                              .getNotification();
                                        } else {
                                          AlertNotification().success(context,
                                              'Error updating notifcation');
                                        }
                                      });
                                      readNotification(id, message, title);
                                      setState(() {
                                        isRead = true;
                                      });
                                    },
                                    child: NotificationWidget(
                                      isread: isRead,
                                      message: message,
                                      date: date,
                                      image: image,
                                      title: title,
                                      status: status,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
            } else {
              throw "Something went wrong";
            }
          }),
    );
  }

  Future<void> readNotification(id, message, title) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: ColorManager.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          elevation: 0.5,
          titlePadding: const EdgeInsets.only(left: 20, top: 20),
          title: Text(
            title,
            style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                color: ColorManager.pureBlack,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          content: Padding(
            padding:
                EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  style: GoogleFonts.nunitoSans(
                    textStyle: TextStyle(
                      color: ColorManager.pureBlack,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Okay',
                            style: GoogleFonts.nunitoSans(
                              textStyle: TextStyle(
                                color: ColorManager.primaryColor
                                    .withOpacity(0.7),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }



}
