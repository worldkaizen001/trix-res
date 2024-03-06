import 'package:restaurant/controllers/Helpers/order_helper.dart';
import 'package:restaurant/controllers/providers/auth_provider.dart';
import 'package:restaurant/controllers/providers/cart_provider.dart';
import 'package:restaurant/views/successful_order.dart';
import 'package:restaurant/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  final int orderId;
  final String paymentUrl;
  const PaymentScreen(this.orderId, this.paymentUrl, {super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController _controller;
  String success = "https://restaurant.me/payment/success";

  @override
  void initState() {


    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            Map url = Uri.parse(request.url).queryParameters;

            if (request.url.contains(success)) {
              Map data = {"id": widget.orderId, "reference": url['reference']};

              Spinner.show(context);

              await OrdersHelper().completeOrder(data).then((response) {

                var auth = Provider.of<AuthProvider>(context, listen: false);
                  auth.getUser().then((value) {
                  if (value["error"] == false){
                    var data = value["data"]["data"];
                  

                    auth.login(data);
                  }
                });
                  //todo:

                ;
                 
                
              
                // cart.clear();
                

                Spinner.remove();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ThanksForOderingScreen(
                              id: widget.orderId,
                            )));
              });

              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
