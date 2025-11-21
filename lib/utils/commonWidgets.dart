import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CommonWidgets {
  Widget commonText({
    String? text,
    double? fontSize,
    Color? fontColor,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    String? fontFamily,
    TextOverflow? overFlow,
    int? maxline,
    TextDecoration? line,
    bool? softWrap,
  }) {
    return Text(
      text.toString(),
      softWrap: softWrap,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        decoration: line,
      ),

      textAlign: textAlign,
      overflow: overFlow,
      maxLines: maxline,
    );
  }

  showSnackBar(
    String? titleText,
    String? messageText,
    Color? bgColor,
    Color? textColor,
  ) {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        titleText.toString(),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      messageText: Text(
        messageText.toString(),
        style: TextStyle(fontSize: 16, color: textColor),
      ),
      backgroundColor: bgColor,
      colorText: textColor,
    );
  }
}
