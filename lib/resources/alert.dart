import 'package:another_flushbar/flushbar.dart';
import 'package:restaurant/resources/color_manager.dart';
import 'package:flutter/material.dart';

class AlertNotification{

  error(context, msg){

    return  Flushbar(
        margin: const EdgeInsets.only(),
        backgroundColor: Colors.red,
        borderRadius: BorderRadius.circular(15),
        flushbarPosition: FlushbarPosition.TOP,
        title: "Hey 🖐",
        message: msg,
        duration: const Duration(seconds: 3),
      ).show(context);

  }


 

  success(context, msg){

    return  Flushbar(
        margin: const EdgeInsets.only(),
        backgroundColor: ColorManager.primaryColor,
        borderRadius: BorderRadius.circular(15),
        flushbarPosition: FlushbarPosition.TOP,
        title: "Hey 🖐",
        message: msg,
        duration: const Duration(seconds: 3),
      ).show(context);

  }

}