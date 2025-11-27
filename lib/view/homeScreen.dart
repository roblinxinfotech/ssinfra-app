import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/controller/homeScreenController.dart';
import 'package:ssinfra/utils/appColors.dart';
import 'package:ssinfra/utils/commonWidgets.dart';
import 'package:ssinfra/view/formScreen.dart';
import 'package:ssinfra/view/talukaScreen.dart';

import 'notificationScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

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
            padding: EdgeInsets.all(0.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CommonWidgets().commonText(
                            text: "Welcome".tr,
                            fontSize: 18.sp,
                            fontColor: AppColors().color1E1E1E,
                            fontFamily: "PlusJakartaSansRegular",
                            fontWeight: FontWeight.w600,
                          ),
                          CommonWidgets().commonText(
                            text: "SNS".tr,
                            fontSize: 18.sp,
                            fontColor: AppColors().color1E1E1E,
                            fontFamily: "PlusJakartaSansMedium",
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(NotificationScreen());
                            },
                            child: Image.asset(
                              "assets/icons/notification.png",
                              height: 25.sp,
                              width: 25.sp,
                            ),
                          ),

                          // Image.asset(
                          //   "assets/icons/switch.png",
                          //   height: 25.sp,
                          //   width: 25.sp,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.w),

                Obx(() {
                  return homeScreenController.loader.value == true
                      ? Flexible(
                          child: Center(
                            child: Image.asset(
                              height: 25.w,
                              width: 25.w,
                              "assets/images/splashLoader.gif",
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : homeScreenController.errorShow == true
                      ? Flexible(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  height: 30.w,
                                  width: 30.w,
                                  "assets/icons/somethingWentWrong.png",
                                  fit: BoxFit.fill,
                                ),
                                CommonWidgets().commonText(
                                  text: "SomethingWentWrong".tr,
                                  fontSize: 20.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansMedium",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        )
                      : homeScreenController
                                .formsListModel
                                .value
                                .data
                                ?.forms
                                ?.length ==
                            0
                      ? Flexible(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  height: 30.w,
                                  width: 30.w,
                                  "assets/icons/noDataFound.png",
                                  fit: BoxFit.fill,
                                ),
                                CommonWidgets().commonText(
                                  text: "NoDataFound".tr,
                                  fontSize: 20.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansMedium",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 1.w, right: 1.w),
                                child: CommonWidgets().commonText(
                                  text:
                                      "${homeScreenController.formsListModel.value.data?.yojnaName.toString()}",
                                  fontSize: 18.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "PlusJakartaSansRegular",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 5.w),
                              Expanded(
                                child: GridView.builder(
                                  padding: EdgeInsets.all(4.w),
                                  itemCount: homeScreenController
                                      .formsListModel
                                      .value
                                      .data
                                      ?.forms
                                      ?.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 2.w,
                                        crossAxisSpacing: 2.w,
                                      ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          FormScreen(),
                                          arguments: {
                                            "formId": homeScreenController
                                                .formsListModel
                                                .value
                                                .data
                                                ?.forms?[index]
                                                .id
                                                .toString(),
                                          },
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(2.w),
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.1,
                                              ),
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                            ),
                                          ],
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                              index % 4 == 0
                                                  ? "assets/images/ltImage.png"
                                                  : index % 4 == 1
                                                  ? "assets/images/rtImage.png"
                                                  : index % 4 == 2
                                                  ? "assets/images/lbImage.png"
                                                  : "assets/images/rbImage.png",
                                            ),
                                          ),
                                          color: AppColors().colorD9D9D9,
                                          borderRadius: BorderRadius.circular(
                                            15.sp,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              height: 15.w,
                                              width: 15.w,
                                              fit: BoxFit.fill,
                                              "assets/icons/waterPaper.svg",
                                            ),

                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '${homeScreenController.formsListModel.value.data?.forms?[index].title.toString().capitalizeFirst}',
                                                  ),
                                                  WidgetSpan(
                                                    alignment:
                                                        PlaceholderAlignment
                                                            .middle,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 2.w,
                                                      ),
                                                      child: SvgPicture.asset(
                                                        "assets/icons/forward.svg",
                                                        height: 15.sp,
                                                        width: 15.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Stack(
      //   children: [
      //     Container(
      //       height: 20.w,
      //       width: 100.w,
      //       color: Colors.white.withValues(alpha: 0.6),
      //     ),
      //     Container(
      //       height: 20.w,
      //       width: 100.w,
      //       decoration: BoxDecoration(
      //         color: AppColors().colorFFFFFF,
      //         borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(4.w),
      //           topRight: Radius.circular(4.w),
      //         ),
      //       ),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           Container(
      //             padding: EdgeInsets.all(1.5.w),
      //             decoration: BoxDecoration(
      //               color: AppColors().color5B6AEA,
      //               borderRadius: BorderRadius.circular(10.sp),
      //             ),
      //             child: Row(
      //               children: [
      //                 SvgPicture.asset(
      //                   "assets/icons/home.svg",
      //                   height: 18.sp,
      //                   width: 18.sp,
      //                   fit: BoxFit.fill,
      //                   color: AppColors().colorFFFFFF,
      //                 ),
      //                 SizedBox(width: 1.w),
      //                 CommonWidgets().commonText(
      //                   text: "Home",
      //                   fontSize: 16.sp,
      //                   fontColor: AppColors().colorFFFFFF,
      //                   fontFamily: "PlusJakartaSansRegular",
      //                   fontWeight: FontWeight.w600,
      //                 ),
      //               ],
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: () {
      //               Get.to(TalukaScreen());
      //             },
      //             child: Container(
      //               padding: EdgeInsets.all(1.5.w),
      //               decoration: BoxDecoration(
      //                 color: AppColors().color5B6AEA,
      //                 borderRadius: BorderRadius.circular(10.sp),
      //               ),
      //               child: Row(
      //                 children: [
      //                   SvgPicture.asset(
      //                     "assets/icons/location.svg",
      //                     height: 18.sp,
      //                     width: 18.sp,
      //                     fit: BoxFit.fill,
      //                   ),
      //                   SizedBox(width: 1.w),
      //                   CommonWidgets().commonText(
      //                     text: "Location",
      //                     fontSize: 16.sp,
      //                     fontColor: AppColors().color1E1E1E,
      //                     fontFamily: "PlusJakartaSansRegular",
      //                     fontWeight: FontWeight.w600,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           Container(
      //             padding: EdgeInsets.all(1.5.w),
      //             decoration: BoxDecoration(
      //               color: AppColors().color5B6AEA,
      //               borderRadius: BorderRadius.circular(10.sp),
      //             ),
      //             child: Row(
      //               children: [
      //                 SvgPicture.asset(
      //                   "assets/icons/group.svg",
      //                   height: 18.sp,
      //                   width: 18.sp,
      //                   fit: BoxFit.fill,
      //                 ),
      //                 SizedBox(width: 1.w),
      //                 CommonWidgets().commonText(
      //                   text: "Team",
      //                   fontSize: 16.sp,
      //                   fontColor: AppColors().color1E1E1E,
      //                   fontFamily: "PlusJakartaSansRegular",
      //                   fontWeight: FontWeight.w600,
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Container(
      //             padding: EdgeInsets.all(1.5.w),
      //             decoration: BoxDecoration(
      //               color: AppColors().color5B6AEA,
      //               borderRadius: BorderRadius.circular(10.sp),
      //             ),
      //             child: Row(
      //               children: [
      //                 SvgPicture.asset(
      //                   "assets/icons/profile.svg",
      //                   height: 18.sp,
      //                   width: 18.sp,
      //                   fit: BoxFit.fill,
      //                 ),
      //                 SizedBox(width: 1.w),
      //                 CommonWidgets().commonText(
      //                   text: "Profile",
      //                   fontSize: 16.sp,
      //                   fontColor: AppColors().color1E1E1E,
      //                   fontFamily: "PlusJakartaSansRegular",
      //                   fontWeight: FontWeight.w600,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
