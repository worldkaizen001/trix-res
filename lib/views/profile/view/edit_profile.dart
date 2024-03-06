import 'dart:convert';
import 'dart:io';

import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/models/user_profile_model.dart';
import 'package:restaurant/resources/app_sizes.dart';
import 'package:restaurant/views/onboarding/view/onboarding.dart';
import 'package:restaurant/widgets/master_layout.dart';
import 'package:flutter/material.dart';

import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/endpoints.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/login/view/login_screen.dart';
import 'package:restaurant/views/register/view/otp_screen.dart';
import 'package:restaurant/widgets/charissa_button.dart';
import 'package:restaurant/widgets/master_layout.dart';
import 'package:restaurant/widgets/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var emptyPhoto =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;
  final picker = ImagePicker();

  String? profilePhotoByte;
  File? profilePhotofile;
  String profilePhoto = "";

  File? profilePicture;
  XFile? xFile;
  dynamic image;

  // handleChooseFromGallery(BuildContext context, ImageSource source) async {
  //   final XFile? pickedFile = await picker.pickImage(
  //     source: source,
  //   );

  //   setState(() {
  //     // xFile = pickedFile;
  //     profilePicture = File(pickedFile!.path);
  //   });
  // }

  handlePhotoUpload(context) async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 500,
    );

    final getFile = File(pickedFile!.path);
    Uint8List byte = await getFile.readAsBytes();
    String imageByte = base64Encode(byte);

    // await getFile.readAsBytes().then((value) {
    //   profilePhotoByte = Uint8List.fromList(value);
    //   print(profilePhotoByte);
    // });
    setState(() {
      profilePhotofile = getFile;
      profilePhoto = pickedFile.path;
      profilePhotoByte = "data:image/jpg;base64,$imageByte";
      print(profilePhotoByte);
    });
  }

  @override
  void initState() {
    super.initState();
    var auth = Provider.of<AuthProvider>(context, listen: false);
    UserProfileModel user = auth.user;

    fnameController.text = user.firstname;
    lnameController.text = user.lastname;
    emailController.text = user.email;
    phoneController.text = user.telephone.toString();
    addressController.text = user.address.toString();
  }

  @override
  Widget build(BuildContext context) {
    UserProfileModel? user = context.watch<AuthProvider>().user;

    return MasterScreen(
      widgets: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Center(
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
                SizedBox(height: 20.h),
                Center(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await handlePhotoUpload(context);
                        },
                        child: CircleAvatar(
                          maxRadius: 55,
                          child: profilePhotoByte == null
                              ? CircleAvatar(
                                  maxRadius: 55,
                                  backgroundImage: NetworkImage(
                                      user.photo == null
                                          ? emptyPhoto
                                          : user.photo.toString() ?? ""),
                                )
                              : Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                          image: FileImage(profilePhotofile!),
                                          fit: BoxFit.cover)),
                                ),
                        ),
                      ),
                      Positioned(
                          right: 2,
                          bottom: 8,
                          child: GestureDetector(
                            onTap: () async {
                              await handlePhotoUpload(context);
                            },
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 25,
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextfieldAndTitle(
                        width: 180.w,
                        hintext: 'First Name',
                        controller: fnameController,
                      ),
                      TextfieldAndTitle(
                        width: 180.w,
                        hintext: 'Last Name',
                        controller: lnameController,
                      )
                    ]),
                const SizedBox(
                  height: 15,
                ),
                TextfieldAndTitle(
                  width: double.infinity,
                  hintext: 'Email address',
                  controller: emailController,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextfieldAndTitle(
                  width: double.infinity,
                  hintext: 'Telephone',
                  controller: phoneController,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextfieldAndTitle(
                  width: double.infinity,
                  hintext: 'Address',
                  controller: addressController,
                ),
                const SizedBox(
                  height: 15,
                ),
                // Text(
                //   "Change Password",
                //   style: GoogleFonts.nunitoSans(
                //     textStyle: TextStyle(
                //       color: ColorManager.pureBlack,
                //       fontSize: 18.sp,
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // TextfieldAndTitle(
                //   width: double.infinity,
                //   hintext: 'Enter Password',
                //   controller: passwordController,
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // TextfieldAndTitle(
                //   width: double.infinity,
                //   hintext: 'Confirm Passwords',
                //   controller: confirmPasswordController,
                // ),
                const SizedBox(
                  height: 40,
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
                      onPressed: () async {
                        var auth =
                            Provider.of<AuthProvider>(context, listen: false);

                        Map userDetails = {
                          "firstname": fnameController.text.trim(),
                          "lastname": lnameController.text.trim(),
                          "email": emailController.text.trim(),
                          "telephone": phoneController.text.trim(),
                          "photo": profilePhotoByte,
                          "address": addressController.text.trim(),
                          // "password": passwordController.text.trim(),
                          // "confirmPassword":
                          //     confirmPasswordController.text.trim(),
                        };

                        print(userDetails);
                        await auth
                            .updateUser(context, userDetails)
                            .then((response) {
                          // print("this is the ${data.toString()}");

                          if (response["error"] == false) {
                            auth.getUser().then((value) {
                              if (value["error"] == false) {
                                var data = value["data"]["data"];
                                print("get user data ---> $data");

                                auth.login(data);
                              }
                            });
                            // Navigator.pop(context);
                            AlertNotification()
                                .success(context, "Successfully updated");
                          } else {
                            AlertNotification()
                                .error(context, "Error updating your details");
                          }
                        });
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: ColorManager.primaryColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
      footer: Center(
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
              _deActivateAccount();
            },
            child: Text(
              "Deactivate account",
              style: GoogleFonts.nunitoSans(
                textStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _deActivateAccount() async {
    var auth = Provider.of<AuthProvider>(context, listen: false);
    UserProfileModel user = auth.user;

    return showDialog(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: ColorManager.white,
          titlePadding: const EdgeInsets.only(left: 20, top: 20),
          title: Text(
            "Deactivate Account",
            style: GoogleFonts.nunitoSans(
              textStyle: TextStyle(
                color: ColorManager.pureBlack,
                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          elevation: 0.5,
          content: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Hello, ${user.firstname}, are you sure you want to deactivate your account.",
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
                          onTap: () {
                            auth.deactvateAccount().then((isLoggout) {
                              if (isLoggout == true) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OnboardingScreen()));

                                AlertNotification().success(
                                    context, 'Account Deleted Successfully');
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
                                    ColorManager.primaryColor.withOpacity(0.7),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
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
