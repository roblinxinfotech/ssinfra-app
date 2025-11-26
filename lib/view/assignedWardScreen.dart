import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/controller/assignVillageScreenController.dart';

import '../controller/assignedWardController.dart';
import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';

class AssignWardScreen extends StatefulWidget {
  const AssignWardScreen({super.key});

  @override
  State<AssignWardScreen> createState() => _AssignWardScreenState();
}

class _AssignWardScreenState extends State<AssignWardScreen> {
  AssignWardScreenController assignWardScreenController = Get.put(
    AssignWardScreenController(),
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
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        "assets/icons/backWard.png",
                        height: 25.sp,
                        width: 25.sp,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Row(
                      children: [
                        CommonWidgets().commonText(
                          text: "AssignWard".tr,
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
                          assignWardScreenController.hideShowSearch();
                        },
                        child: assignWardScreenController.showSearch == false
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
                    // Image.asset(
                    //   "assets/icons/search.png",
                    //   height: 25.sp,
                    //   width: 25.sp,
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 2.w),
              Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 2.w),
                child: Obx(() {
                  return assignWardScreenController.showSearch.value == true
                      ? Container(
                          height: 40,
                          child: TextFormField(
                            onChanged: (a) async {
                              assignWardScreenController.searchText = a
                                  .toString();
                              // await teamScreenController.sortData();
                              await assignWardScreenController.searchItem();
                            },
                            controller: assignWardScreenController
                                .searchController
                                .value,
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
                              hintText: "SearchWard".tr,
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
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Row(
                    children: [
                      // ---- TAB 1 : PENDING ----
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            assignWardScreenController.groupValue.value = 0;
                            assignWardScreenController.searchItem();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                                  assignWardScreenController.groupValue.value ==
                                      0
                                  ? AppColors().color5B6AEA.withValues(
                                      alpha: 0.3,
                                    )
                                  : Colors.transparent,
                              border: Border.all(
                                color:
                                    assignWardScreenController
                                            .groupValue
                                            .value ==
                                        0
                                    ? AppColors().color5B6AEA
                                    : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            child: Text(
                              "Free".tr,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    assignWardScreenController
                                            .groupValue
                                            .value ==
                                        0
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
                            assignWardScreenController.groupValue.value = 1;
                            assignWardScreenController.searchItem();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                                  assignWardScreenController.groupValue.value ==
                                      1
                                  ? AppColors().color5B6AEA.withValues(
                                      alpha: 0.3,
                                    )
                                  : Colors.transparent,
                              border: Border.all(
                                color:
                                    assignWardScreenController
                                            .groupValue
                                            .value ==
                                        1
                                    ? AppColors().color5B6AEA
                                    : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            child: Text(
                              "Assigned".tr,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    assignWardScreenController
                                            .groupValue
                                            .value ==
                                        1
                                    ? AppColors().color5B6AEA
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await assignWardScreenController.getVillageList();
                    await assignWardScreenController.searchItem();
                  },
                  child: Column(
                    children: [
                      Obx(() {
                        return assignWardScreenController.loader.value == true
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
                            : assignWardScreenController.errorShow == true
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
                            : (assignWardScreenController
                                              .wardListModel
                                              .value
                                              .data
                                              ?.length ==
                                          0 &&
                                      assignWardScreenController.groupValue ==
                                          0) ||
                                  (assignWardScreenController
                                              .userAssignedWard
                                              .value
                                              .data
                                              ?.length ==
                                          0 &&
                                      assignWardScreenController.groupValue ==
                                          1)
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
                            : (assignWardScreenController.wardList?.length ==
                                          0 &&
                                      assignWardScreenController.groupValue ==
                                          0) ||
                                  (assignWardScreenController
                                              .assignedWardList
                                              ?.length ==
                                          0 &&
                                      assignWardScreenController.groupValue ==
                                          1)
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
                            : assignWardScreenController.groupValue.value == 0
                            ? Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(
                                    top: 2.w,
                                    left: 3.w,
                                    right: 3.w,
                                  ),
                                  itemCount: assignWardScreenController
                                      .wardList
                                      ?.length,
                                  itemBuilder: (context, index) {
                                    return Obx(() {
                                      return CheckboxListTile(
                                        contentPadding: EdgeInsets.zero,
                                        // 👈 removes default left-right padding
                                        visualDensity: VisualDensity(
                                          horizontal: -4,
                                          vertical: -4,
                                        ),
                                        // 👈 reduces spacing
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        side: BorderSide(
                                          color: AppColors().color5B6AEA,
                                          width: 1.5,
                                        ),
                                        activeColor: AppColors().color5B6AEA,
                                        title: Text(
                                          "${assignWardScreenController.wardList?[index].name.toString()}  ",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily:
                                                "PlusJakartaSansRegular",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        value: assignWardScreenController.wardId
                                            .contains(
                                              assignWardScreenController
                                                  .wardList[index]
                                                  .id,
                                            ),
                                        onChanged: (v) {
                                          assignWardScreenController
                                              .villageSelection(
                                                assignWardScreenController
                                                    .wardList[index]
                                                    .id,
                                              );
                                        },
                                      );
                                    });
                                  },
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(
                                    top: 2.w,
                                    left: 3.w,
                                    right: 3.w,
                                  ),
                                  itemCount: assignWardScreenController
                                      .assignedWardList
                                      ?.length,
                                  itemBuilder: (context, index) {
                                    return Obx(() {
                                      return CheckboxListTile(
                                        contentPadding: EdgeInsets.zero,
                                        // 👈 removes default left-right padding
                                        visualDensity: VisualDensity(
                                          horizontal: -4,
                                          vertical: -4,
                                        ),
                                        // 👈 reduces spacing
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        side: BorderSide(
                                          color: AppColors().color5B6AEA,
                                          width: 1.5,
                                        ),
                                        activeColor: AppColors().color5B6AEA,
                                        title: Text(
                                          "${assignWardScreenController.assignedWardList?[index].name.toString()}",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily:
                                                "PlusJakartaSansRegular",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        value: assignWardScreenController
                                            .assignedWard
                                            .contains(
                                              assignWardScreenController
                                                  .assignedWardList?[index]
                                                  .id,
                                            ),
                                        onChanged: (v) {
                                          Get.dialog(
                                            Dialog(
                                              backgroundColor:
                                                  AppColors().colorFFFFFF,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top: 8.w,
                                                  bottom: 4.w,
                                                  left: 2.w,
                                                  right: 2.w,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'AreYouSureYouWantToReleaseThisWard'
                                                          .tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "PlusJakartaSansRegular",
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.w),
                                                    Text(
                                                      'NoteIfYouReleaseWardRecordTransferredToPerson'
                                                          .tr,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: AppColors()
                                                            .colorFF0000,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "PlusJakartaSansRegular",
                                                      ),
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  vertical: 2.w,
                                                                  horizontal:
                                                                      6.w,
                                                                ),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                              color: AppColors()
                                                                  .color5B6AEA
                                                                  .withValues(
                                                                    alpha: 0.3,
                                                                  ),
                                                              border: Border.all(
                                                                color: AppColors()
                                                                    .color5B6AEA,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    1.w,
                                                                  ),
                                                            ),
                                                            child: Text(
                                                              "No".tr,
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColors()
                                                                    .color5B6AEA,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 2.w),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                            await assignWardScreenController
                                                                .removeVillage(
                                                                  assignWardScreenController
                                                                      .assignedWardList[index]
                                                                      .id,
                                                                  context,
                                                                );
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  vertical: 2.w,
                                                                  horizontal:
                                                                      6.w,
                                                                ),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                              color: AppColors()
                                                                  .color5B6AEA
                                                                  .withValues(
                                                                    alpha: 0.3,
                                                                  ),
                                                              border: Border.all(
                                                                color: AppColors()
                                                                    .color5B6AEA,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    1.w,
                                                                  ),
                                                            ),

                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "Yes".tr,
                                                                  style: TextStyle(
                                                                    color: AppColors()
                                                                        .color5B6AEA,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        "AppFontData.regular",
                                                                    fontSize:
                                                                        16.sp,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    });
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
      bottomNavigationBar: Obx(() {
        return assignWardScreenController.wardListModel.value.data?.length !=
                    0 &&
                assignWardScreenController.groupValue.value == 0
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await assignWardScreenController.submit(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 5.w,
                        right: 5.w,
                        top: 5.w,
                        bottom: 5.w,
                      ),
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: AppColors().color5B6AEA,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Center(
                        child: CommonWidgets().commonText(
                          text: "Submit",
                          fontSize: 16.sp,
                          fontColor: AppColors().colorFFFFFF,
                          fontFamily: "PlusJakartaSansRegular",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox();
      }),
    );
  }
}
