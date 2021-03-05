import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastClass extends StatelessWidget {
  static showToast(
      String message,
      ToastGravity toastGravity,
      Color backgroundColor,
      Color textColor,
      double fontSize,
      Toast toastLength) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        gravity: toastGravity,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
