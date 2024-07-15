import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

showToast(String message) {
  // Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
  //     textColor: Colors.white,
  //     fontSize: 14.0);
}

String currentDateTime({String format = 'yyyy-MM-dd'}) {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat(format);
  String formatted = formatter.format(now);

  return formatted.toString();
}
