import 'package:restaurant/controllers/Helpers/order_helper.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/icon_manager.dart';
import 'package:restaurant/services/storage/local_storage.dart';
import 'package:restaurant/views/orders/view/order_details.dart';
import 'package:restaurant/views/orders/widget/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/resources/app_sizes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List orderStatus = ['All', 'Completed', 'Pending', 'Cancelled'];

  late dynamic userDetails;

  dynamic currentStatus;
  Future<dynamic>? getAllOrders;
  Future<dynamic>? getPendingOrders;
  Future<dynamic>? getCompletedOrders;
  Future<dynamic>? getCancelledOrders;

  @override
  void initState() {
    super.initState();
    currentStatus = 0;
    getAllOrders = OrdersHelper().getAllOrders();
    getPendingOrders = OrdersHelper().getPendingOrders();
    getCompletedOrders = OrdersHelper().getCompletedOrders();
    getCancelledOrders = OrdersHelper().getCancelledOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F9F3),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Orders",
                    style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                        color: ColorManager.pureBlack,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 27.h,
                  ),
                  SizedBox(
                    height: 35,
                    // width: 60,
                    child: ListView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: orderStatus.length,
                        itemBuilder: (context, index) {
                          var title = orderStatus[index];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                currentStatus = index;
                              });
                            },
                            child: SizedBox(
                              width: 100,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: currentStatus == index ? 1.0 : 0.0,
                                  color: currentStatus == index
                                      ? ColorManager.yellow
                                      : ColorManager.white,
                                  child: Center(
                                    child: Text(
                                      title,
                                      style: GoogleFonts.nunitoSans(
                                        textStyle: TextStyle(
                                          color: currentStatus == index
                                              ? ColorManager.primaryColor
                                              : const Color(0xff9D9D9D),
                                          fontSize: 15.sp,
                                          fontWeight: currentStatus == index
                                              ? FontWeight.w600
                                              : FontWeight.w400,
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
                ],
              ),
            ),
            SizedBox(
              height: 27.h,
            ),
            if (currentStatus == 0)
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: FutureBuilder(
                      future: getAllOrders,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (snapshot.hasError) {
                          return const Text("error fetching data");
                        } else if (snapshot.hasData) {
                          var data = snapshot.data;
                          var object = data["data"];
                          print("all orders objcet $object");
                          return object.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      "No active orders",
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
                              : SizedBox(
                                  height: 400.h,
                                  child: ListView.builder(
                                      itemCount: object?.length,
                                      itemBuilder: (context, index) {
                                        var amount =
                                            data["data"][index]["amount"];
                                        var id = data["data"][index]["id"];
                                        var status =
                                            data["data"][index]["status"];
                                        var date =
                                            data["data"][index]["created_at"];
                                        var ref =
                                            data["data"][index]["reference"];

                                        return Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 10.h),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderDetailsScreen(
                                                            id: id,
                                                          )));
                                            },
                                            child: OrderWidget(
                                              ref: ref,
                                              amount: amount,
                                              status: status,
                                              date: date,
                                            ),
                                          ),
                                        );
                                      }),
                                );
                        } else {
                          throw "something went wrong";
                        }
                      }),
                ),
              ),
            if (currentStatus == 1)
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: FutureBuilder(
                      future: getCompletedOrders,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (snapshot.hasError) {
                          return const Text("error fetching data");
                        } else if (snapshot.hasData) {
                          var data = snapshot.data;
                          // var status = data["data"]["status"];
                          return data.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      "No completed order yet",
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
                              : SizedBox(
                                  height: 400.h,
                                  child: ListView.builder(
                                      itemCount: data?.length,
                                      itemBuilder: (context, index) {
                                        var id = data[index]["id"];

                                        var amount = data[index]["amount"];
                                        var status = data[index]["status"];
                                        var date = data[index]["created_at"];
                                        var ref = data[index]["reference"];

                                        return Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 10.h),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderDetailsScreen(
                                                            id: id,
                                                          )));
                                            },
                                            child: OrderWidget(
                                              ref: ref,
                                              amount: amount,
                                              status: status,
                                              date: date,
                                            ),
                                          ),
                                        );
                                      }),
                                );
                        } else {
                          throw "something went wrong";
                        }
                      }),
                ),
              ),
            if (currentStatus == 2)
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: FutureBuilder(
                      future: getPendingOrders,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (snapshot.hasError) {
                          return const Text("error fetching data");
                        } else if (snapshot.hasData) {
                          var data = snapshot.data;
                          // var status = data["data"]["status"];
                          return data.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      "No Pending order yet",
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
                              : SizedBox(
                                  height: 400.h,
                                  child: ListView.builder(
                                      itemCount: data?.length,
                                      itemBuilder: (context, index) {
                                        var id = data[index]["id"];

                                        var amount = data[index]["amount"];
                                        var status = data[index]["status"];
                                        var date = data[index]["created_at"];
                                        var ref = data[index]["reference"];

                                        return Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 10.h),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderDetailsScreen(
                                                            id: id,
                                                          )));
                                            },
                                            child: OrderWidget(
                                              ref: ref,
                                              amount: amount,
                                              status: status,
                                              date: date,
                                            ),
                                          ),
                                        );
                                      }),
                                );
                        } else {
                          throw "something went wrong";
                        }
                      }),
                ),
              ),
            if (currentStatus == 3)
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: FutureBuilder(
                      future: getCancelledOrders,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (snapshot.hasError) {
                          return const Text("error fetching data");
                        } else if (snapshot.hasData) {
                          var data = snapshot.data;
                          return data.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      "No cancelled order yet",
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
                              : SizedBox(
                                  height: 400.h,
                                  child: ListView.builder(
                                      itemCount: data?.length,
                                      itemBuilder: (context, index) {
                                        var id = data[index]["id"];

                                        var amount = data[index]["amount"];
                                        var status = data[index]["status"];
                                        var date = data[index]["created_at"];
                                        var ref = data[index]["reference"];

                                        return Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 10.h),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderDetailsScreen(
                                                            id: id,
                                                          )));
                                            },
                                            child: OrderWidget(
                                              ref: ref,
                                              amount: amount,
                                              status: status,
                                              date: date,
                                            ),
                                          ),
                                        );
                                      }),
                                );
                        } else {
                          throw "something went wrong";
                        }
                      }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          "No cancelled order yet",
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
              color: ColorManager.pureBlack,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
