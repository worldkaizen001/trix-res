import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant/controllers/Helpers/cart_helper.dart';
import 'package:restaurant/controllers/providers/cart_provider.dart';
import 'package:restaurant/models/product_model.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/cart/view/cart_screen.dart';

import 'package:restaurant/widgets/charissa_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int? quantity;
  final String? name, image;
  final int? productId;
  final String? desc;
  final int? amount;

  const ProductDetailsScreen(
      {this.image,
      this.name,
      this.amount,
      this.desc,
      this.productId,
      this.quantity,
      super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(AppImages.arrowb)),
                      const Spacer(),
                      Text(
                        "Product Details",
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
                    height: 290.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Hero(
                        tag: "fly",
                        child: CachedNetworkImage(
                          // fit: BoxFit.cover,
                          imageUrl: widget.image ?? "",
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator.adaptive()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    widget.name.toString(),
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                        color: ColorManager.pureBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "₦${commaValue.format(widget.amount)}",
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                        color: ColorManager.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    widget.desc == null ? "No Description available on this product at the moment" : widget.desc.toString(),
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                        color: Color(0xff3E3E3E),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 54.h,
                    width: 178.w,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            elevation: 0,
                            side: const BorderSide(
                                color: ColorManager.primaryColor, width: 1),
                            backgroundColor: ColorManager.white),
                        onPressed: null,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    if (quantity <= 1) {
                                      AlertNotification().error(
                                          context, "Minimun quantity is 1");
                                      return;
                                    }
                                    setState(() {
                                      // widget.quantity;
                                      quantity--;
                                    });
                                  },
                                  child: SvgPicture.asset(AppImages.plus)),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  color: ColorManager.pureBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // widget.quantity;
                                      quantity++;
                                    });
                                  },
                                  child: SvgPicture.asset(AppImages.plus)),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 54.h,
                    width: 178.w,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            elevation: 0,
                            side: const BorderSide(
                                color: ColorManager.primaryColor, width: 1),
                            backgroundColor: ColorManager.primaryColor),
                        onPressed: () async {
                          setState(() {
                            isTapped = true;
                          });
                          var cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
    
                          Map body = {
                            "product_id": widget.productId,
                            "quantity": widget.quantity
                          };
                          await CartHelper()
                              .addToCart(context, body)
                              .then((isAdded) {
                            if (isAdded == true) {
                              cartProvider.getCart();
                              setState(() {
                                isTapped = false;
                              });
                              AlertNotification().success(context, "Product added to Cart");
                            } else {
                              AlertNotification().error(
                                  context, "Error adding product to cart");
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Add to cart',
                              style: TextStyle(
                                color: ColorManager.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            isTapped
                                ? Center(
                                    child: SizedBox(
                                        height: 10.h,
                                        width: 10.w,
                                        child: const CircularProgressIndicator
                                            .adaptive(
                                          backgroundColor: Colors.white,
                                        )))
                                : SvgPicture.asset(
                                    AppImages.shopping,
                                    height: 15,
                                    width: 15,
                                    color: ColorManager.yellow,
                                  )
                          ],
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
