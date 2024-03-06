

import 'package:restaurant/controllers/Helpers/cart_helper.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {

  List<dynamic> items = [];

  Future<dynamic> getCart() async {

    items = await CartHelper().getCart();

    notifyListeners();
  }

  List<Map> loadCart() {
    var cart = items.map<Map>((item){

      return {
        'product_id': item['product']['id'],
        'quantity': item['quantity']
      };

    }).toList();

    return cart;

  }

}