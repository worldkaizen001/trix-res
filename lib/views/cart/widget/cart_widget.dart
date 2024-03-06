import 'package:restaurant/controllers/Helpers/cart_helper.dart';
import 'package:restaurant/controllers/providers/cart_provider.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatefulWidget {
  final String? name, imageUrl;
  // ignore: prefer_typing_uninitialized_variables
  int quantity;
  final int? id;
  CartItemWidget(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.quantity,
      super.key});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  bool isDeleted = false;
  var quantity;

  Future<dynamic> updateCart(Map data) async {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    return await CartHelper().updateCart(data, widget.id).then((isUpdated) {
      if (isUpdated == true) {
        cartProvider.getCart();
        AlertNotification().success(context, "Product updated");
      } else {
        AlertNotification().error(context, "error updating cart");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: SizedBox(
          height: 96.h,
          width: double.infinity,
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xffEFEFEF)),
                borderRadius: BorderRadius.circular(0.0)),
            elevation: 0.00,
            child: Stack(
              children: [
                SizedBox(
                  width: 96.w,
                  height: 96.h,
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: 13,
                  left: 120.w,
                  child: Text(
                    widget.name ?? "",
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                        color: ColorManager.pureBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 120.w,
                  bottom: 13.h,
                  child: Row(
                    children: [
                      Text(
                        'Qty :',
                        style: GoogleFonts.nunitoSans(
                          textStyle: const TextStyle(
                            color: ColorManager.pureBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () async {
                           if (widget.quantity <= 1) {
                              AlertNotification()
                              .error(context, "Minimun quantity is 1");
                              return;
                           }
                          setState(() {
                            // if (widget.quantity <= 1) return;
                            widget.quantity--;
                          });
                          Map data = {
                            // "product_id": widget.id,
                            "quantity": widget.quantity
                          };
                          updateCart(data);
                        },
                        child: SvgPicture.asset(
                          AppImages.plus,
                          // height: 25,
                          // width: 25,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.quantity.toString() ?? "",
                        style: GoogleFonts.nunitoSans(
                          textStyle: const TextStyle(
                            color: ColorManager.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            widget.quantity++;
                          });
                          print(widget.quantity);
                          Map data = {
                            // "product_id": widget.id,
                            "quantity": widget.quantity
                          };

                          updateCart(data);
                        },
                        child: SvgPicture.asset(
                          AppImages.plus,
                          // height: 25,
                          // width: 25,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 13.w,
                  bottom: 13.h,
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        isDeleted = true;
                      });
                      var cartProvider =
                          Provider.of<CartProvider>(context, listen: false);

                      await CartHelper()
                          .deleteFromCart(widget.id)
                          .then((isRemoved) {

                        if (isRemoved == true) {
                         
                          cartProvider.getCart();
                              setState(() {
                            isDeleted = false;
                          });
                          
                          AlertNotification()
                              .success(context, "Product Deleted");
                           
                        } else {
                          AlertNotification()
                              .error(context, "Error Deleting item");
                        }
                      });
                    },
                    child: Row(
                      children: [
                       isDeleted == true
                            ? SizedBox(
                                height: 10.h,
                                width: 10.w,
                                child: const CircularProgressIndicator.adaptive(
                                  // backgroundColor: Colors.white,
                                ),
                              )
                            :   SvgPicture.asset(
                          AppImages.delete,
                          // height: 25,
                          // width: 25,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                       Text(
                            'Remove',
                            style: GoogleFonts.nunitoSans(
                              textStyle: const TextStyle(
                                color: ColorManager.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                              ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
