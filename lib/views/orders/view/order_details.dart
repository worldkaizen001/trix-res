import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant/controllers/Helpers/order_helper.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/resources/image_manager.dart';
import 'package:restaurant/views/cart/view/cart_screen.dart';
import 'package:restaurant/views/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/resources/app_sizes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:another_stepper/another_stepper.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int? id;
  const OrderDetailsScreen({this.id, super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  var emptyPhoto =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

  Future<dynamic>? showOrder;
  @override
  void initState() {
    super.initState();
    showOrder = OrdersHelper().showOrder(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          'Order Details',
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
              color: ColorManager.pureBlack,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: showOrder,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(),
                ],
              ));
            } else if (snapshot.hasError) {
              return const Text("error fetching data");
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              var status = data["data"]["status"];
              List items = data["data"]["items"];
              List tracking = data["data"]["tracking"];
              var riderDetails = data["data"]["rider"];
              var paymentType = data["data"]["pay_method"];
              var paymentUrl = data['data']['payment'];

              var riderName =
                  riderDetails == null ? "" : riderDetails["fullname"];
              var phone = riderDetails == null ? "" : riderDetails["telephone"];
              var riderPhoto =
                  riderDetails == null ? "" : riderDetails["photo"];
              var bikeMake = riderDetails == null
                  ? ""
                  : riderDetails["bike"]["manufacturer"];
              var bikeRegNo =
                  riderDetails == null ? "" : riderDetails["bike"]["reg_no"];

              var id = data["data"]["id"];
              print(id);
              print(paymentType);
              print(status);
              print(paymentUrl);

              var date = data["data"]["created_at"];
              var orderId = data["data"]["reference"];

              List<StepperData> steppebody = tracking.map((e) {
                var date = e["timestamp"];

                return StepperData(
                    title: StepperText(
                      e["event"],
                      textStyle:  GoogleFonts.nunitoSans(
                                    textStyle: const TextStyle(
                                      color: ColorManager.pureBlack,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                    ),
                    subtitle: StepperText(date, textStyle: GoogleFonts.nunitoSans(
                                    textStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                    iconWidget: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: const Icon(null),
                    ));
              }).toList();

              Future<void> viewItems() async {
                return showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      backgroundColor: ColorManager.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      elevation: 0.5,
                      titlePadding: const EdgeInsets.only(left: 15, top: 20),
                      title: Text(
                        "Items",
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            color: ColorManager.pureBlack,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      content: Padding(
                        padding: EdgeInsets.only(
                            left: 15, right:15, bottom: 20, top: 12.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: items.map((item) {
                                var name = item["product"];
                                var amount = item["amount"];

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:  GoogleFonts.nunitoSans(
                                        textStyle: const TextStyle(
                                          color: ColorManager.pureBlack,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Text("₦${commaValue.format(amount)}",style: GoogleFonts.nunitoSans(
                                        textStyle: const TextStyle(
                                          color: ColorManager.pureBlack,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),),
                                  ],
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("okay",style: GoogleFonts.nunitoSans(
                                        textStyle: const TextStyle(
                                          color: ColorManager.primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ))))
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              return data.isEmpty
                  ? const Center(
                      child: Text("Your orders are empty"),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 15,
                        ),
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 10.w, right: 10.w, top: 10.h, bottom: 10),
                            height: 150.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xffFADE70),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order No",
                                      // textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        textStyle: const TextStyle(
                                          color: ColorManager.pureBlack,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "ORD-$orderId",
                                      // textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        textStyle: const TextStyle(
                                          color: ColorManager.primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  date.split('T')[0] ?? "",
                                  // textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: const TextStyle(
                                      color: Color(0xff6F6F6F),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Items(${items.length})",
                                      // textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        textStyle: const TextStyle(
                                          color: ColorManager.pureBlack,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        viewItems();
                                      },
                                      child: Text(
                                        "view all",
                                        // textAlign: TextAlign.center,
                                        style: GoogleFonts.nunitoSans(
                                          textStyle: const TextStyle(
                                            color: ColorManager.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),

                     if (paymentType == "Card" && status == "pending")        Column(
                              children: [
                                 SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        height: 45,
                                        width: 167,
                                        child: ElevatedButton(
                                          
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            elevation: 0.0,
                                            side: const BorderSide(color: ColorManager.primaryColor, width: 1)
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PaymentScreen(
                                                              id, paymentUrl)));
                                            },
                                            child: Text("Make payment",style: GoogleFonts.nunitoSans(
                                            textStyle: const TextStyle(
                                              color: ColorManager.primaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),))),
                                    SizedBox(
                                        height: 45,
                                        width: 167,
                                        child: ElevatedButton(
                                           style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            elevation: 0.0,
                                            side: const BorderSide(color: ColorManager.primaryColor, width: 1)
                                            ),
                                            onPressed: () {},
                                            child: Text("Cancel order",style: GoogleFonts.nunitoSans(
                                            textStyle: const TextStyle(
                                              color: ColorManager.primaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),))),
                                  ],
                                ),
                             
                                 SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                         
                         
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rider Details',
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: const TextStyle(
                                      color: ColorManager.pureBlack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                    height: 120.h,
                                    padding: EdgeInsets.only(
                                        left: 10.w,
                                        right: 10.w,
                                        top: 10.h,
                                        bottom: 10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      // F2F9F3
                                        color: const Color(0xffF9F9F9),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: riderDetails != null &&
                                                status == "processing" ||
                                            status == "completed"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      height: 70,
                                                      width: 70,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(80),
                                                        child: CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                riderPhoto ??
                                                                    emptyPhoto),
                                                      )),
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Name:",
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: ColorManager
                                                                    .pureBlack,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            "Phone No:",
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: ColorManager
                                                                    .pureBlack,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                           "BikeMake:",
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: ColorManager
                                                                    .pureBlack,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            "BikeRegNo:",
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: ColorManager
                                                                    .pureBlack,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      const SizedBox(width: 80,),

                                                      
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            riderName ?? "NA",
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: ColorManager
                                                                    .pureBlack,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            phone ?? "NA",
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: ColorManager
                                                                    .pureBlack,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            bikeMake ?? "NA",
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: ColorManager
                                                                    .pureBlack,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            bikeRegNo ?? "NA",
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: ColorManager
                                                                    .pureBlack,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "No rider assigned to your\n order yet",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.nunitoSans(
                                                  textStyle: const TextStyle(
                                                    color:
                                                        ColorManager.pureBlack,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                              ]),
                          SizedBox(
                            height: 15.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Status',
                                style: GoogleFonts.nunitoSans(
                                  textStyle: const TextStyle(
                                    color: ColorManager.pureBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(children: [
                                AnotherStepper(
                                  stepperList: steppebody,
                                  stepperDirection: Axis.vertical,
                                  iconWidth: 30,
                                  iconHeight: 30,
                                  activeBarColor: Colors.grey,
                                  inActiveBarColor: Colors.grey,
                                  inverted: false,
                                  verticalGap: 15,
                                  activeIndex: 1,
                                  barThickness: 2,
                                ),
                              ]),

                              //
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: riderDetails != null &&
                                            status == "processing" ||
                                        status == "completed"
                                    ? ColorManager.primaryColor
                                    : Colors.grey.shade200,
                                elevation: riderDetails != null &&
                                            status == "processing" ||
                                        status == "completed"
                                    ? 1.0
                                    : 0.0,
                              ),
                              onPressed: riderDetails != null &&
                                          status == "processing" ||
                                      status == "completed"
                                  ? () async {
                                      await openUrlBrowser(
                                          url: 'tel: $phone', status: false);
                                    }
                                  : null,
                              child: Text(
                                'Call Rider',
                                style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                    color: riderDetails != null &&
                                                status == "processing" ||
                                            status == "completed"
                                        ? ColorManager.white
                                        : Colors.blueGrey,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        
                       
                        ]),
                      ),
                    );
            } else {
              throw "something went wrong";
            }
          }),
    );
  }

 
}

Future openUrlBrowser({
  required String url,
  required bool status,
}) async {
  final uri = url;

  if (await canLaunch(uri)) {
    await launch(
      uri,
      forceWebView: status,
      enableJavaScript: true,
    );
  }
}

// final Uri _url = Uri.parse('https://flutter.dev');

// Future<void> _launchUrl() async {
//   if (!await launchUrl(_url)) {
//     throw Exception('Could not launch');
//   }}
