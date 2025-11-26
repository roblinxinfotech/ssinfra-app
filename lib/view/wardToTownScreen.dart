import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/controller/villageScreenConroller.dart';

import '../controller/villageToTalukaScreenController.dart';
import '../controller/wardToTalukaScreenController.dart';
import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';

class WardToTownScreen extends StatefulWidget {
  const WardToTownScreen({super.key});

  @override
  State<WardToTownScreen> createState() => _WardToTownScreenState();
}

class _WardToTownScreenState extends State<WardToTownScreen> {
  WardToTownScreenController wardToTownScreenController = Get.put(
    WardToTownScreenController(),
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
                          text: "Wards".tr,
                          // "${villageToTalukaScreenController.villageToTalukaListModel.value.data? ?? ""}",
                          fontSize: 18.sp,
                          fontColor: AppColors().color1E1E1E,
                          fontFamily: "PlusJakartaSansMedium",
                          fontWeight: FontWeight.bold,
                        ),
                        // Obx(() {
                        //   return CommonWidgets().commonText(
                        //     text: "",
                        //     // "${villageToTalukaScreenController.villageToTalukaListModel.value.data? ?? ""}",
                        //     fontSize: 18.sp,
                        //     fontColor: AppColors().color1E1E1E,
                        //     fontFamily: "PlusJakartaSansMedium",
                        //     fontWeight: FontWeight.bold,
                        //   );
                        // }),
                      ],
                    ),
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          wardToTownScreenController.hideShowSearch();
                        },
                        child: wardToTownScreenController.showSearch == false
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
              // SizedBox(height: 5.w),
              Padding(
                padding: EdgeInsets.only(
                  left: 4.w,
                  right: 4.w,
                  bottom: 2.w,
                  top: 2.w,
                ),
                child: Obx(() {
                  return wardToTownScreenController.showSearch.value == true
                      ? Container(
                          height: 40,
                          child: TextFormField(
                            onChanged: (a) async {
                              wardToTownScreenController.searchText = a
                                  .toString();
                              // await teamScreenController.sortData();
                              await wardToTownScreenController.searchItem();
                            },
                            controller: wardToTownScreenController
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
                              border: OutlineInputBorder(),
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
              //         text: "Taluka",
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
              //         text: "Village list",
              //         fontSize: 18.sp,
              //         fontColor: AppColors().color1E1E1E,
              //         fontFamily: "PlusJakartaSansRegular",
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 1.w),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await wardToTownScreenController.getVillageList();
                    await wardToTownScreenController.searchItem();
                  },
                  child: Column(
                    children: [
                      Obx(() {
                        return wardToTownScreenController.loader.value == true
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
                            : wardToTownScreenController.errorShow == true
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
                            : wardToTownScreenController
                                      .wardListModel
                                      .value
                                      .data
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
                            : wardToTownScreenController
                                      .wardList
                                      .value
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
                            : Flexible(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 2.w,
                                    left: 3.w,
                                    right: 3.w,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.w),

                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.black.withValues(alpha: 0.1),
                                    //     spreadRadius: 2,
                                    //     blurRadius: 10,
                                    //   ),
                                    // ],
                                    // image: DecorationImage(
                                    //   fit: BoxFit.cover,
                                    //   image: AssetImage("assets/images/talukaListBg.png"),
                                    // ),
                                    color: AppColors().colorFFFFFF.withValues(
                                      alpha: 0.9,
                                    ),
                                  ),

                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(
                                      top: 3.w,
                                      left: 3.w,
                                      right: 3.w,
                                    ),
                                    itemCount: wardToTownScreenController
                                        .wardList
                                        .value
                                        ?.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Row(
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
                                                            "${wardToTownScreenController.wardList?[index].name}",
                                                        fontSize: 16.sp,
                                                        fontColor: AppColors()
                                                            .color1E1E1E,
                                                        fontFamily:
                                                            "PlusJakartaSansRegular",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        maxline: 2,
                                                        overFlow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 1.w),

                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left: 2.w,
                                                      right: 2.w,
                                                      top: 1.w,
                                                      bottom: 1.w,
                                                    ),

                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: AppColors()
                                                              .color666666
                                                              .withValues(
                                                                alpha: 0.2,
                                                              ),
                                                          blurRadius: 20,
                                                          spreadRadius: 1,
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10.sp,
                                                          ),
                                                    ),
                                                    child: CommonWidgets().commonText(
                                                      text:
                                                          "${wardToTownScreenController.wardList[index].assign == true ? "Assigned".tr : "NotAssigned".tr}",
                                                      fontSize: 15.sp,
                                                      fontColor: AppColors()
                                                          .color1E1E1E,
                                                      fontFamily:
                                                          "PlusJakartaSansMedium",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      maxline: 1,
                                                      overFlow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(width: 3.w),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left: 2.w,
                                                      right: 2.w,
                                                      top: 1.w,
                                                      bottom: 1.w,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: AppColors()
                                                              .color666666
                                                              .withValues(
                                                                alpha: 0.2,
                                                              ),
                                                          blurRadius: 20,
                                                          spreadRadius: 1,
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10.sp,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/icons/forward.svg",
                                                          height: 16.sp,
                                                          width: 16.sp,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        CommonWidgets().commonText(
                                                          text: "",
                                                          fontSize: 16.sp,
                                                          fontColor: AppColors()
                                                              .color1E1E1E,
                                                          fontFamily:
                                                              "PlusJakartaSansMedium",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          maxline: 1,
                                                          overFlow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     Container(
                                              //       padding: EdgeInsets.only(
                                              //         left: 2.w,
                                              //         right: 2.w,
                                              //         top: 1.w,
                                              //         bottom: 1.w,
                                              //       ),
                                              //       decoration: BoxDecoration(
                                              //         color: Colors.white30,
                                              //         borderRadius: BorderRadius.circular(15.sp),
                                              //       ),
                                              //       child: Row(
                                              //         children: [
                                              //           SvgPicture.asset(
                                              //             "assets/icons/blueRound.svg",
                                              //             height: 12.sp,
                                              //             width: 12.sp,
                                              //             fit: BoxFit.fill,
                                              //           ),
                                              //           SizedBox(width: 3.w),
                                              //           CommonWidgets().commonText(
                                              //             text: "Bavla - 009",
                                              //             fontSize: 16.sp,
                                              //             fontColor: AppColors().color1E1E1E,
                                              //             fontFamily: "PlusJakartaSansRegular",
                                              //             fontWeight: FontWeight.bold,
                                              //             maxline: 1,
                                              //             overFlow: TextOverflow.ellipsis,
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //     Column(
                                              //       children: [
                                              //         CommonWidgets().commonText(
                                              //           text: "Assigned",
                                              //           fontSize: 15.sp,
                                              //           fontColor: AppColors().color666666,
                                              //           fontFamily: "PlusJakartaSansRegular",
                                              //           fontWeight: FontWeight.bold,
                                              //         ),
                                              //         Container(
                                              //           height: 20.sp,
                                              //           width: 20.sp,
                                              //           margin: EdgeInsets.only(top: 2.w),
                                              //           decoration: BoxDecoration(
                                              //             boxShadow: [
                                              //               BoxShadow(
                                              //                 color: Colors.black12,
                                              //                 spreadRadius: 2,
                                              //                 blurRadius: 20,
                                              //                 offset: Offset(0, 2),
                                              //               ),
                                              //             ],
                                              //           ),
                                              //           child: ClipRRect(
                                              //             borderRadius: BorderRadius.circular(50),
                                              //             child: Image.asset(
                                              //               fit: BoxFit.fill,
                                              //               "assets/images/lbImage.png",
                                              //             ),
                                              //           ),
                                              //         ),
                                              //         CommonWidgets().commonText(
                                              //           text: "Not Assign",
                                              //           fontSize: 15.sp,
                                              //           fontColor: AppColors().colorFF0000,
                                              //           fontFamily: "PlusJakartaSansMedium",
                                              //           fontWeight: FontWeight.w800,
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ],
                                              // ),
                                              // SizedBox(height: 4.w),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     Container(
                                              //       padding: EdgeInsets.only(
                                              //         left: 2.w,
                                              //         right: 2.w,
                                              //         top: 1.w,
                                              //         bottom: 1.w,
                                              //       ),
                                              //
                                              //       child: Row(
                                              //         children: [
                                              //           SvgPicture.asset(
                                              //             "assets/icons/roundedHome.svg",
                                              //             height: 25.sp,
                                              //             width: 25.sp,
                                              //             fit: BoxFit.fill,
                                              //           ),
                                              //           SizedBox(width: 3.w),
                                              //           Row(
                                              //             children: [
                                              //               CommonWidgets().commonText(
                                              //                 text: "Villages - ",
                                              //                 fontSize: 17.sp,
                                              //                 fontColor: AppColors().color1E1E1E,
                                              //                 fontFamily: "PlusJakartaSansRegular",
                                              //                 fontWeight: FontWeight.bold,
                                              //               ),
                                              //               CommonWidgets().commonText(
                                              //                 text: "47",
                                              //                 fontSize: 18.sp,
                                              //                 fontColor: AppColors().color1E1E1E,
                                              //                 fontFamily: "PlusJakartaSansMedium",
                                              //                 fontWeight: FontWeight.bold,
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //     Container(
                                              //       padding: EdgeInsets.only(
                                              //         left: 2.w,
                                              //         right: 2.w,
                                              //         top: 1.w,
                                              //         bottom: 1.w,
                                              //       ),
                                              //
                                              //       child: Row(
                                              //         children: [
                                              //           SvgPicture.asset(
                                              //             "assets/icons/blueTeam.svg",
                                              //             height: 25.sp,
                                              //             width: 25.sp,
                                              //             fit: BoxFit.fill,
                                              //           ),
                                              //           SizedBox(width: 3.w),
                                              //           Row(
                                              //             children: [
                                              //               CommonWidgets().commonText(
                                              //                 text: "Team - ",
                                              //                 fontSize: 17.sp,
                                              //                 fontColor: AppColors().color1E1E1E,
                                              //                 fontFamily: "PlusJakartaSansRegular",
                                              //                 fontWeight: FontWeight.bold,
                                              //               ),
                                              //               CommonWidgets().commonText(
                                              //                 text: "47",
                                              //                 fontSize: 18.sp,
                                              //                 fontColor: AppColors().color1E1E1E,
                                              //                 fontFamily: "PlusJakartaSansMedium",
                                              //                 fontWeight: FontWeight.bold,
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              // // SvgPicture.asset(
                                              // //   height: 15.w,
                                              // //   width: 15.w,
                                              // //   fit: BoxFit.fill,
                                              // //   "assets/icons/waterPaper.svg",
                                              // // ),
                                              // //
                                              // // RichText(
                                              // //   text: TextSpan(
                                              // //     style: TextStyle(
                                              // //       fontSize: 16.sp,
                                              // //       color: Colors.black,
                                              // //       fontWeight: FontWeight.w600,
                                              // //     ),
                                              // //     children: [
                                              // //       const TextSpan(
                                              // //         text: 'ભૂગર્ભ જળ યોજના ફોર્મ (GWS)',
                                              // //       ),
                                              // //       WidgetSpan(
                                              // //         alignment: PlaceholderAlignment.middle,
                                              // //         child: Padding(
                                              // //           padding: EdgeInsets.only(left: 2.w),
                                              // //           child: SvgPicture.asset(
                                              // //             "assets/icons/forward.svg",
                                              // //             height: 15.sp,
                                              // //             width: 15.sp,
                                              // //           ),
                                              // //         ),
                                              // //       ),
                                              // //     ],
                                              // //   ),
                                              // // ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: 3.w,
                                              bottom: 3.w,
                                            ),
                                            height: 1,
                                            width: 100.w,
                                            color: AppColors().colorFFDDDD,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
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
      //               // Get.to(TalukaScreen());
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
