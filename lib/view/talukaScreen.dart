import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';

class TalukaScreen extends StatefulWidget {
  const TalukaScreen({super.key});

  @override
  State<TalukaScreen> createState() => _TalukaScreenState();
}

class _TalukaScreenState extends State<TalukaScreen> {
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
                        CommonWidgets().commonText(
                          text: "AHMEDABAD - 01",
                          fontSize: 18.sp,
                          fontColor: AppColors().color1E1E1E,
                          fontFamily: "PlusJakartaSansMedium",
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/icons/search.png",
                      height: 25.sp,
                      width: 25.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.w),
              Container(
                margin: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 5.w),
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors().colorFFDDDD,
                    width: 1.5,
                  ),
                  color: AppColors().colorEEEEEE,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                width: 100.w,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/home.svg",
                      height: 18.sp,
                      width: 18.sp,
                      fit: BoxFit.fill,
                      color: AppColors().color787878,
                    ),
                    SizedBox(width: 2.w),

                    SvgPicture.asset(
                      "assets/icons/forward.svg",
                      height: 15.sp,
                      width: 15.sp,
                      fit: BoxFit.fill,
                      color: AppColors().color787878,
                    ),
                    SizedBox(width: 2.w),

                    CommonWidgets().commonText(
                      text: "District",
                      fontSize: 18.sp,
                      fontColor: AppColors().color787878,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(width: 2.w),
                    SvgPicture.asset(
                      "assets/icons/forward.svg",
                      height: 15.sp,
                      width: 15.sp,
                      fit: BoxFit.fill,
                      color: AppColors().color787878,
                    ),
                    SizedBox(width: 2.w),
                    CommonWidgets().commonText(
                      text: "Taluka list",
                      fontSize: 18.sp,
                      fontColor: AppColors().color1E1E1E,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5.w),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 4.w, left: 3.w, right: 3.w),
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 2.w),
                      padding: EdgeInsets.all(2.w),

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
                            children: [
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 1.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white30,
                                    borderRadius: BorderRadius.circular(15.sp),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/blueRound.svg",
                                        height: 12.sp,
                                        width: 12.sp,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(width: 3.w),
                                      Flexible(
                                        child: CommonWidgets().commonText(
                                          text: "Bavla - 009 ",
                                          fontSize: 16.sp,
                                          fontColor: AppColors().color1E1E1E,
                                          fontFamily: "PlusJakartaSansRegular",
                                          fontWeight: FontWeight.bold,
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
                                  Container(
                                    height: 20.sp,
                                    width: 20.sp,
                                    margin: EdgeInsets.only(top: 2.w),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 2,
                                          blurRadius: 20,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        "assets/images/lbImage.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  CommonWidgets().commonText(
                                    text: "Not Assign",
                                    fontSize: 15.sp,
                                    fontColor: AppColors().colorFF0000,
                                    fontFamily: "PlusJakartaSansMedium",
                                    fontWeight: FontWeight.w800,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 2.w,
                                    right: 2.w,
                                    top: 1.w,
                                    bottom: 1.w,
                                  ),

                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/roundedHome.svg",
                                        height: 25.sp,
                                        width: 25.sp,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(width: 3.w),
                                      Flexible(
                                        child: Row(
                                          children: [
                                            CommonWidgets().commonText(
                                              text: "Villages - ",
                                              fontSize: 17.sp,
                                              fontColor:
                                                  AppColors().color1E1E1E,
                                              fontFamily:
                                                  "PlusJakartaSansRegular",
                                              fontWeight: FontWeight.bold,
                                            ),
                                            Flexible(
                                              child: CommonWidgets().commonText(
                                                text: "40",
                                                fontSize: 18.sp,
                                                fontColor:
                                                    AppColors().color1E1E1E,
                                                fontFamily:
                                                    "PlusJakartaSansMedium",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 2.w,
                                    right: 2.w,
                                    top: 1.w,
                                    bottom: 1.w,
                                  ),

                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/blueTeam.svg",
                                        height: 25.sp,
                                        width: 25.sp,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(width: 3.w),
                                      Flexible(
                                        child: Row(
                                          children: [
                                            CommonWidgets().commonText(
                                              text: "Team - ",
                                              fontSize: 17.sp,
                                              fontColor:
                                                  AppColors().color1E1E1E,
                                              fontFamily:
                                                  "PlusJakartaSansRegular",
                                              fontWeight: FontWeight.bold,
                                            ),
                                            Flexible(
                                              child: CommonWidgets().commonText(
                                                text: "47",
                                                fontSize: 18.sp,
                                                fontColor:
                                                    AppColors().color1E1E1E,
                                                fontFamily:
                                                    "PlusJakartaSansMedium",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SvgPicture.asset(
                          //   height: 15.w,
                          //   width: 15.w,
                          //   fit: BoxFit.fill,
                          //   "assets/icons/waterPaper.svg",
                          // ),
                          //
                          // RichText(
                          //   text: TextSpan(
                          //     style: TextStyle(
                          //       fontSize: 16.sp,
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //     children: [
                          //       const TextSpan(
                          //         text: 'ભૂગર્ભ જળ યોજના ફોર્મ (GWS)',
                          //       ),
                          //       WidgetSpan(
                          //         alignment: PlaceholderAlignment.middle,
                          //         child: Padding(
                          //           padding: EdgeInsets.only(left: 2.w),
                          //           child: SvgPicture.asset(
                          //             "assets/icons/forward.svg",
                          //             height: 15.sp,
                          //             width: 15.sp,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
                  onTap: () {
                    Get.to(TalukaScreen());
                  },
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
