import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/view/villageScreen.dart';
import 'package:ssinfra/view/villageToTalukaScreen.dart';
import 'package:ssinfra/view/wardToTownScreen.dart';

import '../controller/talukaScreenController.dart';
import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';

class TalukaScreen extends StatefulWidget {
  const TalukaScreen({super.key});

  @override
  State<TalukaScreen> createState() => _TalukaScreenState();
}

class _TalukaScreenState extends State<TalukaScreen> {
  TalukaScreenController talukaScreenController = Get.put(
    TalukaScreenController(),
  );

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
                    Container(height: 25.sp, width: 25.sp),
                    Row(
                      children: [
                        CommonWidgets().commonText(
                          text: "TalukaTown".tr,
                          fontSize: 18.sp,
                          fontColor: AppColors().color1E1E1E,
                          fontFamily: "PlusJakartaSansMedium",
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          talukaScreenController.hideShowSearch();
                        },
                        child: talukaScreenController.showSearch == false
                            ? Image.asset(
                                "assets/icons/search.png",
                                height: 25.sp,
                                width: 25.sp,
                              )
                            : Image.asset(
                                "assets/icons/close.png",
                                height: 25.sp,
                                width: 25.sp,
                              ),
                      );
                    }),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 4.w,
                  right: 4.w,
                  bottom: 1.w,
                  top: 2.w,
                ),
                child: Obx(() {
                  return talukaScreenController.showSearch.value == true
                      ? Container(
                          height: 40,
                          child: TextFormField(
                            onChanged: (a) async {
                              talukaScreenController.searchText = a.toString();
                              await talukaScreenController.searchItem();
                            },
                            controller:
                                talukaScreenController.searchController.value,
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
                              hintText:
                                  talukaScreenController.groupValue.value == 0
                                  ? "SearchTaluka".tr
                                  : talukaScreenController.groupValue.value == 1
                                  ? "SearchTown".tr
                                  : "",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : SizedBox();
                }),
              ),

              Obx(() {
                return Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 2.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            talukaScreenController.groupValue.value = 0;

                            // await teamScreenController.sortData();
                            await talukaScreenController.searchItem();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                                  talukaScreenController.groupValue.value == 0
                                  ? AppColors().color5B6AEA.withValues(
                                      alpha: 0.3,
                                    )
                                  : Colors.transparent,
                              border: Border.all(
                                color:
                                    talukaScreenController.groupValue.value == 0
                                    ? AppColors().color5B6AEA
                                    : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            child: Text(
                              "Taluka".tr,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    talukaScreenController.groupValue.value == 0
                                    ? AppColors().color5B6AEA
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 2.w),

                      // ---- TAB 2 : APPROVAL ----
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            talukaScreenController.groupValue.value = 1;
                            await talukaScreenController.searchItem();
                            // await teamScreenController.sortData();
                            // await teamScreenController.searchItem();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                                  talukaScreenController.groupValue.value == 1
                                  ? AppColors().color5B6AEA.withValues(
                                      alpha: 0.3,
                                    )
                                  : Colors.transparent,
                              border: Border.all(
                                color:
                                    talukaScreenController.groupValue.value == 1
                                    ? AppColors().color5B6AEA
                                    : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            child: Text(
                              "Town".tr,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    talukaScreenController.groupValue.value == 1
                                    ? AppColors().color5B6AEA
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                    ],
                  ),
                );
              }),

              // Container(
              //   margin: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 5.w),
              //   padding: EdgeInsets.all(1.w),
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: AppColors().colorFFDDDD,
              //       width: 1.5,
              //     ),
              //     color: AppColors().colorEEEEEE,
              //     borderRadius: BorderRadius.circular(2.w),
              //   ),
              //   width: 100.w,
              //   child: Row(
              //     children: [
              //       SvgPicture.asset(
              //         "assets/icons/home.svg",
              //         height: 18.sp,
              //         width: 18.sp,
              //         fit: BoxFit.fill,
              //         color: AppColors().color787878,
              //       ),
              //       SizedBox(width: 2.w),
              //
              //       SvgPicture.asset(
              //         "assets/icons/forward.svg",
              //         height: 15.sp,
              //         width: 15.sp,
              //         fit: BoxFit.fill,
              //         color: AppColors().color787878,
              //       ),
              //       SizedBox(width: 2.w),
              //
              //       CommonWidgets().commonText(
              //         text: "District",
              //         fontSize: 18.sp,
              //         fontColor: AppColors().color787878,
              //         fontFamily: "PlusJakartaSansRegular",
              //         fontWeight: FontWeight.w600,
              //       ),
              //       SizedBox(width: 2.w),
              //       SvgPicture.asset(
              //         "assets/icons/forward.svg",
              //         height: 15.sp,
              //         width: 15.sp,
              //         fit: BoxFit.fill,
              //         color: AppColors().color787878,
              //       ),
              //       SizedBox(width: 2.w),
              //       CommonWidgets().commonText(
              //         text: "Taluka list",
              //         fontSize: 18.sp,
              //         fontColor: AppColors().color1E1E1E,
              //         fontFamily: "PlusJakartaSansRegular",
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await talukaScreenController.getTalukaList();
                    await talukaScreenController.searchItem();
                  },
                  child: Column(
                    children: [
                      Obx(() {
                        return talukaScreenController.loader.value == true
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
                            : talukaScreenController.errorShow == true
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
                            : (talukaScreenController
                                              .talukaListModel
                                              .value
                                              .data
                                              ?.length ==
                                          0 &&
                                      talukaScreenController.groupValue == 0) ||
                                  (talukaScreenController
                                              .assignedTownModel
                                              .value
                                              .data
                                              ?.length ==
                                          0 &&
                                      talukaScreenController.groupValue == 1)
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
                            : (talukaScreenController
                                              .talukaList
                                              .value
                                              ?.length ==
                                          0 &&
                                      talukaScreenController.groupValue == 0) ||
                                  (talukaScreenController
                                              .assignedTownList
                                              .value
                                              ?.length ==
                                          0 &&
                                      talukaScreenController.groupValue == 1)
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
                                        text: "NoMatchingFound".tr,
                                        fontSize: 20.sp,
                                        fontColor: AppColors().color1E1E1E,
                                        fontFamily: "PlusJakartaSansMedium",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : talukaScreenController.groupValue == 0
                            ? Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(
                                    top: 4.w,
                                    left: 3.w,
                                    right: 3.w,
                                  ),
                                  itemCount: talukaScreenController
                                      .talukaList
                                      .value
                                      ?.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          VillageToTalukaScreen(),
                                          arguments: {
                                            "talukaId":
                                                "${talukaScreenController.talukaList.value[index].subDistrictId.toString()}",
                                            "assigned":
                                                talukaScreenController
                                                        .talukaList
                                                        .value[index]
                                                        .assignedBy
                                                        .toString() ==
                                                    "null"
                                                ? false
                                                : true,
                                          },
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 2.w),
                                        padding: EdgeInsets.all(2.w),

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
                                              "assets/images/talukaListBg.png",
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 2.w,
                                                          vertical: 1.w,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white30,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            15.sp,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                            text:
                                                                "${talukaScreenController.talukaList.value[index].name.toString()}",
                                                            fontSize: 16.sp,
                                                            fontColor:
                                                                AppColors()
                                                                    .color1E1E1E,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            maxline: 2,
                                                            softWrap: true,
                                                            overFlow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 3.w),
                                                // Column(
                                                //   children: [
                                                //     CommonWidgets().commonText(
                                                //       text: "Assigned",
                                                //       fontSize: 15.sp,
                                                //       fontColor: AppColors()
                                                //           .color666666,
                                                //       fontFamily:
                                                //           "PlusJakartaSansRegular",
                                                //       fontWeight:
                                                //           FontWeight.bold,
                                                //     ),
                                                //     Container(
                                                //       height: 20.sp,
                                                //       width: 20.sp,
                                                //       margin: EdgeInsets.only(
                                                //         top: 2.w,
                                                //       ),
                                                //       decoration: BoxDecoration(
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color:
                                                //                 Colors.black12,
                                                //             spreadRadius: 2,
                                                //             blurRadius: 20,
                                                //             offset: Offset(
                                                //               0,
                                                //               2,
                                                //             ),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //       child: ClipRRect(
                                                //         borderRadius:
                                                //             BorderRadius.circular(
                                                //               50,
                                                //             ),
                                                //         child: Image.asset(
                                                //           "assets/images/lbImage.png",
                                                //           fit: BoxFit.fill,
                                                //         ),
                                                //       ),
                                                //     ),
                                                //     CommonWidgets().commonText(
                                                //       text: "Not Assign",
                                                //       fontSize: 15.sp,
                                                //       fontColor: AppColors()
                                                //           .colorFF0000,
                                                //       fontFamily:
                                                //           "PlusJakartaSansMedium",
                                                //       fontWeight:
                                                //           FontWeight.w800,
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),

                                            SizedBox(height: 4.w),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                                text:
                                                                    "Villages:".tr,
                                                                fontSize: 17.sp,
                                                                fontColor:
                                                                    AppColors()
                                                                        .color1E1E1E,
                                                                fontFamily:
                                                                    "PlusJakartaSansRegular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              Flexible(
                                                                child: CommonWidgets().commonText(
                                                                  text:
                                                                      "${talukaScreenController.talukaList.value[index].villagesCount.toString()}",
                                                                  fontSize:
                                                                      17.sp,
                                                                  fontColor:
                                                                      AppColors()
                                                                          .color1E1E1E,
                                                                  fontFamily:
                                                                      "PlusJakartaSansMedium",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                                                text: "Team:".tr,
                                                                fontSize: 17.sp,
                                                                fontColor:
                                                                    AppColors()
                                                                        .color1E1E1E,
                                                                fontFamily:
                                                                    "PlusJakartaSansRegular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              Flexible(
                                                                child: CommonWidgets().commonText(
                                                                  text:
                                                                      "${talukaScreenController.talukaList.value[index].teamsCount.toString()}",
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontColor:
                                                                      AppColors()
                                                                          .color1E1E1E,
                                                                  fontFamily:
                                                                      "PlusJakartaSansMedium",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(
                                    top: 4.w,
                                    left: 3.w,
                                    right: 3.w,
                                  ),
                                  itemCount: talukaScreenController
                                      .assignedTownList
                                      .value
                                      ?.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          WardToTownScreen(),
                                          arguments: {
                                            "talukaId":
                                                "${talukaScreenController.assignedTownList.value[index].townId.toString()}",
                                            "assigned":
                                                talukaScreenController
                                                        .assignedTownList
                                                        .value[index]
                                                        .assignedBy
                                                        .toString() ==
                                                    "null"
                                                ? false
                                                : true,
                                          },
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 2.w),
                                        padding: EdgeInsets.all(2.w),

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
                                              "assets/images/talukaListBg.png",
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 2.w,
                                                          vertical: 1.w,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white30,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            15.sp,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                            text:
                                                                "${talukaScreenController.assignedTownList.value[index].name.toString()}",
                                                            fontSize: 16.sp,
                                                            fontColor:
                                                                AppColors()
                                                                    .color1E1E1E,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            maxline: 2,
                                                            softWrap: true,
                                                            overFlow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 3.w),
                                                // Column(
                                                //   children: [
                                                //     CommonWidgets().commonText(
                                                //       text: "Assigned",
                                                //       fontSize: 15.sp,
                                                //       fontColor: AppColors()
                                                //           .color666666,
                                                //       fontFamily:
                                                //           "PlusJakartaSansRegular",
                                                //       fontWeight:
                                                //           FontWeight.bold,
                                                //     ),
                                                //     Container(
                                                //       height: 20.sp,
                                                //       width: 20.sp,
                                                //       margin: EdgeInsets.only(
                                                //         top: 2.w,
                                                //       ),
                                                //       decoration: BoxDecoration(
                                                //         boxShadow: [
                                                //           BoxShadow(
                                                //             color:
                                                //                 Colors.black12,
                                                //             spreadRadius: 2,
                                                //             blurRadius: 20,
                                                //             offset: Offset(
                                                //               0,
                                                //               2,
                                                //             ),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //       child: ClipRRect(
                                                //         borderRadius:
                                                //             BorderRadius.circular(
                                                //               50,
                                                //             ),
                                                //         child: Image.asset(
                                                //           "assets/images/lbImage.png",
                                                //           fit: BoxFit.fill,
                                                //         ),
                                                //       ),
                                                //     ),
                                                //     CommonWidgets().commonText(
                                                //       text: "Not Assign",
                                                //       fontSize: 15.sp,
                                                //       fontColor: AppColors()
                                                //           .colorFF0000,
                                                //       fontFamily:
                                                //           "PlusJakartaSansMedium",
                                                //       fontWeight:
                                                //           FontWeight.w800,
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),

                                            SizedBox(height: 4.w),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                                text:
                                                                    "Wards-".tr,
                                                                fontSize: 17.sp,
                                                                fontColor:
                                                                    AppColors()
                                                                        .color1E1E1E,
                                                                fontFamily:
                                                                    "PlusJakartaSansRegular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              Flexible(
                                                                child: CommonWidgets().commonText(
                                                                  text:
                                                                      "${talukaScreenController.assignedTownList.value[index].wardsCount.toString()}",
                                                                  fontSize:
                                                                      18.sp,
                                                                  fontColor:
                                                                      AppColors()
                                                                          .color1E1E1E,
                                                                  fontFamily:
                                                                      "PlusJakartaSansMedium",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                                                text: "Team-".tr,
                                                                fontSize: 17.sp,
                                                                fontColor:
                                                                    AppColors()
                                                                        .color1E1E1E,
                                                                fontFamily:
                                                                    "PlusJakartaSansRegular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              Flexible(
                                                                child: CommonWidgets().commonText(
                                                                  text:
                                                                      "${talukaScreenController.assignedTownList.value[index].teamsCount.toString()}",
                                                                  fontSize:
                                                                      18.sp,
                                                                  fontColor:
                                                                      AppColors()
                                                                          .color1E1E1E,
                                                                  fontFamily:
                                                                      "PlusJakartaSansMedium",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                      ),
                                    );
                                  },
                                ),
                              );
                      }),
                    ],
                  ),
                ),
              ),
            ],
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
