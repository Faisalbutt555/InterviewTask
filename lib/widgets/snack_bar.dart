import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

showCustomFlushbar(BuildContext context, String title, String mesage) {
  Flushbar(
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(05),
    padding: EdgeInsets.all(05),
    borderRadius: BorderRadius.circular(06),
    backgroundGradient: LinearGradient(
      colors: [Colors.grey.shade800, Colors.grey.shade700],
      stops: [0.6, 1],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    flushbarPosition: FlushbarPosition.TOP,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: title,
    message: mesage,
  )..show(context);
}
