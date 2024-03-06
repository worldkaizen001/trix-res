import 'dart:io';

import 'package:restaurant/controllers/providers/cart_provider.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/icon_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/cart/view/cart_screen.dart';
import 'package:restaurant/views/delivery_details.dart';
import 'package:restaurant/views/homepage/view/homepage.dart';
import 'package:restaurant/views/homepage/view/search_item_screen.dart';
import 'package:restaurant/views/orders/view/orders.dart';
import 'package:restaurant/views/product_details/view/product_details.dart';
import 'package:restaurant/views/rewards/view/reward.dart';
import 'package:restaurant/views/select_payment.dart';
import 'package:restaurant/views/successful_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var currentIndex = 0;
  final children = [
    // CreateNewPassword(),
    const HomePage(),
    const SearchItemScreen(),
    const RewardScreen(),
    const OrdersScreen(),

    // const CartScreen(),
    // const SelectPaymentScreen(),
    // const ThanksForOderingScreen(),
    // const ProductDetailsScreen(),
    // const DeliveryDetailsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
        var cart = context.watch<CartProvider>().items;

    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          if(currentIndex != 0){
            setState(() => currentIndex = 0);
            return Future.value(false);
          }

          return Future.value(true);
        },
        child: children[currentIndex]
      ),
      bottomNavigationBar: SizedBox(
        // height: 80.h,
        height: 90.h,
        child: BottomNavigationBar(
          // elevation: 0.05,
          backgroundColor: ColorManager.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorManager.primaryColor,
          unselectedItemColor: ColorManager.pureBlack.withOpacity(0.7),
          unselectedLabelStyle: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
              color: ColorManager.pureBlack.withOpacity(0.5),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          selectedLabelStyle: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
              color: ColorManager.primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppImages.house,
                colorFilter: currentIndex == 0
                    ? const ColorFilter.mode(
                        ColorManager.primaryColor, BlendMode.srcIn)
                    : ColorFilter.mode(ColorManager.pureBlack.withOpacity(0.4),
                        BlendMode.srcIn),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                IconsManager.search,
                 height: 24,
                width: 24,

                color: currentIndex == 1
                    ? ColorManager.primaryColor
                    : ColorManager.pureBlack.withOpacity(0.4),
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppImages.reward1,
                color: currentIndex == 2
                    ? ColorManager.primaryColor
                    : ColorManager.pureBlack.withOpacity(0.4),
              ),
              label: 'Rewards',
            ),
                BottomNavigationBarItem(
              icon: SvgPicture.asset(
                               AppImages.plate,

                color: currentIndex == 3
                    ? ColorManager.primaryColor
                    : ColorManager.pureBlack.withOpacity(0.4),
              ),
              label: 'Orders',
            ),
            
            // BottomNavigationBarItem(
            //   icon: Stack(
            //     children: [
            //          Positioned(
            //         top: 0,
            //         right: -4,
            //         bottom: 10,
            //         child: SizedBox(
            //           height: 23,
            //           width: 23,
            //           child: CircleAvatar(
            //             backgroundColor: ColorManager.primaryColor,
            //             child: Center(child: Text(cart.length.toString(),style: const TextStyle(color: Colors.white, fontSize: 10),)),
            //           ))),
                     
            //       SvgPicture.asset(
            //               IconsManager.eCart2,
            //         color: currentIndex == 3
            //             ? ColorManager.primaryColor
            //             : ColorManager.pureBlack.withOpacity(0.7),
            //       ),
            //     ],
            //   ),
            //   label: 'Cart',
            // ),
          ],
        ),
      ),
    );
  }
}
