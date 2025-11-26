import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
  RxString versionName = "".obs;
  var currentLocale = const Locale('en', 'US').obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfileData();
  }

  getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List? permission = await prefs.getStringList("permissions");

    if (permission?.length != 0 && permission != null) {
      permissions.value = permission!;
    }
    final info = await PackageInfo.fromPlatform();

    String version = info.version; // Example: "1.0.5"
    String buildNumber = info.buildNumber; // Example: "27"
    versionName.value = version + "+" + buildNumber;
    print("App Version: $version");
    print("Build Number: $buildNumber");

    try {
      var res = await ApiServices().getData(url: ApiEndPoint.profile);
      log(res.toString());
      profileModel.value = ProfileModel.fromJson(json.decode(res));
      await loadSavedLanguage();
    } catch (e) {
      errorShow.value = true;
    }
    loader.value = false;
  }

  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('languageCode');
    final countryCode = prefs.getString('countryCode');

    if (langCode != null) {
      currentLocale.value = Locale(langCode, countryCode ?? '');
      Get.updateLocale(currentLocale.value);
    } else {
      // If no language saved, default to English
      currentLocale.value = const Locale('en', 'US');
      Get.updateLocale(currentLocale.value);
    }
  }

  Future<void> changeLanguage(Locale locale) async {
    currentLocale.value = locale;
    Get.updateLocale(locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    await prefs.setString('countryCode', locale.countryCode ?? '');
  }

  /// Helper to get dropdown title
  String get currentLanguageTitle {
    switch (currentLocale.value.languageCode) {
      case 'gu':
        return 'ગુજરાતી';
      default:
        return 'English (US)';
    }
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
