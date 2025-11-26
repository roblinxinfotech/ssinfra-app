import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/controller/homeScreenController.dart';
import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';

import '../controller/editProfileScreenController.dart';
import '../controller/profileScreenController.dart';
import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';
import 'editProfileScreen.dart';
import 'notificationScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileScreenController profileScreenController = Get.put(
    ProfileScreenController(),
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
                        children: [Container(height: 25.sp, width: 25.sp)],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              CommonWidgets().commonText(
                                text: "ProfileCapital".tr,
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
                        children: [
                          GestureDetector(
                            onTap: () async {
                              profileScreenController.getPdf();
                              // print(a);
                            },
                            child: Image.asset(
                              "assets/icons/download.png",
                              height: 25.sp,
                              width: 25.sp,
                              fit: BoxFit.contain,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.dialog(
                                Dialog(
                                  backgroundColor: AppColors().colorFFFFFF,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 8.w,
                                      bottom: 4.w,
                                      left: 2.w,
                                      right: 2.w,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'AreYouSureYouWantToLogout'.tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                "PlusJakartaSansRegular",
                                          ),
                                        ),
                                        SizedBox(height: 4.w),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 2.w,
                                                  horizontal: 6.w,
                                                ),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: AppColors().color5B6AEA
                                                      .withValues(alpha: 0.3),
                                                  border: Border.all(
                                                    color:
                                                        AppColors().color5B6AEA,
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
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColors().color5B6AEA,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2.w),
                                            GestureDetector(
                                              onTap: () async {
                                                profileScreenController
                                                    .logOut();
                                                // Navigator.pop(context);
                                                // await assignVillageScreenController
                                                //     .removeVillage(
                                                //   assignVillageScreenController
                                                //       .assignedVillageList[index]
                                                //       .id,
                                                //   context,
                                                // );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 2.w,
                                                  horizontal: 6.w,
                                                ),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: AppColors().color5B6AEA
                                                      .withValues(alpha: 0.3),
                                                  border: Border.all(
                                                    color:
                                                        AppColors().color5B6AEA,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        1.w,
                                                      ),
                                                ),

                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Yes".tr,
                                                      style: TextStyle(
                                                        color: AppColors()
                                                            .color5B6AEA,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            "AppFontData.regular",
                                                        fontSize: 16.sp,
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
                            child: Image.asset(
                              "assets/icons/switch.png",
                              height: 25.sp,
                              width: 25.sp,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.w),
                Obx(() {
                  return profileScreenController.loader.value == true
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
                      : profileScreenController.errorShow == true
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
                                  text: "Something went wrong.",
                                  fontSize: 20.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansMedium",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.w,

                              padding: EdgeInsets.only(
                                top: 2.w,
                                left: 2.w,
                                right: 2.w,
                                bottom: 2.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.w),

                                color: AppColors().colorFFFFFF.withValues(
                                  alpha: 0.9,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      height: 25.w,
                                      width: 25.w,
                                      "${profileScreenController.profileModel.value.data?.profilePhoto.toString()}",
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                                "assets/icons/placeHolder.png",
                                                height: 20.w,
                                                width: 20.w,
                                                fit: BoxFit.fill,
                                              ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 4.w),
                            Container(
                              width: 100.w,

                              padding: EdgeInsets.only(
                                top: 3.w,
                                left: 3.w,
                                right: 3.w,
                                bottom: 3.w,
                              ),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.w),

                                color: AppColors().colorFFFFFF.withValues(
                                  alpha: 0.9,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonWidgets().commonText(
                                        text: "Name".tr,
                                        fontSize: 18.sp,
                                        fontColor: AppColors().color666666,
                                        fontFamily: "PlusJakartaSansRegular",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Flexible(
                                        child: CommonWidgets().commonText(
                                          text:
                                              "${profileScreenController.profileModel.value.data?.fullname ?? "N/A"} (${profileScreenController.profileModel.value.data?.username ?? "N/A"})",

                                          fontSize: 18.sp,
                                          textAlign: TextAlign.right,
                                          fontColor: AppColors().color1E1E1E,
                                          fontFamily: "PlusJakartaSansRegular",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    height: 1,
                                    width: 100.w,
                                    color: AppColors().colorD7D7D7,
                                  ),
                                  SizedBox(height: 2.w),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonWidgets().commonText(
                                        text: "Email".tr,
                                        fontSize: 18.sp,
                                        fontColor: AppColors().color666666,
                                        fontFamily: "PlusJakartaSansRegular",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Flexible(
                                        child: CommonWidgets().commonText(
                                          text:
                                              "${profileScreenController.profileModel.value.data?.email ?? "N/A"}",
                                          fontSize: 18.sp,
                                          textAlign: TextAlign.right,
                                          fontColor: AppColors().color1E1E1E,
                                          fontFamily: "PlusJakartaSansRegular",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    height: 1,
                                    width: 100.w,
                                    color: AppColors().colorD7D7D7,
                                  ),
                                  SizedBox(height: 2.w),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonWidgets().commonText(
                                        text: "Role".tr,
                                        fontSize: 18.sp,
                                        fontColor: AppColors().color666666,
                                        fontFamily: "PlusJakartaSansRegular",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Flexible(
                                        child: CommonWidgets().commonText(
                                          text:
                                              "${profileScreenController.profileModel.value.data?.role ?? "N/A"}",
                                          fontSize: 18.sp,
                                          textAlign: TextAlign.right,
                                          fontColor: AppColors().color1E1E1E,
                                          fontFamily: "PlusJakartaSansRegular",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    height: 1,
                                    width: 100.w,
                                    color: AppColors().colorD7D7D7,
                                  ),

                                  SizedBox(height: 2.w),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonWidgets().commonText(
                                        text: "Gender".tr,
                                        fontSize: 18.sp,
                                        fontColor: AppColors().color666666,
                                        fontFamily: "PlusJakartaSansRegular",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Flexible(
                                        child: CommonWidgets().commonText(
                                          text:
                                              "${profileScreenController.profileModel.value.data?.gender == null ? "N/A" : profileScreenController.profileModel.value.data?.gender.toString().capitalizeFirst}",

                                          fontSize: 18.sp,
                                          textAlign: TextAlign.right,
                                          fontColor: AppColors().color1E1E1E,
                                          fontFamily: "PlusJakartaSansRegular",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    height: 1,
                                    width: 100.w,
                                    color: AppColors().colorD7D7D7,
                                  ),
                                  SizedBox(height: 2.w),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonWidgets().commonText(
                                        text: "Mobile".tr,
                                        fontSize: 18.sp,
                                        fontColor: AppColors().color666666,
                                        fontFamily: "PlusJakartaSansRegular",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Flexible(
                                        child: CommonWidgets().commonText(
                                          text:
                                              "${profileScreenController.profileModel.value.data?.mobile ?? "N/A"} ",

                                          fontSize: 18.sp,
                                          textAlign: TextAlign.right,
                                          fontColor: AppColors().color1E1E1E,
                                          fontFamily: "PlusJakartaSansRegular",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Container(
                                    height: 1,
                                    width: 100.w,
                                    color: AppColors().colorD7D7D7,
                                  ),

                                  SizedBox(height: 2.w),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonWidgets().commonText(
                                        text: "BloodGroup".tr,
                                        fontSize: 18.sp,
                                        fontColor: AppColors().color666666,
                                        fontFamily: "PlusJakartaSansRegular",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Flexible(
                                        child: CommonWidgets().commonText(
                                          text:
                                              "${profileScreenController.profileModel.value.data?.bloodGroup ?? "N/A"}",

                                          fontSize: 18.sp,
                                          textAlign: TextAlign.right,
                                          fontColor: AppColors().color1E1E1E,
                                          fontFamily: "PlusJakartaSansRegular",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.w),

                                  Container(
                                    height: 1,
                                    width: 100.w,
                                    color: AppColors().colorD7D7D7,
                                  ),
                                  SizedBox(height: 2.w),
                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: CommonWidgets().commonText(
                                            text: "Language".tr,
                                            fontSize: 18.sp,
                                            fontColor: AppColors().color666666,
                                            fontFamily:
                                                "PlusJakartaSansRegular",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            width: 100.w,
                                            padding: EdgeInsets.all(2.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2.w),
                                              border: Border.all(
                                                color: AppColors().color666666,
                                              ),
                                            ),
                                            child: DropdownButton<Locale>(
                                              isDense: true,
                                              isExpanded: true,
                                              dropdownColor: Colors.white,
                                              value: profileScreenController
                                                  .currentLocale
                                                  .value,
                                              underline: const SizedBox(),
                                              icon: const Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: Colors.black,
                                              ),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              onChanged: (Locale? newLocale) {
                                                if (newLocale != null) {
                                                  profileScreenController
                                                      .changeLanguage(
                                                        newLocale,
                                                      );
                                                }
                                              },
                                              items: [
                                                DropdownMenuItem(
                                                  value: Locale('en', 'US'),
                                                  child: Text(
                                                    'English (US)',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily:
                                                          "PlusJakartaSansRegular",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: Locale('gu', 'IN'),
                                                  child: Text(
                                                    'ગુજરાતી',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily:
                                                          "PlusJakartaSansRegular",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 2.w),
                                  Container(
                                    height: 1,
                                    width: 100.w,
                                    color: AppColors().colorD7D7D7,
                                  ),
                                  Obx(() {
                                    return profileScreenController.permissions
                                            .contains(
                                              "team:self_profile_update",
                                            )
                                        ? Column(
                                            children: [
                                              SizedBox(height: 3.w),
                                              GestureDetector(
                                                onTap: () async {
                                                  Get.delete<
                                                    EditProfileScreenController
                                                  >();
                                                  var a = await Get.to(
                                                    EditProfileScreen(),
                                                    arguments: {
                                                      "profileData":
                                                          profileScreenController
                                                              .profileModel
                                                              .value,
                                                    },
                                                  );
                                                  Get.delete<
                                                    ProfileScreenController
                                                  >();
                                                  await profileScreenController
                                                      .getProfileData();
                                                },
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/blackProfile.svg",
                                                      height: 20.sp,
                                                      width: 20.sp,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    SizedBox(width: 4.w),
                                                    CommonWidgets().commonText(
                                                      text: "EditProfileSmall".tr,
                                                      fontSize: 18.sp,
                                                      fontColor: AppColors()
                                                          .color1E1E1E,
                                                      fontFamily:
                                                          "PlusJakartaSansRegular",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 2.w),
                                            ],
                                          )
                                        : SizedBox();
                                  }),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(NotificationScreen());
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/blackNotification.svg",
                                          height: 20.sp,
                                          width: 20.sp,
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(width: 4.w),
                                        CommonWidgets().commonText(
                                          text: "Notification".tr,
                                          fontSize: 18.sp,
                                          fontColor: AppColors().color1E1E1E,
                                          fontFamily: "PlusJakartaSansRegular",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 2.w),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: CommonWidgets().commonText(
                                      text:
                                          "Version".tr +
                                          ": ${profileScreenController.versionName.value}",
                                      fontSize: 18.sp,
                                      fontColor: AppColors().color5B6AEA,
                                      fontFamily: "PlusJakartaSansRegular",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
