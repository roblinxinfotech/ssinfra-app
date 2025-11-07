import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                // color: Colors.purple,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Image.asset(
                      "assets/icons/backWard.png",
                      height: 25.sp,
                      width: 25.sp,
                      fit: BoxFit.contain,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            CommonWidgets().commonText(
                              text: "NOTIFICATION",
                              fontSize: 18.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansMedium",
                              fontWeight: FontWeight.bold,
                            ),
                            Container(
                              height: 1,
                              width: 38.w,
                              color: AppColors().color5B6AEA,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(height: 25.sp, width: 25.sp),
                  ],
                ),
              ),
              SizedBox(height: 3.w),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 2.w, left: 3.w, right: 3.w),
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 2.w),
                      padding: EdgeInsets.all(3.w),

                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            spreadRadius: 2,
                            blurRadius: 10,
                          ),
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/talukaListBg.png"),
                        ),
                        color: AppColors().colorD9D9D9,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: CommonWidgets().commonText(
                                          text: "Shubham Joshi",
                                          fontSize: 18.sp,
                                          fontColor: AppColors().color1E1E1E,
                                          fontFamily: "PlusJakartaSansMedium",
                                          fontWeight: FontWeight.w800,
                                          maxline: 2,
                                          softWrap: true,
                                          overFlow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Column(
                                children: [
                                  CommonWidgets().commonText(
                                    text: "Assigned",
                                    fontSize: 15.sp,
                                    fontColor: AppColors().color666666,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // Container(
                                  //   height: 20.sp,
                                  //   width: 20.sp,
                                  //   margin: EdgeInsets.only(top: 2.w),
                                  //   decoration: BoxDecoration(
                                  //     boxShadow: [
                                  //       BoxShadow(
                                  //         color: Colors.black12,
                                  //         spreadRadius: 2,
                                  //         blurRadius: 20,
                                  //         offset: Offset(0, 2),
                                  //       ),
                                  //     ],
                                  //   ),
                                  //   child: ClipRRect(
                                  //     borderRadius: BorderRadius.circular(50),
                                  //     child: Image.asset(
                                  //       "assets/images/lbImage.png",
                                  //       fit: BoxFit.fill,
                                  //     ),
                                  //   ),
                                  // ),
                                  // CommonWidgets().commonText(
                                  //   text: "Not Assign",
                                  //   fontSize: 15.sp,
                                  //   fontColor: AppColors().colorFF0000,
                                  //   fontFamily: "PlusJakartaSansMedium",
                                  //   fontWeight: FontWeight.w800,
                                  // ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 4.w),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/calendar.svg",
                                height: 17.sp,
                                width: 17.sp,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 3.w),
                              Flexible(
                                child: Row(
                                  children: [
                                    CommonWidgets().commonText(
                                      text: "03/11/2025",
                                      fontSize: 17.sp,
                                      fontColor: AppColors().color1E1E1E,
                                      fontFamily: "PlusJakartaSansRegular",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CommonWidgets().commonText(
                                      text: " 12:00 PM",
                                      fontSize: 17.sp,
                                      fontColor: AppColors().color555151,
                                      fontFamily: "PlusJakartaSansRegular",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.w),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/roundedHome.svg",
                                height: 20.sp,
                                width: 20.sp,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 3.w),
                              Flexible(
                                child: Row(
                                  children: [
                                    CommonWidgets().commonText(
                                      text: "Balava",
                                      fontSize: 17.sp,
                                      fontColor: AppColors().color1E1E1E,
                                      fontFamily: "PlusJakartaSansRegular",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 20.w,
            width: 100.w,
            color: Colors.white.withValues(alpha: 0.6),
          ),
          Container(
            height: 20.w,
            width: 100.w,
            decoration: BoxDecoration(
              color: AppColors().colorFFFFFF,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.w),
                topRight: Radius.circular(4.w),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(1.5.w),
                  decoration: BoxDecoration(
                    color: AppColors().color5B6AEA,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/home.svg",
                        height: 18.sp,
                        width: 18.sp,
                        fit: BoxFit.fill,
                        color: AppColors().colorFFFFFF,
                      ),
                      SizedBox(width: 1.w),
                      CommonWidgets().commonText(
                        text: "Home",
                        fontSize: 16.sp,
                        fontColor: AppColors().colorFFFFFF,
                        fontFamily: "PlusJakartaSansRegular",
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(1.5.w),
                    decoration: BoxDecoration(
                      color: AppColors().color5B6AEA,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/location.svg",
                          height: 18.sp,
                          width: 18.sp,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(width: 1.w),
                        CommonWidgets().commonText(
                          text: "Location",
                          fontSize: 16.sp,
                          fontColor: AppColors().color1E1E1E,
                          fontFamily: "PlusJakartaSansRegular",
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(1.5.w),
                  decoration: BoxDecoration(
                    color: AppColors().color5B6AEA,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/group.svg",
                        height: 18.sp,
                        width: 18.sp,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 1.w),
                      CommonWidgets().commonText(
                        text: "Team",
                        fontSize: 16.sp,
                        fontColor: AppColors().color1E1E1E,
                        fontFamily: "PlusJakartaSansRegular",
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(1.5.w),
                  decoration: BoxDecoration(
                    color: AppColors().color5B6AEA,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/profile.svg",
                        height: 18.sp,
                        width: 18.sp,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 1.w),
                      CommonWidgets().commonText(
                        text: "Profile",
                        fontSize: 16.sp,
                        fontColor: AppColors().color1E1E1E,
                        fontFamily: "PlusJakartaSansRegular",
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
