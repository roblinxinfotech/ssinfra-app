import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/controller/formScreenController.dart';
import 'package:ssinfra/controller/homeScreenController.dart';
import 'package:ssinfra/controller/profileScreenController.dart';
import 'package:ssinfra/controller/talukaScreenController.dart';
import 'package:ssinfra/controller/teamScreenController.dart';
import 'package:ssinfra/controller/villageScreenConroller.dart';
import 'package:ssinfra/view/formScreen.dart';
import 'package:ssinfra/view/profileScreen.dart';
import 'package:ssinfra/view/talukaScreen.dart';
import 'package:ssinfra/view/villageScreen.dart';

import '../controller/assignVillageScreenController.dart';
import '../controller/dashBoardScreenController.dart';
import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DashBoardScreenController dashBoardScreenController = Get.put(
    DashBoardScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
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
            child: Obx(() {
              // Get.delete<HomeScreenController>();
              Get.delete<DynamicFormController>();
              Get.delete<TalukaScreenController>();
              Get.delete<VillageScreenController>();
              Get.delete<HomeScreenController>();
              Get.delete<TeamScreenController>();
              Get.delete<ProfileScreenController>();
              Get.delete<AssignVillageScreenController>();

              return dashBoardScreenController.pages[dashBoardScreenController
                  .selectedNavIndex
                  .value]();
            }),
          ),
        ),
        bottomNavigationBar: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    width: 100.w,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
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
                        GestureDetector(
                          onTap: () {
                            dashBoardScreenController.selectedNavIndex.value =
                                0;
                          },
                          child: Container(
                            padding: EdgeInsets.all(1.5.w),
                            decoration: BoxDecoration(
                              color:
                                  dashBoardScreenController
                                          .selectedNavIndex
                                          .value ==
                                      0
                                  ? AppColors().color5B6AEA
                                  : AppColors().colorFFFFFF,
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/home.svg",
                                  height: 18.sp,
                                  width: 18.sp,
                                  fit: BoxFit.fill,
                                  color:
                                      dashBoardScreenController
                                              .selectedNavIndex
                                              .value ==
                                          0
                                      ? AppColors().colorFFFFFF
                                      : AppColors().color1E1E1E,
                                ),
                                SizedBox(width: 1.w),
                                CommonWidgets().commonText(
                                  text: "Home",
                                  fontSize: 16.sp,
                                  fontColor:
                                      dashBoardScreenController
                                              .selectedNavIndex
                                              .value ==
                                          0
                                      ? AppColors().colorFFFFFF
                                      : AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (dashBoardScreenController.permissions.value
                                .contains("assigned_sub_district:list")) {
                              dashBoardScreenController.selectedNavIndex.value =
                                  1;
                            } else if (dashBoardScreenController
                                .permissions
                                .value
                                .contains("assigned_village:list")) {
                              dashBoardScreenController.selectedNavIndex.value =
                                  2;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(1.5.w),
                            decoration: BoxDecoration(
                              color:
                                  dashBoardScreenController
                                              .selectedNavIndex
                                              .value ==
                                          1 ||
                                      dashBoardScreenController
                                              .selectedNavIndex
                                              .value ==
                                          2
                                  ? AppColors().color5B6AEA
                                  : AppColors().colorFFFFFF,
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/location.svg",
                                  height: 18.sp,
                                  width: 18.sp,
                                  fit: BoxFit.fill,
                                  color:
                                      dashBoardScreenController
                                                  .selectedNavIndex
                                                  .value ==
                                              1 ||
                                          dashBoardScreenController
                                                  .selectedNavIndex
                                                  .value ==
                                              2
                                      ? AppColors().colorFFFFFF
                                      : AppColors().color1E1E1E,
                                ),
                                SizedBox(width: 1.w),
                                CommonWidgets().commonText(
                                  text: "Location",
                                  fontSize: 16.sp,
                                  fontColor:
                                      dashBoardScreenController
                                                  .selectedNavIndex
                                                  .value ==
                                              1 ||
                                          dashBoardScreenController
                                                  .selectedNavIndex
                                                  .value ==
                                              2
                                      ? AppColors().colorFFFFFF
                                      : AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        ),

                        if (dashBoardScreenController.permissions.value.contains("team:list")) GestureDetector(
                                onTap: () {
                                  dashBoardScreenController
                                          .selectedNavIndex
                                          .value =
                                      3;
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1.5.w),
                                  decoration: BoxDecoration(
                                    color:
                                        dashBoardScreenController
                                                .selectedNavIndex
                                                .value ==
                                            3
                                        ? AppColors().color5B6AEA
                                        : AppColors().colorFFFFFF,
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/group.svg",
                                        height: 18.sp,
                                        width: 18.sp,
                                        fit: BoxFit.fill,
                                        color:
                                            dashBoardScreenController
                                                    .selectedNavIndex
                                                    .value ==
                                                3
                                            ? AppColors().colorFFFFFF
                                            : AppColors().color1E1E1E,
                                      ),
                                      SizedBox(width: 1.w),
                                      CommonWidgets().commonText(
                                        text: "Team",
                                        fontSize: 16.sp,
                                        fontColor:
                                            dashBoardScreenController
                                                    .selectedNavIndex
                                                    .value ==
                                                3
                                            ? AppColors().colorFFFFFF
                                            : AppColors().color1E1E1E,
                                        fontFamily: "PlusJakartaSansRegular",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                           ,
                        GestureDetector(
                          onTap: () {
                            dashBoardScreenController.selectedNavIndex.value =
                                4;
                          },
                          child: Container(
                            padding: EdgeInsets.all(1.5.w),
                            decoration: BoxDecoration(
                              color:
                                  dashBoardScreenController
                                          .selectedNavIndex
                                          .value ==
                                      4
                                  ? AppColors().color5B6AEA
                                  : AppColors().colorFFFFFF,
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/profile.svg",
                                  height: 18.sp,
                                  width: 18.sp,
                                  color:
                                      dashBoardScreenController
                                              .selectedNavIndex
                                              .value ==
                                          4
                                      ? AppColors().colorFFFFFF
                                      : AppColors().color1E1E1E,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(width: 1.w),
                                CommonWidgets().commonText(
                                  text: "Profile",
                                  fontSize: 16.sp,
                                  fontColor:
                                      dashBoardScreenController
                                              .selectedNavIndex
                                              .value ==
                                          4
                                      ? AppColors().colorFFFFFF
                                      : AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
