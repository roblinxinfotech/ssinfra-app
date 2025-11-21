import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssinfra/model/profileModel.dart';
import 'package:ssinfra/model/talukaListModel.dart';
import 'package:ssinfra/model/villageListModel.dart';
import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';
import 'package:ssinfra/view/loginScreen.dart';
import 'package:ssinfra/view/splashScreen.dart';

import '../utils/commonWidgets.dart';

class ProfileScreenController extends GetxController {
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  RxBool loader = true.obs;
  RxBool errorShow = false.obs;
  RxList permissions = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfileData();
  }

  getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List? permission = await prefs.getStringList("permissions");
    if (permission?.length != 0) {
      permissions.value = permission!;
    }
    // await   Future.delayed(Duration(seconds: 5),(){});
    try {
      var res = await ApiServices().getData(url: ApiEndPoint.profile);
      log(res.toString());
      profileModel.value = ProfileModel.fromJson(json.decode(res));
    } catch (e) {
      errorShow.value = true;
    }
    loader.value = false;
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // await   Future.delayed(Duration(seconds: 5),(){});
    try {
      var res = await ApiServices().postData(url: ApiEndPoint.logOut);

      var datas = jsonDecode(res);

      if (datas["status"] == 200) {
        await prefs.remove("tokenValue");
        await prefs.remove("permissions");
        CommonWidgets().showSnackBar(
          "Success",
          datas["message"],
          Colors.green,
          Colors.white,
        );
        Get.offAll(LoginScreen());
      } else {
        CommonWidgets().showSnackBar(
          "Failed",
          datas["message"],
          Colors.red,
          Colors.white,
        );
      }
    } catch (e) {}
  }

  getPdf() async {
    try {
      var a = await ApiServices().getPdf(url: ApiEndPoint.iCard);
      if (a == 200) {
        CommonWidgets().showSnackBar(
          "Message",
          "Pdf loaded successfully",
          Colors.green,
          Colors.white,
        );
      } else {
        CommonWidgets().showSnackBar(
          "Message",
          "Failed",
          Colors.red,
          Colors.white,
        );
      }
    } catch (e) {
      CommonWidgets().showSnackBar(
        "Message",
        "Failed",
        Colors.red,
        Colors.white,
      );
    }
  }
}
