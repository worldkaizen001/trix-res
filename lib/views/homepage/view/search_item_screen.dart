import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant/controllers/Helpers/cart_helper.dart';
import 'package:restaurant/controllers/Helpers/product_helper.dart';
import 'package:restaurant/controllers/providers/cart_provider.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/app_sizes.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/cart/view/cart_screen.dart';
import 'package:restaurant/views/homepage/widget/product_preview_widget.dart';
import 'package:restaurant/views/homepage/widget/product_widget.dart';
import 'package:restaurant/widgets/master_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchItemScreen extends StatefulWidget {
  const SearchItemScreen({super.key});

  @override
  State<SearchItemScreen> createState() => _SearchItemScreenState();
}

class _SearchItemScreenState extends State<SearchItemScreen> {
  final TextEditingController searchController = TextEditingController();

  dynamic productList;

  @override
  Widget build(BuildContext context) {
    return MasterScreen(widgets: [
      SizedBox(
        height: AppSize.s50.h,
        width: double.infinity,
        child: TextFormField(
          controller: searchController,
          autofocus: true,
          onChanged: (value) {},
          onEditingComplete: () async {
            if (searchController.text.isEmpty) return;
            await ProductsHelper()
                .searchProduct(searchController.text.trim(), context)
                .then((res) {
              if (res["status"] == false) {
                var data = res["data"];
                setState(() {
                  productList = data;
                  searchController.text = "";
                });
              }
            });
          },  
          cursorWidth: 2,
          cursorHeight: 20,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                      const BorderSide(width: 1, color: ColorManager.aECECEC)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                      const BorderSide(width: 1, color: ColorManager.aECECEC)),
              hintText: 'Search items...',
              hintStyle: GoogleFonts.nunitoSans(
                textStyle: const TextStyle(
                  color: Color(0xffB4B4B4),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              suffixIcon: GestureDetector(
                  onTap: () async {
                    if (searchController.text.isEmpty) return;
                    await ProductsHelper()
                        .searchProduct(searchController.text.trim(), context)
                        .then((res) {
                      if (res["status"] == false) {
                        var data = res["data"];
                        setState(() {
                          productList = data;
                          searchController.text = "";
                        });
                        print("inside then res $data");
                      }
                    });
                  },
                  child: const Icon(Icons.search)),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                      const BorderSide(width: 1, color: ColorManager.aECECEC))),
        ),
      ),
      SizedBox(
        height: 40.h,
      ),
      productList == null
          ?const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Search for your favourite product")
                ],
              ),
            ),
          )
          : Expanded(
              child: SizedBox(
                // height: 700.h,
                child: GridView.builder(
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 15.h, bottom: 60.h),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 0.85,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                    itemCount: productList?.length,
                    itemBuilder: (BuildContext ctx, index) {
                      var id = productList?[index]["id"];
                      var name = productList?[index]["name"];
                      var amount = productList?[index]["amount"];
                      var description = productList?[index]["description"];
                      var image = productList?[index]["dp_image"];

                      return Container(
                        height: 234.h,
                        width: double.infinity.w,
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 190.w,
                              height: 133.h,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return ProductPreviewWidget(
                                          image: image,
                                          name: name,
                                          desc: description,
                                          productId: id,
                                          amount: amount,
                                        );
                                      });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(9),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: image ?? "",
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
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
                                      name ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "₦${commaValue.format(amount)}",
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
                                          child: GestureDetector(
                                            onTap: () async {
                                              var cartProvider =
                                                  Provider.of<CartProvider>(
                                                      context,
                                                      listen: false);

                                              Map data = {
                                                "product_id": id,
                                                "quantity": 1,
                                              };

                                              await CartHelper()
                                                  .addToCart(context, data)
                                                  .then((isAdded) {
                                                if (isAdded == true) {
                                                  print(data);
                                                  cartProvider.getCart();
                                                  AlertNotification().success(
                                                      context,
                                                      "Product added to Cart");
                                                } else {
                                                  AlertNotification().error(
                                                      context,
                                                      "Error adding product to cart");
                                                }
                                              });
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  const Color(0xffF2F9F3),
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                AppImages.shopping,
                                              )),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
    ]);
  }
}
