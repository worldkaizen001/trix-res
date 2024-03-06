// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';

class Spinner {
  static bool isLoading = false;
  static BuildContext? context;

  static Future<dynamic> show(BuildContext context){
    isLoading = true;
    Spinner.context = context;

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => const Center(
        child: CircularProgressIndicator.adaptive()
      )
    );
  }

  static void remove(){
    if(!Spinner.isLoading) 
      return;

    Navigator.pop(Spinner.context!); // destroy loader
    Spinner.isLoading = false;
    Spinner.context = null;

  }
}