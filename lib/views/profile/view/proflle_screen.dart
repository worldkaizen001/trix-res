import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/models/user_profile_model.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/views/onboarding/view/onboarding.dart';
import 'package:restaurant/views/profile/view/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  var emptyPhoto =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
  Future<dynamic> loadUser() async {
    var user = Provider.of<AuthProvider>(context, listen: false);
    user.user;
  }

  @override
  void initState() {
    super.initState();

    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    UserProfileModel? user = context.watch<AuthProvider>().user;

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
          'Profile',
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
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  // CachedNetworkImage(
                  //   imageUrl: user?.photo.toString() ?? emptyPhoto,
                  //   fit: BoxFit.cover,
                  //   placeholder: (context, url) =>ssss
                  //       const Center(child: CircularProgressIndicator()),
                  //   errorWidget: (context, url, error) =>
                  //       const Icon(Icons.error),
                  // ),

                  Center(
                    child: CircleAvatar(
                      maxRadius: 55,
                      backgroundImage: NetworkImage(user.photo == null
                          ? emptyPhoto
                          : user.photo.toString() ?? ""),
                    ),
                  ),
                  SizedBox(height: 0.h),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditProfile()));
                      },
                      child: Text(
                        "Edit Profile",
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: ColorManager.primaryColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    "Personal Information",
                    style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                        color: ColorManager.pureBlack,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Card(
                    color: const Color(0xffF2F9F3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.r)),
                    margin: EdgeInsets.zero,
                    elevation: 0.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: ProfileWidget(
                            phoneNumber: user.firstname ?? "",
                            title: 'Firstname',
                          ),
                        ),
                        ProfileWidget(
                          phoneNumber: user.lastname ?? "",
                          title: 'Lastname',
                        ),
                        ProfileWidget(
                          phoneNumber: user.telephone.toString() ?? "",
                          title: 'Phone',
                        ),
                        ProfileWidget(
                          phoneNumber: user.address ?? "",
                          title: 'Address',
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Email",
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: TextStyle(
                                        color: ColorManager.pureBlack,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    user.email ?? "",
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: TextStyle(
                                        color: const Color(0xff5B5B5B),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Text(
                  //   "Delivery Information",
                  //   style: GoogleFonts.nunitoSans(
                  //     textStyle: TextStyle(
                  //       color: ColorManager.pureBlack,
                  //       fontSize: 16.sp,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 10.h),
                  // SizedBox(
                  //     height: 178.h,
                  //     width: double.infinity,
                  //     child: Card(
                  //       color: const Color(0xffF2F9F3),
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(9.r)),
                  //       margin: EdgeInsets.zero,
                  //       elevation: 0.0,
                  //       child: Column(
                  //         children: [
                  //           const Padding(
                  //             padding: EdgeInsets.only(top: 12),
                  //             child: ProfileWidget(
                  //               phoneNumber: '+2349023416425',
                  //               title: 'Phone No',
                  //             ),
                  //           ),
                  //           const ProfileWidget(
                  //             phoneNumber: 'No 8 mission rd',
                  //             title: 'Address',
                  //           ),
                  //           Padding(
                  //             padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  //             child: Column(
                  //               children: [
                  //                 const SizedBox(
                  //                   height: 10,
                  //                 ),
                  //                 Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Text(
                  //                       "Email",
                  //                       style: GoogleFonts.nunitoSans(
                  //                         textStyle: TextStyle(
                  //                           color: ColorManager.pureBlack,
                  //                           fontSize: 14.sp,
                  //                           fontWeight: FontWeight.w600,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Text(
                  //                       "phoneNumber",
                  //                       style: GoogleFonts.nunitoSans(
                  //                         textStyle: TextStyle(
                  //                           color: const Color(0xff5B5B5B),
                  //                           fontSize: 14.sp,
                  //                           fontWeight: FontWeight.w600,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 5,
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     )),
                  // SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 50.h,
              width: 200.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  // shape:
                ),
                onPressed: () {
                  _logOutDialog(context);
                },
                child: Text(
                  "Log Out",
                  style: GoogleFonts.nunitoSans(
                    textStyle: TextStyle(
                      color: ColorManager.primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ]),
      ),
    );
  }

  Future<void> _logOutDialog(context) async {
    // UserProfileModel auth =
    //     Provider.of<AuthProvider>(context, listen: false).user;

    var auth = Provider.of<AuthProvider>(context, listen: false);
    UserProfileModel? userdetails = auth.user;

    return showDialog(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: ColorManager.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          titlePadding: const EdgeInsets.only(left: 20, top: 20),
          title: Text(
            "Log Out",
            style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                color: ColorManager.pureBlack,
                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          elevation: 0.5,
          content: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hello ${userdetails.firstname}, are you sure you want to log out of your account.",
                  style: GoogleFonts.nunitoSans(
                    textStyle: TextStyle(
                      color: ColorManager.pureBlack,
                      fontSize: 20.sp,
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
                          onTap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            // ignore: use_build_context_synchronously
                            await auth.logOut(context).then((isLoggout) {
                              if (isLoggout) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OnboardingScreen()));
                                prefs.remove("user");
                                prefs.remove("token");

                                // print("user pref passd");

                                AlertNotification().success(
                                    context, 'Logged out successfully');
                              } else {
                                AlertNotification()
                                    .success(context, 'Could not logout');
                              }
                            });
                          },
                          child: Text(
                            'Approve',
                            style: GoogleFonts.nunitoSans(
                              textStyle: TextStyle(
                                color:
                                    ColorManager.primaryColor,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.nunitoSans(
                              textStyle: TextStyle(
                                color: ColorManager.primaryColor,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
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

class ProfileWidget extends StatelessWidget {
  final String phoneNumber, title;
  const ProfileWidget({
    required this.phoneNumber,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    color: ColorManager.pureBlack,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                phoneNumber,
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    color: const Color(0xff5B5B5B),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
