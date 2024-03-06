import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant/controllers/Helpers/cart_helper.dart';
import 'package:restaurant/controllers/providers/cart_provider.dart';
import 'package:restaurant/models/product_model.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/cart/view/cart_screen.dart';
import 'package:restaurant/views/product_details/view/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductPreviewWidget extends StatefulWidget {
  final String? name;
  final int? productId;
  final String? desc;
  final int? amount;
  final String? image;

  final ProductModel? productModel;
  const ProductPreviewWidget({
    this.image,
    this.amount,
    this.desc,
    this.productModel,
    this.name,
    this.productId,
    super.key,
  });

  @override
  State<ProductPreviewWidget> createState() => _ProductPreviewWidgetState();
}

class _ProductPreviewWidgetState extends State<ProductPreviewWidget> {
  int quantity = 1;
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close)),
              const Spacer(),
              Text(
                "Product Details",
                // textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  textStyle: const TextStyle(
                    color: ColorManager.pureBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                                image: widget.image,
                                desc: widget.desc,
                                amount: widget.amount,
                                name: widget.name,
                                productId: widget.productId,
                                quantity: 1,
                              )));
                },
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Column(children: [
            Hero(
              tag: 'fly',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    // fit: BoxFit.cover,
                    imageUrl: widget.image ?? "",
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                      .animate()
                      .scale(duration: const Duration(milliseconds: 400)),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Expanded(
                  child: Text(
                    widget.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                        color: ColorManager.pureBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                 "₦${commaValue.format(widget.amount)}",
                  style: GoogleFonts.nunitoSans(
                    textStyle: const TextStyle(
                      color: ColorManager.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ]),
          SizedBox(height: 20.h),
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
                                  AlertNotification()
                                      .error(context, "Minimun quantity is 1");
                                  return;
                                }
                                setState(() {
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
                      if (isTapped == true) return;
                      setState(() {
                        isTapped = true;
                      });
                      // if(isTapped) return;
                      var cartProvider =
                          Provider.of<CartProvider>(context, listen: false);
      
                      Map data = {
                        "product_id": widget.productId,
                        "quantity": quantity
                      };
                      await CartHelper()
                          .addToCart(context, data)
                          .then((isAdded) {
                        if (isAdded == true) {
                          cartProvider.getCart();
                          setState(() {
                            isTapped = false;
                          });
                          AlertNotification()
                              .success(context, "Product added to Cart");
                        } else {
                          AlertNotification()
                              .error(context, "Error adding product to cart");
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Add to cart',
                          style: TextStyle(
                            color: ColorManager.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: isTapped ? 5 : 3,
                        ),
                        isTapped
                            ? const Center(
                                child: SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.white,
                                ),
                              ))
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
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
