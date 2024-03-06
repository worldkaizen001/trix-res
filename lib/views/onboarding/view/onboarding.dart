import 'package:restaurant/resources/app_sizes.dart';
import 'package:restaurant/views/login/view/login_screen.dart';
import 'package:restaurant/views/onboarding/widgets/onboarding_titles.dart';
import 'package:restaurant/views/register/view/register_screen.dart';
import 'package:restaurant/widgets/charissa_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:restaurant/resources/app_sizes.dart';
import 'package:restaurant/resources/color_manager.dart';
// import 'package:restaurant/resources/font_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var controller = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        
        backgroundColor: Colors.white,
        //i removed the safearea and made the padding below 100
        body: Container(
          margin: EdgeInsets.zero,
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppImages.backgroundImage),
            ),
          ),
          padding: EdgeInsets.only(
              //intially the top hight was 80
              left: AppSize.s20,
              right: AppSize.s20,
              bottom: 30,
              top: 0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SingleChildScrollView(
                child: Container(
                  height: 360.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.only(
                      top: 20, left: 10, right: 10, bottom: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 300.h,
                          child:
                              PageView(controller: controller, children: const [
                            OnboadingImagesAndTitle(
                              title: 'Your cravings, your\n choices!',
                              description:
                                  "Sign up and unlock a world of delicious possibilities. It's quick and hassle-free.",
                            ),
                            OnboadingImagesAndTitle(
                              title: 'Browse through our\n diverse sections',
                              description:
                                  "Restaurant, Mini-Mart, Lounge, and Ala Carte. Your cravings, your choices!",
                            ),
                            OnboadingImagesAndTitle(
                              title: 'Earn Loyalty Points',
                              description:
                                  "Every order brings you one step closer to exclusive rewards. Start accumulating points in section-specific loyalty programs",
                            ),
                          ]),
                        ),
                      ),
                      //intially the top hight below is 0
    
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        // axisDirection: Axis.vertical,
                        effect: const ExpandingDotsEffect(
                            radius: 5,
                            dotHeight: 6,
                            dotWidth: 10,
                            dotColor: Color(0xffD9D9D9),
                            activeDotColor: ColorManager.primaryColor),
                      ),
                      //intially the hight was 65
                      const SizedBox(
                        height: 17,
                      ),
                      Column(
                        children: [
                          RestaurantButton(
                            title: 'Get started',
                            buttonColor: ColorManager.primaryColor,
                            callBack: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreen()));
                            },
                            textStyle: GoogleFonts.nunitoSans(
                              textStyle: const TextStyle(
                                color: ColorManager.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Have an account?',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunitoSans(
                                  textStyle: const TextStyle(
                                    color: ColorManager.pureBlack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              InkWell(
                                onTap: () {
                                  // print('tapped');
    
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                                child: Text(
                                  'Login',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: const TextStyle(
                                      color: ColorManager.primaryColor,
                                      fontSize: 14,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
