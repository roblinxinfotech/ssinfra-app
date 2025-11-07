import 'package:flutter/cupertino.dart';

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
        decoration:  line
      ),

      textAlign: textAlign,
      overflow: overFlow,
      maxLines: maxline,
    );
  }
}
