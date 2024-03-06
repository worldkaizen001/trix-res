import 'package:restaurant/controllers/Helpers/location_helper.dart';
import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/models/place_prediction.dart';
import 'package:restaurant/models/user_profile_model.dart';
import 'package:restaurant/resources/alert.dart';
import 'package:restaurant/resources/app_sizes.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:restaurant/services/comstants.dart';
import 'package:restaurant/widgets/charissa_button.dart';
import 'package:restaurant/widgets/master_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:webview_flutter/webview_flutter.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  TextEditingController locationCrtl = TextEditingController();
    bool useloyalty = false;


  List<PlacePredictions> placePredictionList = [];
  String queryPickupLocation = '';

  void findPickUpPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:ng";
      var res = await LocationHelper.getRequest(autoCompleteUrl);
      if (res == "failed") {
        return;
      }
      if (res["status"] == "OK") {
        var predictions = res["predictions"];
        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();

        setState(() {
          placePredictionList = placesList;
        });
      }
    }
  }

  late final WebViewController _controller;
  String googleUrl = "https://www.google.com/maps";

  bool isLoading = false;
  int selectedStore = 0;

  Map address = {"name": "", "latlon": ""};
  List locations = [];

  TextEditingController locationController = TextEditingController();
  var newName;

  @override
  void initState() {
    super.initState();
    var auth = Provider.of<AuthProvider>(context, listen: false);


    // _controller = WebViewController()
    //   //disabled
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         // if (request.url.contains(success)) {
    //         //   //call the order completed endpoint here
    //         //   return NavigationDecision.prevent;
    //         // }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse(googleUrl));
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      widgets: [
        Center(
          child: Text(
            "Select Location",
            style: GoogleFonts.nunitoSans(
              textStyle: const TextStyle(
                color: ColorManager.pureBlack,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          height: AppSize.s50.h,
          width: double.infinity,
          child: TextFormField(
            controller: locationCrtl,
            onChanged: (value) {
              setState(() {
                queryPickupLocation = value;
                findPickUpPlace(value);
                print(queryPickupLocation);
              });
            },
            cursorWidth: 2,
            cursorHeight: 24,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                        width: 1, color: ColorManager.aECECEC)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                        width: 1, color: ColorManager.aECECEC)),
                hintText: 'Search location...',
                hintStyle: GoogleFonts.nunitoSans(
                  textStyle: const TextStyle(
                    color: Color(0xffB4B4B4),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                suffixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                        width: 1, color: ColorManager.aECECEC))),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        (queryPickupLocation.isEmpty)
            ? Container()
            : Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final predictedPlace = placePredictionList[index];
                    return TextButton(
                        onPressed: () async {
                          placePredictionList = [];

                          queryPickupLocation = "";
                          setState(() {
                            locationCrtl.text = predictedPlace.mainText;
                          });
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.add_location,
                                  color: ColorManager.primaryColor,
                                ),
                                SizedBox(
                                  width: 14.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(predictedPlace.mainText),
                                      SizedBox(
                                        height: 2.0.h,
                                      ),
                                      Text(predictedPlace.secondaryText)
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 14.w,
                            ),
                          ],
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: placePredictionList.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                ),
              ),
      ],
      footer: RestaurantButton(
          textStyle: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
              color: ColorManager.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          title: 'save',
          buttonColor: ColorManager.primaryColor,
          callBack: () async {
            var auth = Provider.of<AuthProvider>(context, listen: false);

            Map userData = {
              "address": locationCrtl.text,
            };

            print(userData);
            await auth.updateUser(context, userData).then((response) {

              if (response["error"] == false) {

                auth.getUser().then((value) {
                  if (value["error"] == false){
                    var data = value["data"]["data"];
                    print("get user data ---> $data");

                    auth.login(data);
                  }
                  AlertNotification().success(context, "Address updated successfully");

                });
        

                // Navigator.pop(context);
              } else {
                AlertNotification().error(context, "Error updating address");
              }
            });
          }),
    );
  }
}
