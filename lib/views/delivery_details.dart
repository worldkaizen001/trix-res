import 'package:restaurant/controllers/Helpers/location_helper.dart';
import 'package:restaurant/controllers/Helpers/order_helper.dart';
import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/controllers/providers/cart_provider.dart';
import 'package:restaurant/models/place_prediction.dart';
import 'package:restaurant/models/user_profile_model.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/cart/view/cart_screen.dart';
import 'package:restaurant/views/location_picker.dart';
import 'package:restaurant/views/select_payment.dart';
import 'package:restaurant/views/successful_order.dart';

import 'package:restaurant/widgets/charissa_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/services/comstants.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  final List<dynamic>? items;
  const DeliveryDetailsScreen({this.items, super.key});

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  late AuthProvider auth;
  late CartProvider cart;

  dynamic user;
  List items = [];

  bool useloyalty = false;
  bool isChecked = false;
  dynamic orderTotal;
  dynamic subTotal;
  dynamic newBalance;
  
  TextEditingController locationCrtl = TextEditingController();
  TextEditingController startSearchCtrl = TextEditingController();

  List<PlacePredictions> placePredictionList = [];
  String queryPickupLocation = '';

  @override
  void initState() {
    super.initState();

    auth = Provider.of<AuthProvider>(context, listen: false);
    user = auth.user;

    cart = Provider.of<CartProvider>(context, listen: false);
    items = cart.items;
    calculateOrder();
  }

  void calculateOrder() {
    double sumCart = items.fold(0, (double previousValue, carty) {
      return previousValue + carty["total"];
    });

    orderTotal = sumCart;
    subTotal = sumCart;
    int balance = user.points;

    if(useloyalty) {

      if(balance >= orderTotal){
        subTotal = 0;
        newBalance = balance - orderTotal;
      }
      else {
        subTotal = orderTotal - balance;
        newBalance = 0;

      }

      // subTotal = balance >= orderTotal ? 0 : orderTotal - balance;

    }

    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    // UserProfileModel user = context.watch<AuthProvider>().user;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Delivery details",
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
                      height: 30.h,
                    ),
                    Text(
                      "Set delivery location",
                      // textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                          color: ColorManager.pureBlack,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LocationWidget()));
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 150.h,
                        child: Card(
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.r)),
                          elevation: 0.0,
                          color: const Color(0xffF2F9F3),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(AppImages.location),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      user.address ?? "NA",
                                      // textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        textStyle: const TextStyle(
                                          color: ColorManager.pureBlack,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 50.h,
                                  width: double.infinity.w,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          disabledBackgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          elevation: 0,
                                          side: const BorderSide(
                                              color: ColorManager.primaryColor,
                                              width: 1),
                                          backgroundColor: ColorManager.white),
                                      onPressed: null,
                                      child: Center(
                                        child: Text(
                                          "Set different address",
                                          // textAlign: TextAlign.center,
                                          style: GoogleFonts.nunitoSans(
                                            textStyle: const TextStyle(
                                              color: ColorManager.primaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),

                    Text(
                      "Order Summary",
                      // textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                          color: ColorManager.pureBlack,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 330.h,
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(12.r)),
                        elevation: 0.0,
                        color: const Color(0xffF2F9F3),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 15.w, right: 15.w, top: 15.h),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  addAutomaticKeepAlives: false,
                                  addRepaintBoundaries: false,
                                  children: items.map((item) {
                                    var name = item["product"]["name"];
                                    var price = item["product"]["amount"];
                                    var quantity = item["quantity"];

                                    return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                name ?? "NA",
                                                style: GoogleFonts.nunitoSans(
                                                  textStyle: const TextStyle(
                                                    color:
                                                        ColorManager.pureBlack,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7.w,
                                              ),
                                              Text(
                                                "x$quantity",
                                                style: GoogleFonts.nunitoSans(
                                                  textStyle: const TextStyle(
                                                    color: ColorManager
                                                        .primaryColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "₦${commaValue.format(price)}",
                                            style: GoogleFonts.nunitoSans(
                                              textStyle: const TextStyle(
                                                color:
                                                    ColorManager.primaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ]);
                                  }).toList(),
                                ),
                              ),
                              Column(
                                children: [
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: GoogleFonts.nunitoSans(
                                          textStyle: const TextStyle(
                                            color: ColorManager.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "₦${commaValue.format(orderTotal)}",
                                        style: GoogleFonts.nunitoSans(
                                          textStyle: const TextStyle(
                                            color: ColorManager.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Discount',
                                        style: GoogleFonts.nunitoSans(
                                          textStyle: const TextStyle(
                                            color: ColorManager.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        useloyalty && user.points > 0 ? "-${user.points}" : "0",
                                        style: GoogleFonts.nunitoSans(
                                          textStyle: const TextStyle(
                                            color: ColorManager.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Sub-Total',
                                        style: GoogleFonts.nunitoSans(
                                          textStyle: const TextStyle(
                                            color: ColorManager.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "₦${commaValue.format(subTotal)}",
                                        style: GoogleFonts.nunitoSans(
                                          textStyle: const TextStyle(
                                            color: ColorManager.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    // GooglePlaceAutoCompleteTextField(
                    //   textEditingController: startSearchCtrl,
                    //   googleAPIKey: mapKey,
                    //   inputDecoration: const InputDecoration(),
                    //   debounceTime: 800, // default 600 ms,
                    //   countries: const [
                    //     "ng",
                    //     "fr"
                    //   ], // optional by default null is set
                    //   isLatLngRequired:
                    //       true, // if you required coordinates from place detail
                    //   getPlaceDetailWithLatLng: (Prediction prediction) {
                    //     // this method will return latlng with place detail
                    //     print("placeDetails${prediction.lng}");
                    //   }, // this callback is called when isLatLngRequired is true
                    //   itemClick: (Prediction prediction) {
                    //     startSearchCtrl.text = prediction.description!;
                    //     startSearchCtrl.selection = TextSelection.fromPosition(
                    //         TextPosition(
                    //             offset: prediction.description!.length));
                    //   },
                    //   // if we want to make custom list item builder
                    //   itemBuilder: (context, index, Prediction prediction) {
                    //     return Container(
                    //       padding: const EdgeInsets.all(10),
                    //       child: Row(
                    //         children: [
                    //           const Icon(Icons.location_on),
                    //           const SizedBox(
                    //             width: 7,
                    //           ),
                    //           Expanded(
                    //               child:
                    //                   Text(prediction.description ?? ""))
                    //         ],
                    //       ),
                    //     );
                    //   },
                    //   // if you want to add seperator between list items
                    //   seperatedBuilder: const Divider(),
                    //   // want to show close icon
                    //   isCrossBtnShown: true,
                    // )

                    SizedBox(
                        width: double.infinity,
                        height: 65.h,
                        child: Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                                borderRadius: BorderRadius.circular(12.r)),
                            elevation: 0.0,
                            color: const Color(0xffF2F9F3),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    useloyalty
                                        ? "Your loyalty points balance is $newBalance"
                                        : "Pay with loyalty points (${user.points} pts)",
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: const TextStyle(
                                        color: ColorManager.pureBlack,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.h,
                                    width: 40.w,
                                    child: FittedBox(
                                      child: Switch.adaptive(
                                          value: useloyalty,
                                          onChanged: (value) {
                                            setState(() {
                                              useloyalty = !useloyalty;
                                              calculateOrder();
                                            });
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ))),
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
                  title: 'Continue',
                  buttonColor: ColorManager.primaryColor,
                  callBack: () async {
                    Map data = {
                      "pay_method": 'Cash',
                      "use_points": useloyalty,
                      "coupon_code": "DFGXT23",
                      "memo": null,
                      "orders": cart.loadCart()
                    };

                    if(subTotal == 0){
                      await completeOrder(context, data);
                      return;
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectPaymentScreen()
                        )
                    );
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
