import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant/controllers/Helpers/cart_helper.dart';
import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/controllers/providers/cart_provider.dart';
import 'package:restaurant/models/product_model.dart';
import 'package:restaurant/models/user_profile_model.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/homepage/widget/product_preview_widget.dart';
import 'package:restaurant/views/product_details/view/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final dynamic itemCount;
  const ProductCard({required this.itemCount, super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // var name =
  //                                                     products?[index]["name"];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 15.h),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.85,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15),
        itemCount: widget.itemCount,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ProductPreviewWidget();
                  });
            },
            child: Container(
              height: 234.h,
              width: double.infinity.w,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 133.h,
                    width: 190.w,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          AppImages.foodo,
                        ),
                      ),
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 27.h,
                          width: 108.w,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.zero,
                            color: ColorManager.primaryColor,
                            child: Center(
                              child: Text(
                                'Top choices',
                                style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                    color: ColorManager.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 6,
                          child: SizedBox(
                            height: 21.h,
                            width: 60.w,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(36)),
                              margin: EdgeInsets.zero,
                              color: ColorManager.white,
                              child: Center(
                                child: Text(
                                  '30mins',
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: TextStyle(
                                      color: ColorManager.primaryColor,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 9.w, right: 9.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "jollof rice",
                            style: GoogleFonts.nunitoSans(
                              textStyle: TextStyle(
                                color: ColorManager.pureBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'NGN 3,500.00',
                                style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                    color: ColorManager.primaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 31.h,
                                width: 31.w,
                                child: CircleAvatar(
                                  backgroundColor: const Color(0xffF2F9F3),
                                  child: Center(
                                      child:
                                          SvgPicture.asset(AppImages.shopping)),
                                ),
                              )
                            ],
                          )
                        ]),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

