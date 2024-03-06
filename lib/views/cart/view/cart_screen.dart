import 'package:restaurant/controllers/Helpers/cart_helper.dart';
import 'package:restaurant/controllers/providers/cart_provider.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/icon_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/cart/widget/cart_widget.dart';
import 'package:restaurant/views/delivery_details.dart';
import 'package:restaurant/views/select_payment.dart';
import 'package:restaurant/widgets/charissa_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
        final commaValue = NumberFormat("#,##0.00", "en_US");


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
        final commaValue = NumberFormat("#,##0.00", "en_US");

  Future<dynamic>? getCartItems;
  dynamic quantity = 0;
  dynamic subTotal;

  List<dynamic> totalList = [];

  @override
  void initState() {
    super.initState();
    // getCartItems = CartHelper().getCart();
    // var lent = CartHelper().cartItem;
    // print(lent.length);
  }

  @override
  Widget build(BuildContext context) {
    
    var cart = context.watch<CartProvider>().items;
    double value = cart.fold(0, (double previousValue, carty) {
      //  double to = carty[index]["product"]["amount"];
      return previousValue + carty["total"];
    });

    setState(() {
      subTotal = value;
    });

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xffF2F9F3),
          title: const Text('Cart'),
          automaticallyImplyLeading: false,
          titleTextStyle: GoogleFonts.nunitoSans(
            textStyle: TextStyle(
              color: ColorManager.pureBlack,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            // SizedBox(
            //   height: 500.h,
            //   child: FutureBuilder<dynamic>(
            //       future: getCartItems,
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return const Center(
            //               child: CircularProgressIndicator.adaptive());
            //         } else if (snapshot.hasError) {
            //           return const Text("error ocuured");
            //         }
            //         if (snapshot.hasData) {
            //           var data = snapshot.data;
            //           totalList = data;

            //           print("this is total list $totalList");
            //           print("na here o");
            //           print(data);
            //           var name = snapshot;

            //           return data.isEmpty
            //               ? const Center(child: Text("Your Cart is Empty"))
            //               : ListView.builder(
            //                   itemCount: data.length,
            //                   itemBuilder: (context, index) {
            //                     var name = data[index];
            //                     return Text(name ?? "nothing");
            //                   });
            //         } else {
            //           return const Center(child: Text("somethng went wrong"));
            //         }
            //       }),
            // ),
            // // SizedBox(
            // //   height: 500.h,
            // //   child: ListView.builder(
            // //       itemCount: 30,
            // //       itemBuilder: (context, index) {
            // //         return Padding(
            // //           padding:
            // //               EdgeInsets.only(left: 20.w, right: 20.w, top: 20),
            // //           child: Column(children: [
            // //             GestureDetector(
            // //               onTap: () {},
            // //               child: SizedBox(
            // //                   height: 96.h,
            // //                   width: double.infinity,
            // //                   child: Card(
            // //                     color: Colors.white,
            // //                     margin: EdgeInsets.zero,
            // //                     shape: RoundedRectangleBorder(
            // //                         side: const BorderSide(
            // //                             width: 1, color: Color(0xffEFEFEF)),
            // //                         borderRadius: BorderRadius.circular(0.0)),
            // //                     elevation: 0.00,
            // //                     child: Stack(
            // //                       children: [
            // //                         SizedBox(
            // //                           width: 96.w,
            // //                           height: 96.h,
            // //                           child: Card(
            // //                             margin: EdgeInsets.zero,
            // //                             shape: RoundedRectangleBorder(
            // //                                 borderRadius:
            // //                                     BorderRadius.circular(0.0)),
            // //                             elevation: 0.0,
            // //                             color: Colors.red,
            // //                             child: Image.asset(
            // //                               AppImages.milk,
            // //                               fit: BoxFit.cover,
            // //                             ),
            // //                           ),
            // //                         ),
            // //                         Positioned(
            // //                           top: 13,
            // //                           left: 120.w,
            // //                           child: Text(
            // //                             'Dano CoolCow Sachet 750g',
            // //                             style: GoogleFonts.nunitoSans(
            // //                               textStyle: const TextStyle(
            // //                                 color: ColorManager.pureBlack,
            // //                                 fontSize: 16,
            // //                                 fontWeight: FontWeight.w400,
            // //                               ),
            // //                             ),
            // //                           ),
            // //                         ),
            // //                         Positioned(
            // //                           left: 120.w,
            // //                           bottom: 13.h,
            // //                           child: Row(
            // //                             children: [
            // //                               Text(
            // //                                 'Qty :',
            // //                                 style: GoogleFonts.nunitoSans(
            // //                                   textStyle: const TextStyle(
            // //                                     color: ColorManager.pureBlack,
            // //                                     fontSize: 14,
            // //                                     fontWeight: FontWeight.w400,
            // //                                   ),
            // //                                 ),
            // //                               ),
            // //                               const SizedBox(
            // //                                 width: 5,
            // //                               ),
            // //                               InkWell(
            // //                                 onTap: () {
            // //                                   setState(() {
            // //                                     quantity--;
            // //                                   });
            // //                                 },
            // //                                 child: SvgPicture.asset(
            // //                                   AppImages.plus,
            // //                                   // height: 25,
            // //                                   // width: 25,
            // //                                   fit: BoxFit.cover,
            // //                                 ),
            // //                               ),
            // //                               const SizedBox(
            // //                                 width: 8,
            // //                               ),
            // //                               Text(
            // //                                 quantity <= 0 ? "0" : "$quantity",
            // //                                 style: GoogleFonts.nunitoSans(
            // //                                   textStyle: const TextStyle(
            // //                                     color:
            // //                                         ColorManager.primaryColor,
            // //                                     fontSize: 18,
            // //                                     fontWeight: FontWeight.w700,
            // //                                   ),
            // //                                 ),
            // //                               ),
            // //                               const SizedBox(
            // //                                 width: 8,
            // //                               ),
            // //                               InkWell(
            // //                                 onTap: () {
            // //                                   setState(() {
            // //                                     quantity++;
            // //                                   });
            // //                                 },
            // //                                 child: SvgPicture.asset(
            // //                                   AppImages.plus,
            // //                                   // height: 25,
            // //                                   // width: 25,
            // //                                   fit: BoxFit.cover,
            // //                                 ),
            // //                               ),
            // //                             ],
            // //                           ),
            // //                         ),
            // //                         Positioned(
            // //                           right: 13.w,
            // //                           bottom: 13.h,
            // //                           child: Row(
            // //                             children: [
            // //                               InkWell(
            // //                                 onTap: () {
            // //                                   setState(() {});
            // //                                 },
            // //                                 child: SvgPicture.asset(
            // //                                   AppImages.delete,
            // //                                   // height: 25,
            // //                                   // width: 25,
            // //                                   fit: BoxFit.cover,
            // //                                 ),
            // //                               ),
            // //                               const SizedBox(
            // //                                 width: 5,
            // //                               ),
            // //                               Text(
            // //                                 'Remove',
            // //                                 style: GoogleFonts.nunitoSans(
            // //                                   textStyle: const TextStyle(
            // //                                     color:
            // //                                         ColorManager.primaryColor,
            // //                                     fontSize: 14,
            // //                                     fontWeight: FontWeight.w400,
            // //                                   ),
            // //                                 ),
            // //                               ),
            // //                             ],
            // //                           ),
            // //                         )
            // //                       ],
            // //                     ),
            // //                   )),
            // //             ),
            // //           ]),
            // //         );
            // //       }),
            // // ),

            cart.isEmpty
                ? SizedBox(
                    height: 600.h,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                        children: [
                            SvgPicture.asset(
                          IconsManager.eCart2,
                          height: 100,
                          width: 100,
                          color: ColorManager.primaryColor,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Your cart is empty",
                          style: GoogleFonts.nunitoSans(
                            textStyle: const TextStyle(
                              color: ColorManager.pureBlack,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        
                        ],
                    )
                      ],
                    )),
                  )
                : SizedBox(
                    height: 600.h,
                    child: ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          var name = cart[index]["product"]["name"];
                          var image = cart[index]["product"]["dp_image"];
                          var id = cart[index]["id"];
                          var price = cart[index]["product"]["amount"];

                          var quantity = cart[index]["quantity"];

                          return CartItemWidget(
                            name: name,
                            imageUrl: image,
                            id: id,
                            quantity: quantity,
                          );
                        }),
                  ),
            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: RestaurantButton(
                  textStyle: GoogleFonts.nunitoSans(
                    textStyle: const TextStyle(
                      color: ColorManager.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  title:  "Checkout ₦${commaValue.format(subTotal)}",
                  buttonColor: ColorManager.primaryColor,
                  callBack: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => DeliveryDetailsScreen(
                                  items: totalList,
                                ))));
                  }),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
