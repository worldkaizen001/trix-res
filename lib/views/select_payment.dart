import 'package:restaurant/controllers/Helpers/order_helper.dart';
import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/controllers/providers/cart_provider.dart';
import 'package:restaurant/models/user_profile_model.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/payment_page.dart';
import 'package:restaurant/views/successful_order.dart';
import 'package:restaurant/widgets/charissa_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectPaymentScreen extends StatefulWidget {
  const SelectPaymentScreen({super.key});

  @override
  State<SelectPaymentScreen> createState() => _SelectPaymentScreenState();
}

class _SelectPaymentScreenState extends State<SelectPaymentScreen> {
  bool paymentType = true;
  dynamic paymentMethod = 'Cash';
  bool isLoading = false;
  bool useloyalty = false;

  late AuthProvider auth;
  late CartProvider cart;

  @override
  void initState() {
    super.initState();

    auth = Provider.of<AuthProvider>(context, listen: false);
    cart = Provider.of<CartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: const Color(0xffF2F9F3),
      //   title: const Text('Cart'),
      //   automaticallyImplyLeading: false,
      //   titleTextStyle: GoogleFonts.nunitoSans(
      //     textStyle: TextStyle(
      //       color: ColorManager.pureBlack,
      //       fontSize: 20.sp,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      // ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(AppImages.arrowb)),
                        const Spacer(),
                        Text(
                          "Select payment method",
                          // textAlign: TextAlign.center,
                          style: GoogleFonts.nunitoSans(
                            textStyle: const TextStyle(
                              color: ColorManager.pureBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 90.h,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            paymentType = true;
                            paymentMethod = "Cash";
                            print(paymentMethod);
                          });
                        },
                        child: Card(
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              side: paymentType == true
                                  ? const BorderSide(
                                      width: 1,
                                      color: ColorManager.primaryColor)
                                  : BorderSide.none,
                              borderRadius: BorderRadius.circular(12.r)),
                          elevation: 0.0,
                          color: const Color(0xffF2F9F3),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                // SvgPicture.asset(AppImages.shopping),
                                Image.asset(
                                  paymentType == true
                                      ? AppImages.originalgreen
                                      : AppImages.fgreen,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Cash on delivery',
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: const TextStyle(
                                      color: ColorManager.pureBlack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 135.h,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            paymentType = false;
                            paymentMethod = "Card";
                            print(paymentMethod);
                          });
                        },
                        child: Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                side: paymentType == true
                                    ? BorderSide.none
                                    : const BorderSide(
                                        width: 1,
                                        color: ColorManager.primaryColor),
                                borderRadius: BorderRadius.circular(12.r)),
                            elevation: 0.0,
                            color: const Color(0xffF2F9F3),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 15.w,
                                  top: 30.h,
                                  child: Image.asset(
                                    paymentType == true
                                        ? AppImages.fgreen
                                        : AppImages.originalgreen,
                                    fit: BoxFit.cover,
                                  ),
                                ), // Image.asset(
                                //   AppImages.milk,
                                //   fit: BoxFit.cover,
                                // )
                                // const EdgeInsets.only(top: 25, left: 65),

                                Positioned(
                                  top: 25.h,
                                  left: 50.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Debit or credit card',
                                        style: GoogleFonts.nunitoSans(
                                          textStyle: const TextStyle(
                                            color: ColorManager.pureBlack,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(AppImages.mastrPng),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Image.asset(AppImages.visaPng),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    // SizedBox(
                    //     width: double.infinity,
                    //     height: 65.h,
                    //     child: Card(
                    //         margin: EdgeInsets.zero,
                    //         shape: RoundedRectangleBorder(
                    //             side: BorderSide.none,
                    //             borderRadius: BorderRadius.circular(12.r)),
                    //         elevation: 0.0,
                    //         color: const Color(0xffF2F9F3),
                    //         child: Padding(
                    //           padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             children: [
                    //               Text(
                    //                 "Pay with loyalty points (${auth.user.points} pts)",
                    //                 style: GoogleFonts.nunitoSans(
                    //                   textStyle: const TextStyle(
                    //                     color: ColorManager.pureBlack,
                    //                     fontSize: 16,
                    //                     fontWeight: FontWeight.w400,
                    //                   ),
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 height: 40.h,
                    //                 width: 40.w,
                    //                 child: FittedBox(
                    //                   child: Switch.adaptive(
                    //                       value: useloyalty,
                    //                       onChanged: (value) {
                    //                         setState(() {
                    //                           useloyalty = !useloyalty;
                    //                         });
                    //                       }),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ))),
                  
                  
                  ],
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
                  title: !isLoading ? 'Place order' : 'Processing...',
                  buttonColor: ColorManager.primaryColor,
                  callBack: () async {
                    if (isLoading) return;

                    setState(() {
                      isLoading = true;
                    });

                    Map data = {
                      "pay_method": paymentMethod,
                      "use_points": useloyalty,
                      "coupon_code": "DFGXT23",
                      "memo": null,
                      "orders": cart.loadCart()
                    };

                    await completeOrder(context, data);

                    setState(() {
                      isLoading = false;
                    });
                  }),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> completeOrder(context, Map data) async {

  final auth = Provider.of<AuthProvider>(context, listen: false);
  final cart = Provider.of<CartProvider>(context, listen: false);

  await OrdersHelper()
      .createOrder(context, data)
      .then((response) {
    if (response.isNotEmpty && response['status'] == 200) {
      int id = response['data']['id'];
      String? paymentUrl = response['data']['payment'];
      cart.items.clear();
      print("cart cleared");

      auth.getUser().then((value) {
        if (value["error"] == false) {
          var data = value["data"]["data"];
          

          auth.login(data);
        }
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => paymentUrl == null
                  ?  ThanksForOderingScreen(id: id,)
                  : PaymentScreen(id, paymentUrl)));
    } else {
      AlertNotification()
          .error(context, "error placing order");
    }
  });
}
