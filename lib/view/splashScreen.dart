import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/view/formScreen.dart';
import 'package:ssinfra/view/homeScreen.dart';
import 'package:ssinfra/view/talukaScreen.dart';
import 'package:ssinfra/view/teamScreen.dart';
import 'package:ssinfra/view/villageScreen.dart';

import '../main.dart';
import '../utils/appColors.dart';
import 'dashBoardScreen.dart';
import 'loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var a = Timer.periodic((Duration(seconds: 2)), (a) async {
      a.cancel();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (await prefs.getString("tokenValue") != null) {
        Get.offAll(DashBoardScreen());
      } else {
        // Get.to(VillageScreen());
        Get.offAll(LoginScreen());
      }
      // Get.to(DynamicFormScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors().colorE1E5FD,
              Colors.white.withValues(alpha: 0.6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 80.w,
                width: 80.w,
                child: Image.asset(
                  "assets/images/splashLoader.gif",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
