import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/view/assignedWardScreen.dart';
import 'package:ssinfra/view/teamDetailScreen.dart';

import '../controller/teamScreenController.dart';
import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';
import 'addMemberScreen.dart';
import 'assignVillageScreen.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  TeamScreenController teamScreenController = Get.put(TeamScreenController());

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
                        Container(height: 25.sp, width: 25.sp),
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
                        Obx(() {
                          return teamScreenController.permissions.contains(
                                "team:add",
                              )
                              ? GestureDetector(
                                  onTap: () async {
                                    var a = await Get.to(AddMemberScreen());
                                    // Get.delete<TeamScreenController>();
                                    await teamScreenController.getTeamList();
                                  },
                                  child: Image.asset(
                                    "assets/icons/addTeam.png",
                                    height: 25.sp,
                                    width: 25.sp,
                                  ),
                                )
                              : SizedBox(height: 25.sp, width: 25.sp);
                        }),
                        Obx(() {
                          return GestureDetector(
                            onTap: () {
                              teamScreenController.hideShowSearch();
                            },
                            child: teamScreenController.showSearch == false
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
                  ],
                ),
              ),
              SizedBox(height: 5.w),
              Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 2.w),
                child: Obx(() {
                  return teamScreenController.showSearch.value == true
                      ? Container(
                          height: 40,
                          child: TextFormField(
                            onChanged: (a) async {
                              teamScreenController.searchText = a.toString();
                              // await teamScreenController.sortData();
                              await teamScreenController.searchItem();
                            },
                            controller:
                                teamScreenController.searchController.value,
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
                              hintText: "Search team",
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
              SizedBox(height: 1.w),
              Obx(() {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Row(
                    children: [
                      // ---- TAB 1 : PENDING ----
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            teamScreenController.groupValue.value = 0;
                            await teamScreenController.sortData();
                            await teamScreenController.searchItem();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: teamScreenController.groupValue.value == 0
                                  ? AppColors().color5B6AEA.withValues(
                                      alpha: 0.3,
                                    )
                                  : Colors.transparent,
                              border: Border.all(
                                color:
                                    teamScreenController.groupValue.value == 0
                                    ? AppColors().color5B6AEA
                                    : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            child: Text(
                              "Pending",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    teamScreenController.groupValue.value == 0
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
                            teamScreenController.groupValue.value = 1;
                            await teamScreenController.sortData();
                            await teamScreenController.searchItem();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: teamScreenController.groupValue.value == 1
                                  ? AppColors().color5B6AEA.withValues(
                                      alpha: 0.3,
                                    )
                                  : Colors.transparent,
                              border: Border.all(
                                color:
                                    teamScreenController.groupValue.value == 1
                                    ? AppColors().color5B6AEA
                                    : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            child: Text(
                              "Approved",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    teamScreenController.groupValue.value == 1
                                    ? AppColors().color5B6AEA
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 2.w),

                      // ---- TAB 3 : REJECTED ----
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            teamScreenController.groupValue.value = 2;
                            await teamScreenController.sortData();
                            await teamScreenController.searchItem();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: teamScreenController.groupValue.value == 2
                                  ? AppColors().color5B6AEA.withValues(
                                      alpha: 0.3,
                                    )
                                  : Colors.transparent,
                              border: Border.all(
                                color:
                                    teamScreenController.groupValue.value == 2
                                    ? AppColors().color5B6AEA
                                    : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            child: Text(
                              "Rejected",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                    teamScreenController.groupValue.value == 2
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

              SizedBox(height: 2.w),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await teamScreenController.getTeamList();
                    await teamScreenController.searchItem();
                  },
                  child: Column(
                    children: [
                      Obx(() {
                        return teamScreenController.loader.value == true
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
                            : teamScreenController.errorShow == true
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
                                        text: "SOMETHING WENT WRONG",
                                        fontSize: 20.sp,
                                        fontColor: AppColors().color1E1E1E,
                                        fontFamily: "PlusJakartaSansMedium",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : teamScreenController.teamList.value?.length == 0
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
                                        text: "NO DATA FOUND.",
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
                                child: GridView.builder(
                                  itemCount: teamScreenController
                                      .teamList
                                      .value
                                      ?.length,
                                  padding: EdgeInsets.only(
                                    left: 2.w,
                                    right: 2.w,
                                    top: 2.w,
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.w,
                                        childAspectRatio: 0.72,
                                        mainAxisSpacing: 3.w,
                                      ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          TeamDetailScreen(
                                            teamDetail: teamScreenController
                                                .teamList
                                                .value[index],
                                          ),
                                        );
                                      },
                                      child: Container(
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
                                          borderRadius: BorderRadius.circular(
                                            10.sp,
                                          ),
                                        ),
                                        margin: EdgeInsets.only(
                                          left: 2.w,
                                          right: 2.w,
                                          bottom: 2.w,
                                        ),
                                        padding: EdgeInsets.only(
                                          left: 2.w,
                                          right: 2.w,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.network(
                                                height: 20.w,
                                                width: 20.w,
                                                "${teamScreenController.teamList.value[index].profilePhoto.toString()}",
                                                fit: BoxFit.fill,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => SvgPicture.asset(
                                                      "assets/icons/profile.svg",
                                                      height: 20.w,
                                                      width: 20.w,
                                                      fit: BoxFit.fill,
                                                    ),
                                              ),
                                            ),
                                            CommonWidgets().commonText(
                                              text:
                                                  "${teamScreenController.teamList.value[index].fullname}",
                                              fontSize: 16.sp,
                                              textAlign: TextAlign.center,
                                              fontColor:
                                                  AppColors().color1E1E1E,
                                              fontFamily:
                                                  "PlusJakartaSansMedium",
                                              fontWeight: FontWeight.bold,
                                            ),
                                            CommonWidgets().commonText(
                                              text:
                                                  teamScreenController
                                                          .teamList
                                                          .value[index]
                                                          .subDistrictId !=
                                                      null
                                                  ? "Village : ${teamScreenController.teamList.value[index].assignedVillages?.length}"
                                                  : teamScreenController
                                                            .teamList
                                                            .value[index]
                                                            .townId !=
                                                        null
                                                  ? "Ward : ${teamScreenController.teamList.value[index].assignedWards?.length}"
                                                  : "",
                                              fontSize: 16.sp,
                                              textAlign: TextAlign.center,
                                              fontColor:
                                                  AppColors().color1E1E1E,
                                              fontFamily:
                                                  "PlusJakartaSansMedium",
                                              fontWeight: FontWeight.bold,
                                            ),
                                            SizedBox(height: 2.w),
                                            teamScreenController
                                                        .teamList
                                                        .value[index]
                                                        .isVerified ==
                                                    1
                                                ? GestureDetector(
                                                    onTap: () async {
                                                      if (teamScreenController
                                                          .permissions
                                                          .value
                                                          .contains(
                                                            "team:assign_village_ward",
                                                          )) {
                                                        if (teamScreenController
                                                                .teamList
                                                                .value[index]
                                                                .subDistrictId !=
                                                            null) {
                                                          var a = await Get.to(
                                                            AssignVillageScreen(),
                                                            arguments: {
                                                              "talukaId":
                                                                  "${teamScreenController.teamList.value[index].subDistrictId.toString()}",
                                                              "userId":
                                                                  "${teamScreenController.teamList.value[index].id.toString()}",
                                                            },
                                                          );
                                                          teamScreenController
                                                              .getTeamList();
                                                        } else {
                                                          var a = await Get.to(
                                                            AssignWardScreen(),
                                                            arguments: {
                                                              "talukaId":
                                                                  "${teamScreenController.teamList.value[index].townId.toString()}",
                                                              "userId":
                                                                  "${teamScreenController.teamList.value[index].id.toString()}",
                                                            },
                                                          );
                                                          teamScreenController
                                                              .getTeamList();
                                                        }
                                                      } else {}
                                                    },
                                                    child: Container(
                                                      width: 100.w,
                                                      padding: EdgeInsets.all(
                                                        3.w,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: AppColors()
                                                            .color5B6AEA,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10.sp,
                                                            ),
                                                      ),
                                                      child: Center(
                                                        child: CommonWidgets()
                                                            .commonText(
                                                              text: "Assign",
                                                              fontSize: 16.sp,
                                                              fontColor:
                                                                  AppColors()
                                                                      .colorFFFFFF,
                                                              fontFamily:
                                                                  "PlusJakartaSansRegular",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
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
    );
  }
}
