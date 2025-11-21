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
                                text: "PROFILE",
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
                                          'Are you sure you want to logout?',
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
                                                  "No",
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
                                                      "Yes",
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
                SizedBox(height: 10.w),
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
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                height: 25.w,
                                width: 25.w,
                                "${profileScreenController.profileModel.value.data?.profilePhoto.toString()}",
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) =>
                                    SvgPicture.asset(
                                      "assets/icons/profile.svg",
                                      height: 20.w,
                                      width: 20.w,
                                      fit: BoxFit.fill,
                                    ),
                              ),
                            ),
                            SizedBox(height: 4.w),
                            CommonWidgets().commonText(
                              text:
                                  "Name :- ${profileScreenController.profileModel.value.data?.fullname ?? "N/A"} (${profileScreenController.profileModel.value.data?.username ?? "N/A"})",
                              fontSize: 18.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansMedium",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 1.w),
                            CommonWidgets().commonText(
                              text:
                                  "Email :- ${profileScreenController.profileModel.value.data?.email ?? "N/A"}",
                              fontSize: 18.sp,
                              fontColor: AppColors().color5B6AEA,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 1.w),

                            CommonWidgets().commonText(
                              text:
                                  "Role :- ${profileScreenController.profileModel.value.data?.role ?? "N/A"}",
                              fontSize: 18.sp,
                              fontColor: AppColors().color5B6AEA,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 1.w),
                            CommonWidgets().commonText(
                              text:
                                  "Gender :- ${profileScreenController.profileModel.value.data?.gender ?? "N/A"}",
                              fontSize: 18.sp,
                              fontColor: AppColors().color5B6AEA,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 1.w),
                            CommonWidgets().commonText(
                              text:
                                  "Mobile :- ${profileScreenController.profileModel.value.data?.mobile ?? "N/A"}",
                              fontSize: 18.sp,
                              fontColor: AppColors().color5B6AEA,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 1.w),
                            CommonWidgets().commonText(
                              text:
                                  "Blood Group :- ${profileScreenController.profileModel.value.data?.bloodGroup ?? "N/A"}",
                              fontSize: 18.sp,
                              fontColor: AppColors().color5B6AEA,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.w400,
                            ),

                            SizedBox(height: 5.w),
                            Obx(() {
                              return profileScreenController.permissions
                                      .contains("team:self_profile_update")
                                  ? Column(
                                      children: [
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
                                                text: "Edit Profile",
                                                fontSize: 18.sp,
                                                fontColor:
                                                    AppColors().color1E1E1E,
                                                fontFamily:
                                                    "PlusJakartaSansRegular",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 4.w),
                                      ],
                                    )
                                  : SizedBox();
                            }),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/blackNotification.svg",
                                  height: 20.sp,
                                  width: 20.sp,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 4.w),
                                CommonWidgets().commonText(
                                  text: "Notifications",
                                  fontSize: 18.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 4.w),
                            CommonWidgets().commonText(
                              text: "Version 1.0.0",
                              fontSize: 18.sp,
                              fontColor: AppColors().color5B6AEA,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.w400,
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
