import 'package:restaurant/controllers/providers/cart_provider.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/orders/view/order_details.dart';

import 'package:restaurant/widgets/charissa_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ThanksForOderingScreen extends StatefulWidget {
  final int? id;
  const ThanksForOderingScreen({this.id, super.key});

  @override
  State<ThanksForOderingScreen> createState() => _ThanksForOderingScreenState();
}

class _ThanksForOderingScreenState extends State<ThanksForOderingScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () async {
                      final cartProvider =
                          Provider.of<CartProvider>(context, listen: false);

                      cartProvider.items.clear();
                      print(
                          "this is the cart length on thank you page ${cartProvider.items.length}");

                      Future.delayed(const Duration(seconds: 3)).then((value) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        // Navigator.pop(context);
                        setState(() {});
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 25,
                    )),
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundColor: const Color(0xffF2F9F3),
                          // child: SvgPicture.asset(AppImages.bag),
                          backgroundImage: AssetImage(AppImages.successGif),
                        ),
                        SizedBox(
                          height: 19.h,
                        ),
                        Text(
                          "Thanks for ordering\n from us",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                              color: ColorManager.pureBlack,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                RestaurantButton(
                    textStyle: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                        color: ColorManager.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    title: 'Track order',
                    buttonColor: ColorManager.primaryColor,
                    callBack: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderDetailsScreen(
                                    id: widget.id,
                                  )));
                    }),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
