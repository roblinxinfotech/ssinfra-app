import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/controller/loginScreenController.dart';

import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenController loginScreenController = Get.put(
    LoginScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().colorE1E5FD,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/loginScreenBg.png"),
          ),
          gradient: LinearGradient(
            colors: [
              AppColors().colorE1E5FD,
              Colors.white.withValues(alpha: 0.6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 14.w),
          child: ListView(
            children: [
              SizedBox(height: 20.w),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    CommonWidgets().commonText(
                      text: "Welcome Back",
                      fontSize: 18.sp,
                      fontColor: AppColors().color1E1E1E,
                      fontFamily: "PlusJakartaSansMedium",
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.w),
              Container(
                decoration: BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      height: 25.w,
                      width: 70.w,
                      "assets/images/splashLogo.png",
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5.w),
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  border: Border.all(color: AppColors().colorFFFFFF),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgets().commonText(
                      text:
                          "Sign in to find form summaries and easily access knowledge every day.",
                      fontSize: 16.sp,
                      fontColor: AppColors().color1E1E1E,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.w100,
                    ),
                    SizedBox(height: 3.w),
                    CommonWidgets().commonText(
                      text: "Username",
                      fontSize: 16.sp,
                      fontColor: AppColors().color1E1E1E,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 1.w),
                    Container(
                      height: 40,
                      child: TextFormField(
                        controller: loginScreenController.userName.value,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors().color787878,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors().colorD7D7D7,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors().color5B6AEA,
                            ),
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                          border: const OutlineInputBorder(),
                          hintText: "User Name",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: "PlusJakartaSansRegular",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.w),
                    CommonWidgets().commonText(
                      text: "Password",
                      fontSize: 16.sp,
                      fontColor: AppColors().color1E1E1E,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 1.w),
                    Obx(() {
                      return Container(
                        height: 40,
                        child: TextFormField(
                          controller: loginScreenController.password.value,
                          obscureText: loginScreenController.showPassword.value,
                          decoration: InputDecoration(
                            suffixIcon: Obx(
                              () => InkWell(
                                onTap: () {
                                  loginScreenController.showPassword.value =
                                      !loginScreenController.showPassword.value;
                                },
                                child: Icon(
                                  loginScreenController.showPassword.value
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  color: AppColors().colorAFAAAA,
                                ),
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors().color787878,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors().colorD7D7D7,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors().color5B6AEA,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(left: 10),
                            border: const OutlineInputBorder(),
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }),

                    SizedBox(height: 6.w),
                    GestureDetector(
                      onTap: () async {
                        await loginScreenController.userLogin(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: AppColors().color5B6AEA,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Center(
                          child: CommonWidgets().commonText(
                            text: "Log In",
                            fontSize: 16.sp,
                            fontColor: AppColors().colorFFFFFF,
                            fontFamily: "PlusJakartaSansRegular",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
