// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:cache_stream/cache_stream.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant/controllers/Helpers/cart_helper.dart';
import 'package:restaurant/controllers/Helpers/categories_helper.dart';
import 'package:restaurant/controllers/Helpers/dashboard_helper.dart.dart';
import 'package:restaurant/controllers/Helpers/notification_helper.dart';
import 'package:restaurant/controllers/Helpers/product_helper.dart';
import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/controllers/providers/cart_provider.dart';
import 'package:restaurant/controllers/providers/notification_provider.dart';
import 'package:restaurant/controllers/providers/stores_provider.dart';
import 'package:restaurant/models/user_profile_model.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/app_sizes.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/icon_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/services/firebase_handler.dart';
import 'package:restaurant/services/storage/local_storage.dart';
import 'package:restaurant/views/cart/view/cart_screen.dart';
import 'package:restaurant/views/homepage/view/search_item_screen.dart';
import 'package:restaurant/views/homepage/widget/product_preview_widget.dart';
import 'package:restaurant/views/homepage/widget/product_widget.dart';
import 'package:restaurant/views/notification/view/notification_screen.dart';
import 'package:restaurant/views/product_details/view/product_details.dart';
import 'package:restaurant/views/profile/view/proflle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final value = NumberFormat("#,##0.00", "en_US");
  var emptyPhoto =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
  late TabController tabController;
  late AuthProvider authProvider;
  CacheStream cacheManager = CacheStream();

  // List storeList = ["Restaurant", "Mini Mart", "Lounge", "Ala Carte"];
  // final List<Map> myProducts =
  //     List.generate(20, (index) => {"id": index, "name": "Product $index"})
  //         .toList();
  List<dynamic> storeList = [];
  List<dynamic> categories = [];
  int selectedStore = 0;
  bool isLoading = true;
  bool addedToCart = false;
  dynamic unRead = 0;
  dynamic inCart;
  bool isTapped = false;

  Future<dynamic> getUnread() async {
    List allunRead = await NotificationHelper().allUnredNotification();
    setState(() {
      unRead = allunRead;
    });
    print(unRead.length);
  }

  loadUserData() {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    auth.getUser().then((value) {
      if (value["error"] == false) {
        var data = value["data"]["data"];
        print("get user data ---> $data");

        auth.login(data);
      }
    });
  }

  //  dynamic unRead;

  @override
  void initState() {
    super.initState();
    // getUnread ();

    getAllStores();
    // loadUserData();
  }

  Future getAllStores() async {
    final storeProvider = Provider.of<StoreProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final user = Provider.of<AuthProvider>(context, listen: false);

    // user.user;

    cartProvider.getCart();

    setState(() {
      storeList = storeProvider.stores;
      isLoading = false;

      getCategory();
    });
  }

  Future getCategory() async {
    Map store = storeList[selectedStore];

    if (store.isNotEmpty) {
      categories = store["categories"];
    }

    setState(() {});
  }

  Future GetProduct(Map category) async {
    final cat = await CategoryHelper().getCategory(category['id']);

    return cat['products'] ?? [];

    // if(cat.isNotEmpty){

    //   return cat['products'];

    // }

    // return [];
  }

  @override
  void dispose() {
    // tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProfileModel user = context.watch<AuthProvider>().user;
    var cart = context.watch<CartProvider>().items;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // SizedBox(
                        //   width: 40.w,
                        //   height: 40.h,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: ((context) => ProfileScreen())));
                        //     },
                        //     child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(50),
                        //       child: CachedNetworkImage(
                        //         imageUrl: user?.photo.toString() ?? emptyPhoto,
                        //         fit: BoxFit.cover,
                        //         placeholder: (context, url) => const Center(
                        //             child: CircularProgressIndicator()),
                        //         errorWidget: (context, url, error) =>
                        //             const Icon(Icons.error),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: ((context) => ProfileScreen())));
                        //   },
                        //   child: CircleAvatar(
                        //     maxRadius: 18,
                        //     backgroundImage: NetworkImage(user.photo == null
                        //         ? emptyPhoto
                        //         : user.photo.toString() ?? ""),
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ProfileScreen())));
                          },
                          child: SizedBox(
                              height: 36,
                              width: 36,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                      imageUrl: user.photo == null
                                          ? emptyPhoto
                                          : user.photo.toString()))),
                        ),

                        SizedBox(
                          width: 8.w,
                        ),

                        Text("Hi ${user.firstname}",
                            style: GoogleFonts.nunitoSans(
                              textStyle: const TextStyle(
                                color: ColorManager.pureBlack,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartScreen()));
                          },
                          child: SizedBox(
                            height: 40,
                            width: 30,
                            // color: Colors.black,
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    bottom: 21,
                                    child: SizedBox(
                                        height: 17,
                                        width: 17,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              ColorManager.primaryColor,
                                          child: Center(
                                              child: Text(
                                            cart.length.toString(),
                                            style: GoogleFonts.nunitoSans(
                                              textStyle: TextStyle(
                                                color: ColorManager.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )),
                                        ))),
                                Positioned(
                                  left: 0,
                                  bottom: 8,
                                  child: SvgPicture.asset(
                                    IconsManager.eCart2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          height: 31.h,
                          width: 31.w,
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotifcationScreen()));
                            },
                            child: CircleAvatar(
                              backgroundColor: Color(0xffF2F9F3),
                              child: Center(
                                  child:
                                      SvgPicture.asset(AppImages.notification)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 10),
                child: SizedBox(
                  height: 45.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: storeList.length,
                      itemBuilder: (context, index) {
                        Map store = storeList[index];

                        return GestureDetector(
                          onTap: () {
                            // setState(() {
                            //   selectedStore = index;
                            //   getCategory();
                            // });
                          },
                          child: SizedBox(
                            //  height: 20.h,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5, top: 5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    elevation:
                                        selectedStore == index ? 1.0 : 0.000,
                                    backgroundColor: selectedStore == index
                                        ? ColorManager.primaryColor
                                        : null),
                                onPressed: () {
                                  setState(() {
                                    selectedStore = index;
                                    getCategory();
                                  });
                                },
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(6)),
                                // elevation: selectedStore == index ? 1.0 : 0.00,
                                // color: selectedStore == index
                                //     ? ColorManager.primaryColor
                                //     : null,
                                child: Center(
                                  child: Text(
                                    store["name"],
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: TextStyle(
                                        color: selectedStore == index
                                            ? ColorManager.white
                                            : const Color(0xff959595),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Container(
              // height: 620,
              padding: EdgeInsets.only(
                  top: 10.h, left: 10.w, right: 10.w, bottom: 0),
              margin: EdgeInsets.zero,
              color: const Color(0xffF2F9F3),
              // color: Colors.red,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                addRepaintBoundaries: false,
                addAutomaticKeepAlives: false,
                shrinkWrap: true,
                children: [
                  // SizedBox(
                  //   height: 40,
                  // ),
                  // SizedBox(
                  //   height: AppSize.s50.h,
                  //   width: double.infinity,
                  //   child: TextFormField(
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => SearchItemScreen()));
                  //     },
                  //     cursorWidth: 3,
                  //     cursorHeight: 22,
                  //     decoration: InputDecoration(
                  //         enabledBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(50),
                  //             borderSide: const BorderSide(
                  //                 width: 1, color: ColorManager.aECECEC)),
                  //         focusedBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(50),
                  //             borderSide: const BorderSide(
                  //                 width: 1, color: ColorManager.aECECEC)),
                  //         hintText: 'Search items...',
                  //         hintStyle: GoogleFonts.nunitoSans(
                  //           textStyle: const TextStyle(
                  //             color: Color(0xffB4B4B4),
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w400,
                  //           ),
                  //         ),
                  //         suffixIcon: const Icon(Icons.search),
                  //         filled: true,
                  //         fillColor: Colors.white,
                  //         border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(50),
                  //             borderSide: const BorderSide(
                  //                 width: 1, color: ColorManager.aECECEC))),
                  //   ),
                  // ),

                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.zero,
                      // color: Colors.black,

                      margin:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DefaultTabController(
                              length: categories.length, // length of tabs
                              initialIndex: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: TabBar(
                                      physics: BouncingScrollPhysics(),
                                      labelPadding: EdgeInsets.zero,
                                      indicatorPadding:
                                          EdgeInsets.only(top: 0, left: 0),
                                      indicatorWeight: 4.0,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicatorColor: ColorManager.primaryColor,
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                      labelColor: ColorManager.pureBlack,
                                      unselectedLabelColor: Color(0xffC2BBBB),
                                      tabs: [
                                        ...categories.map<Widget>((e) {
                                          return Tab(text: e["name"]);
                                        }).toList()
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height -
                                        300,
                                    child: TabBarView(children: [
                                      for (int i = 0;
                                          i < categories.length;
                                          i++)
                                        FutureBuilder(
                                          future: GetProduct(categories[i]),
                                          builder: (context, snapshot) {
                                            List? products = snapshot.data;
                                            print(products);

                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }

                                            // if(products.isEmpty){
                                            //   //

                                            // }

                                            return GridView.builder(
                                                addAutomaticKeepAlives: false,
                                                addRepaintBoundaries: false,
                                                shrinkWrap: true,
                                                padding: EdgeInsets.only(
                                                    top: 15.h, bottom: 40.h),
                                                gridDelegate:
                                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent: 200,
                                                        childAspectRatio: 0.82,
                                                        crossAxisSpacing: 15,
                                                        mainAxisSpacing: 15),
                                                itemCount: products?.length,
                                                itemBuilder:
                                                    (BuildContext ctx, index) {
                                                  var id =
                                                      products?[index]["id"];

                                                  var name =
                                                      products?[index]["name"];

                                                  var amount = products?[index]
                                                      ["amount"];
                                                  var description =
                                                      products?[index]
                                                          ["description"];
                                                  var image = products?[index]
                                                      ["dp_image"];

                                                  return Container(
                                                    height: 234.h,
                                                    width: double.infinity.w,
                                                    decoration: BoxDecoration(
                                                      color: ColorManager.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 190.w,
                                                          height: 133.h,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return ProductPreviewWidget(
                                                                      image:
                                                                          image,
                                                                      name:
                                                                          name,
                                                                      amount:
                                                                          amount,
                                                                      desc:
                                                                          description,
                                                                      productId:
                                                                          id,
                                                                    );
                                                                  });
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          9),
                                                              child:
                                                                  CachedNetworkImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                imageUrl:
                                                                    image ?? "",
                                                                placeholder: (context,
                                                                        url) =>
                                                                    const Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(Icons
                                                                        .error),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 14,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 9.w,
                                                                  right: 9.w),
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  name ?? "",
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: GoogleFonts
                                                                      .nunitoSans(
                                                                    textStyle:
                                                                        TextStyle(
                                                                      color: ColorManager
                                                                          .pureBlack,
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        print(
                                                                            inCart);
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "₦${value.format(amount)}",
                                                                        // "N${amount.toString()}",
                                                                        style: GoogleFonts
                                                                            .nunitoSans(
                                                                          textStyle:
                                                                              TextStyle(
                                                                            color:
                                                                                ColorManager.primaryColor,
                                                                            fontSize:
                                                                                16.sp,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          40.h,
                                                                      width:
                                                                          40.w,
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          if (isTapped ==
                                                                              true) {
                                                                            return;
                                                                          }
                                                                          setState(
                                                                              () {
                                                                            isTapped =
                                                                                true;
                                                                          });
                                                                          var cartProvider = Provider.of<CartProvider>(
                                                                              context,
                                                                              listen: false);

                                                                          Map data =
                                                                              {
                                                                            "product_id":
                                                                                id,
                                                                            "quantity":
                                                                                1,
                                                                          };

                                                                          await CartHelper()
                                                                              .addToCart(context, data)
                                                                              .then((isAdded) {
                                                                            if (isAdded ==
                                                                                true) {
                                                                              // setState(() {
                                                                              //   isTapped = false;
                                                                              // });
                                                                              // setState(() {
                                                                              //   inCart = isAdded;
                                                                              // });
                                                                              // print("inCart $inCart");
                                                                              cartProvider.getCart();
                                                                              AlertNotification().success(context, "Product added to Cart");
                                                                            } else {
                                                                              AlertNotification().error(context, "Error adding product to cart");
                                                                            }
                                                                          });
                                                                        },
                                                                        child:

                                                                            // isTapped
                                                                            //     ? const Center(
                                                                            //         child: SizedBox(
                                                                            //         height: 10,
                                                                            //         width: 10,
                                                                            //         child: CircularProgressIndicator.adaptive(
                                                                            //           backgroundColor: Colors.white,
                                                                            //         ),
                                                                            //       ))
                                                                            //     :
                                                                            CircleAvatar(
                                                                          backgroundColor:
                                                                              const Color(0xffF2F9F3),
                                                                          child: Center(
                                                                              child: SvgPicture.asset(
                                                                            height:
                                                                                15,
                                                                            width:
                                                                                15,
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
                                                });
                                          },
                                        )
                                    ]),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
