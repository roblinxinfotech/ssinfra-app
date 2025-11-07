import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().colorE1E5FD,
      body: SafeArea(
        child: Container(
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
          child: Padding(
            padding: EdgeInsets.only(left: 3.w, right: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/backWard.png",
                            height: 25.sp,
                            width: 25.sp,
                            fit: BoxFit.contain,
                          ),
                          Container(height: 25.sp, width: 25.sp),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              CommonWidgets().commonText(
                                text: "PROFILE",
                                fontSize: 18.sp,
                                fontColor: AppColors().color1E1E1E,
                                fontFamily: "PlusJakartaSansMedium",
                                fontWeight: FontWeight.bold,
                              ),
                              Container(
                                height: 1,
                                width: 22.w,
                                color: AppColors().color5B6AEA,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [Container(height: 25.sp, width: 25.sp)],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.w),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    height: 25.w,
                    width: 25.w,
                    "assets/icons/personTest.png",
                  ),
                ),
                SizedBox(height: 4.w),
                CommonWidgets().commonText(
                  text: "Shubham Joshi",
                  fontSize: 18.sp,
                  fontColor: AppColors().color1E1E1E,
                  fontFamily: "PlusJakartaSansMedium",
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 1.w),
                CommonWidgets().commonText(
                  text: "shubham47@gmail.com",
                  fontSize: 18.sp,
                  fontColor: AppColors().color5B6AEA,
                  fontFamily: "PlusJakartaSansRegular",
                  fontWeight: FontWeight.w400,
                ),

                SizedBox(height: 10.w),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/blackProfile.svg",
                      height: 20.sp,
                      width: 20.sp,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 4.w),
                    CommonWidgets().commonText(
                      text: "Edit Profile",
                      fontSize: 18.sp,
                      fontColor: AppColors().color1E1E1E,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(height: 4.w),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/blackNotification.svg",
                      height: 20.sp,
                      width: 20.sp,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 4.w),
                    CommonWidgets().commonText(
                      text: "Notifications",
                      fontSize: 18.sp,
                      fontColor: AppColors().color1E1E1E,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(height: 4.w),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/blackLock.svg",
                      height: 20.sp,
                      width: 20.sp,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 4.w),
                    CommonWidgets().commonText(
                      text: "Forgot Password",
                      fontSize: 18.sp,
                      fontColor: AppColors().color1E1E1E,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(height: 6.w),
                CommonWidgets().commonText(
                  text: "Version 1.0.0",
                  fontSize: 18.sp,
                  fontColor: AppColors().color5B6AEA,
                  fontFamily: "PlusJakartaSansRegular",
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
