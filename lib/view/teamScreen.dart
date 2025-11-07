import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
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
                              text: "Team List",
                              fontSize: 18.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansMedium",
                              fontWeight: FontWeight.bold,
                            ),
                            Container(
                              height: 1,
                              width: 20.w,
                              color: AppColors().color5B6AEA,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/search.png",
                          height: 25.sp,
                          width: 25.sp,
                        ),
                        Image.asset(
                          "assets/icons/addTeam.png",
                          height: 25.sp,
                          width: 25.sp,
                        ),
                      ],
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
                      text: "Team list",
                      fontSize: 18.sp,
                      fontColor: AppColors().color1E1E1E,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: GridView.builder(
                  itemCount: 5,
                  padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.w,
                    childAspectRatio: 0.72,
                    mainAxisSpacing: 3.w,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors().colorCC2D6E,
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            AppColors().colorFFFFFF,
                            AppColors().colorCCCCCC,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        color: AppColors().colorCCCCCC,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      margin: EdgeInsets.only(
                        left: 2.w,
                        right: 2.w,
                        bottom: 2.w,
                      ),
                      padding: EdgeInsets.only(left: 2.w, right: 2.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              height: 20.w,
                              width: 20.w,
                              "assets/images/Frame 5.png",
                            ),
                          ),
                          CommonWidgets().commonText(
                            text: "Cody Fisher\nAdroda",
                            fontSize: 16.sp,
                            textAlign: TextAlign.center,
                            fontColor: AppColors().color1E1E1E,
                            fontFamily: "PlusJakartaSansMedium",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 2.w),
                          Container(
                            width: 100.w,
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color: AppColors().color5B6AEA,
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: Center(
                              child: CommonWidgets().commonText(
                                text: "Assigned",
                                fontSize: 16.sp,
                                fontColor: AppColors().colorFFFFFF,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
    );
  }
}
