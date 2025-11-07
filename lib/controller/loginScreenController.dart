import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/model/loginModel.dart';
import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';
import 'package:ssinfra/view/formScreen.dart';

class LoginScreenController extends GetxController {
  Rx<TextEditingController> userName = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<LoginModel> loginModel = LoginModel().obs;
  RxBool showLoader = false.obs;
  RxBool showPassword = false.obs;

  userLogin(context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Image.asset(
            "assets/images/splashLoader.gif",
            height: 25.w,
            width: 25.w,
            fit: BoxFit.fill,
          ),
        );
      },
    );
    await Future.delayed(Duration(seconds: 3), () {});
    try {
      final authUserData = {
        "username": userName.value.text.toString(),
        "password": password.value.text.toString(),
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await ApiServices().postData(
        url: ApiEndPoint.login,
        data: authUserData,
      );
      print(response);
      loginModel.value = LoginModel.fromJson(json.decode(response));

      if (loginModel.value.status == 200) {
        prefs.setString(
          "tokenValue",
          loginModel.value.data?.token.toString() ?? "",
        );

        Get.offAll(FormScreen());
      } else {
        Navigator.pop(context);
        Get.snackbar("Message", loginModel.value.message.toString());
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
    }

  }
}
