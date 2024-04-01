import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class utils {
  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 7,
        backgroundColor: const Color.fromARGB(255, 5, 1, 1),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
