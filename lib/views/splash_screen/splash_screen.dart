// ignore_for_file: use_build_context_synchronously

import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/controllers/providers/stores_provider.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/services/storage/local_storage.dart';
import 'package:restaurant/views/onboarding/view/onboarding.dart';
import 'package:restaurant/widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future _bootstrap() async {
    //load app featured provider instance

    final storeProvider = Provider.of<StoreProvider>(context, listen: false);
    await storeProvider.boot();

    //load user from shared pref if exist
    Map user = await LocalStorage().getSavedUser();

    if (user.isEmpty) {
      //first time user - redirect to onboarding screen
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()));

      return;
    }

    //user exists - load up into authProvider
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.login(user["data"]);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Dashboard()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      _bootstrap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // casa
      // backgroundColor: const Color(0xff0f0f11),
      backgroundColor: const Color(0xffffffff),

      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SvgPicture.asset(AppImages.restaurantLogo),

          Image.asset(
            AppImages.ej,
            // color: Colors.white,
            height: 200,
            width: 200,
          ),
          // Text(
          //   "Safari Hypermarket",
          //   // textAlign: TextAlign.center,
          //   style: GoogleFonts.nunitoSans(
          //     textStyle: const TextStyle(
          //       color: ColorManager.white,
          //       fontSize: 30,
          //       fontWeight: FontWeight.w700,
          //     ),
          //   ),
          // ),

          // AssetImage(IconsManager.test)
        ],
      )),
    );
  }
}
