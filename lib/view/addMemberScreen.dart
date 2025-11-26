import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../controller/addMemberScreenController.dart';
import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  AddMemberScreenController addMemberScreenController = Get.put(
    AddMemberScreenController(),
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
                    Column(
                      children: [
                        CommonWidgets().commonText(
                          text: "AddTeamMember".tr,
                          fontSize: 18.sp,
                          fontColor: AppColors().color1E1E1E,
                          fontFamily: "PlusJakartaSansMedium",
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          height: 1,
                          width: 30.w,
                          color: AppColors().color5B6AEA,
                        ),
                      ],
                    ),
                    Container(height: 25.sp, width: 25.sp),
                  ],
                ),
              ),
              SizedBox(height: 5.w),

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
              //
              // SizedBox(height: 1.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 2.w, left: 3.w, right: 3.w),

                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 2.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.w),

                          color: AppColors().colorFFFFFF.withValues(alpha: 0.9),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [


                                GestureDetector(
                                  onTap: () async {
                                    Get.dialog(
                                      Dialog(
                                        backgroundColor: AppColors()
                                            .colorFFFFFF,
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
                                                'SelectImageByBelowOptions'.tr,
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
                                                      final XFile? image = await addMemberScreenController
                                                          .picker.pickImage(
                                                          source: ImageSource
                                                              .camera,
                                                          imageQuality: 50);
                                                      Navigator.pop(context);
                                                      if (image != null) {
                                                        addMemberScreenController
                                                            .profileImage
                                                            ?.value =
                                                            File(image.path);
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                      EdgeInsets.symmetric(
                                                        vertical: 2.w,
                                                        horizontal: 6.w,
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
                                                        "Camera".tr,
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontFamily: "PlusJakartaSansMedium",
                                                          color: AppColors()
                                                              .color5B6AEA,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final XFile? image = await addMemberScreenController
                                                          .picker.pickImage(
                                                          source: ImageSource
                                                              .gallery,
                                                          imageQuality: 50);
                                                      Navigator.pop(context);
                                                      if (image != null) {
                                                        addMemberScreenController
                                                            .profileImage
                                                            ?.value =
                                                            File(image.path);
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                      EdgeInsets.symmetric(
                                                        vertical: 2.w,
                                                        horizontal: 6.w,
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
                                                            "Gallery".tr,
                                                            style: TextStyle(
                                                              color: AppColors()
                                                                  .color5B6AEA,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              fontFamily: "PlusJakartaSansMedium",
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


                                    // final XFile? image = await addMemberScreenController
                                    //     .picker.pickImage(
                                    //     source: ImageSource.camera,
                                    //     imageQuality: 50);
                                    // if (image != null) {
                                    //   addMemberScreenController.profileImage
                                    //       ?.value =
                                    //       File(image.path);
                                    // }
                                  },
                                  child: Obx(
                                          () {
                                        return Container(
                                          margin: EdgeInsets.all(2.w),
                                          child: Container(
                                            height: 30.w,
                                            width: 30.w,

                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                addMemberScreenController
                                                    .profileImage
                                                    ?.value ==
                                                    null ? Container(
                                                  height: 30.w,
                                                  width: 100.w,
                                                  decoration: BoxDecoration(
                                                    color: AppColors()
                                                        .color787878
                                                        .withValues(alpha: 0.1),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      "assets/images/outLineProfile.svg",
                                                      height: 10.w,
                                                      width: 10.w,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ) : Container(
                                                  height: 30.w,
                                                  width: 100.w,
                                                  margin: EdgeInsets.all(1.w),
                                                  decoration: BoxDecoration(
                                                    color: AppColors()
                                                        .color787878
                                                        .withValues(alpha: 0.1),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .circular(100),
                                                    child: Image.file(
                                                        height: 15.w,
                                                        width: 20.w,
                                                        fit: BoxFit.fill,
                                                        addMemberScreenController
                                                            .profileImage
                                                            .value!),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: SvgPicture.asset(
                                                    "assets/icons/greyCamera.svg",
                                                    height: 8.w,
                                                    width: 8.w,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.w),
                      Container(
                        padding: EdgeInsets.only(
                          top: 2.w,
                          left: 3.w,
                          right: 3.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.w),

                          color: AppColors().colorFFFFFF.withValues(alpha: 0.9),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidgets().commonText(
                              text: "PersonalInformation".tr,
                              fontSize: 18.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansMedium",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 2.w),
                            Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "FullName".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ), CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.w),
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller:
                                addMemberScreenController.fullName.value,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'^\s+'),
                                  ),
                                ],
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
                                  // hintText: "Shubham Joshi",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            Row(
                              children: [

                                CommonWidgets().commonText(
                                  text: "UserName".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(
                                height: 1.w),
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller:
                                addMemberScreenController.userName.value,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'\s'),
                                  ),
                                ],
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
                                  // hintText: "Shubham J",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "EmailAddress".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(
                                height: 1.w),
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller: addMemberScreenController
                                    .emailAddress
                                    .value,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'\s'),
                                  ),
                                ],
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
                                  // hintText: "shubham47@gmail.com",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "Password".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(
                                height: 1.w),
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller:
                                addMemberScreenController.password.value,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'\s'),
                                  ),
                                ],
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
                                  // hintText: "********",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "ConfirmPassword".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(
                                height: 1.w),
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller: addMemberScreenController
                                    .confirmPassword
                                    .value,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'\s'),
                                  ),
                                ],
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
                                  // hintText: "********",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "PhoneNumber".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(
                                height: 1.w),
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller:
                                addMemberScreenController.phoneNumber.value,
                                keyboardType: TextInputType.number,
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
                                  // hintText: "9973432678",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            CommonWidgets().commonText(
                              text: "Status".tr,
                              fontSize: 16.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.bold,
                            ),
                            Obx(
                                    () {
                                  return Switch(
                                    activeThumbColor: AppColors().color5B6AEA,
                                    inactiveTrackColor: AppColors().colorFFFFFF,
                                    value: addMemberScreenController.status
                                        .value,
                                    onChanged: (value) {
                                      addMemberScreenController.status.value =
                                          value;
                                    },
                                    activeColor: Colors.green,
                                    inactiveThumbColor: Colors.grey,
                                  );
                                }
                            ),


                            SizedBox(height: 3.w),
                            Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "EmergencyMobile".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(
                                height: 1.w),
                            Container(
                              height: 40,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: addMemberScreenController
                                    .emergencyMobileNumber
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
                                  // hintText: "9973432660",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CommonWidgets().commonText(
                                            text: "DateOfBirth".tr,
                                            fontSize: 16.sp,
                                            fontColor: AppColors().color1E1E1E,
                                            fontFamily: "PlusJakartaSansRegular",
                                            fontWeight: FontWeight.bold,
                                          ),
                                          CommonWidgets().commonText(
                                            text: " *",
                                            fontSize: 16.sp,
                                            fontColor: AppColors().colorFF0000,
                                            fontFamily: "PlusJakartaSansRegular",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 1.w),
                                      Obx(() {
                                        return Container(
                                          height: 40,
                                          child: TextFormField(
                                            readOnly: true,
                                            controller:
                                            addMemberScreenController
                                                .birthDate
                                                .value,
                                            decoration: InputDecoration(
                                              prefixIcon: GestureDetector(
                                                onTap: () async {
                                                  final DateTime?
                                                  picked = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    // Default to today
                                                    firstDate: DateTime(1950),
                                                    // Earliest selectable date
                                                    lastDate: DateTime
                                                        .now(), // Latest selectable date
                                                  );
                                                  if (picked != null) {
                                                    final year = picked.year
                                                        .toString();
                                                    final month = picked.month
                                                        .toString().padLeft(
                                                        2, '0');
                                                    final date = picked.day
                                                        .toString().padLeft(
                                                        2, '0');

                                                    addMemberScreenController
                                                        .birthDate.value.text =
                                                    "$year-$month-$date";
                                                  }
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    10.0,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    "assets/icons/calendar.svg",
                                                  ),
                                                ),
                                              ),
                                              disabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors()
                                                      .color787878,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  AppColors().colorD7D7D7,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  AppColors().color5B6AEA,
                                                ),
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                left: 10,
                                              ),
                                              border:
                                              const OutlineInputBorder(),
                                              // hintText: "2024-12-12",
                                              hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontFamily:
                                                "PlusJakartaSansRegular",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      SizedBox(height: 3.w),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CommonWidgets().commonText(
                                            text: "BloodGroup".tr,
                                            fontSize: 16.sp,
                                            fontColor: AppColors().color1E1E1E,
                                            fontFamily: "PlusJakartaSansRegular",
                                            fontWeight: FontWeight.bold,
                                          ),
                                          CommonWidgets().commonText(
                                            text: " *",
                                            fontSize: 16.sp,
                                            fontColor: AppColors().colorFF0000,
                                            fontFamily: "PlusJakartaSansRegular",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 1.w),
                                      Container(
                                        height: 40,
                                        child: TextFormField(
                                          controller: addMemberScreenController
                                              .bloodGroup
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
                                            contentPadding: EdgeInsets.only(
                                              left: 10,
                                            ),
                                            border: const OutlineInputBorder(),
                                            // hintText: "A+",
                                            hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontFamily:
                                              "PlusJakartaSansRegular",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 3.w),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            CommonWidgets().commonText(
                              text: "Gender".tr,
                              fontSize: 16.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 1.w),

                            Container(
                              height: 42,

                              child: DropdownButtonFormField<int>(
                                value: 1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 30,
                                    color: AppColors().color1E1E1E,
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
                                  border: OutlineInputBorder(),
                                ),

                                items: [
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text(
                                      "Male",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: "PlusJakartaSansRegular",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Text(
                                      "Female",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: "PlusJakartaSansRegular",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text(
                                      "Other",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: "PlusJakartaSansRegular",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                                onChanged: (v) {
                                  print(v.toString());
                                  if (v == 1) {
                                    addMemberScreenController.gender.value =
                                    "male";
                                  }
                                  if (v == 2) {
                                    addMemberScreenController.gender.value =
                                    "female";
                                  }
                                  if (v == 3) {
                                    addMemberScreenController.gender.value =
                                    "other";
                                  }
                                },
                              ),
                            ),

                            SizedBox(height: 1.w),
                            SizedBox(height: 3.w),
                            CommonWidgets().commonText(
                              text: "AreaType".tr,
                              fontSize: 16.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 1.w),

                            Obx(
                                    () {
                                  return Container(
                                    height: 42,
                                    child: DropdownButtonFormField<int>(
                                      value: addMemberScreenController
                                          .storedCategory
                                          .value,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          size: 30,
                                          color: AppColors().color1E1E1E,
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
                                        border: OutlineInputBorder(),
                                      ),

                                      items: addMemberScreenController
                                          .categoryList
                                          .value
                                          .map(
                                            (opt) =>
                                            DropdownMenuItem(
                                                value: opt.id,
                                                child: Text(
                                                    "${opt.name
                                                        .toString()
                                                        .capitalizeFirst}")),
                                      )
                                          .toList(),
                                      onChanged: (v) {
                                        var selectedItem = addMemberScreenController
                                            .categoryList
                                            .value
                                            .firstWhere((e) => e.id == v);
                                        addMemberScreenController
                                            .storedCategory
                                            .value = v;
                                        print(selectedItem.name);
                                        if (selectedItem.name == "urban") {
                                          addMemberScreenController
                                              .getUrbanData(v);
                                        } else
                                        if (selectedItem.name == "rural") {
                                          addMemberScreenController
                                              .getRuralData(v);
                                        }
                                      },
                                    ),
                                  );
                                }
                            ),
                            SizedBox(height: 2.w),
                            Obx(
                                    () {
                                  return CommonWidgets().commonText(
                                    text: addMemberScreenController
                                        .storedCategory
                                        .value == 1
                                        ? "SelectTown".tr
                                        : addMemberScreenController
                                        .storedCategory
                                        .value == 2 ? "SelectTaluka".tr : "",
                                    fontSize: 16.sp,
                                    fontColor: AppColors().color1E1E1E,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.bold,
                                  );
                                }
                            ),
                            SizedBox(height: 1.w),

                            Obx(
                                    () {
                                  return addMemberScreenController.loadDropDown
                                      .value == true ? Container(
                                    height: 42,
                                    child: DropdownButtonFormField<int>(
                                      value: addMemberScreenController
                                          .storedsubDustrictId
                                          .value,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          size: 30,
                                          color: AppColors().color1E1E1E,
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
                                        border: OutlineInputBorder(),
                                      ),

                                      items: addMemberScreenController
                                          .storedCategory == 1
                                          ? addMemberScreenController
                                          .assignedTownList
                                          .value
                                          .map(
                                            (opt) =>
                                            DropdownMenuItem(
                                                value: opt.townId,
                                                child: Text(
                                                    opt.name.toString())),
                                      )
                                          .toList()
                                          : addMemberScreenController
                                          .talukaList
                                          .value
                                          .map(
                                            (opt) =>
                                            DropdownMenuItem(
                                                value: opt.subDistrictId,
                                                child: Text(
                                                    opt.name.toString())),
                                      )
                                          .toList(),
                                      onChanged: (v) {
                                        addMemberScreenController
                                            .storedsubDustrictId
                                            .value = v;
                                        print(addMemberScreenController
                                            .storedsubDustrictId
                                            .value);
                                      },
                                    ),
                                  ) : Center(
                                      child: CircularProgressIndicator());
                                }
                            ),

                            SizedBox(height: 3.w),
                            Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "Address".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.w),
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller: addMemberScreenController
                                    .personAddress
                                    .value,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'^\s+'),
                                  ),
                                ],
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
                                  // hintText: "Block-A, B-1, blue valley, Ahemdabad, Gujarat. ",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            CommonWidgets().commonText(
                              text: "BankInformation".tr,
                              fontSize: 18.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansMedium",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 3.w),
                            Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "BankName".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.w),
                            Container(
                              height: 40,

                              child: TextFormField(
                                controller: addMemberScreenController.bankName
                                    .value,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'^\s+'),
                                  ),
                                ],
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
                                  // hintText: "STATEBANK OF INADIA",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "BranchName".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.w),
                            Container(
                              height: 40,

                              child: TextFormField(
                                controller: addMemberScreenController.branchName
                                    .value,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'^\s+'),
                                  ),
                                ],
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
                                  // hintText: "Vastral sbi",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "BankAccountHolderName".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.w),
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller: addMemberScreenController
                                    .bankAccountHolderName.value,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'^\s+'),
                                  ),
                                ],
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
                                  // hintText: "Kishan Bharatbhai Patel",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "BankAccountNo".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.w),
                            Container(
                              height: 40,
                              child: TextFormField(
                                controller: addMemberScreenController
                                    .bankAccountNumber.value,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'\s'),
                                  ),
                                ],
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
                                  // hintText: "45336778907",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "IFSCCode".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.w),
                            Container(
                              height: 40,
                              child: TextFormField(
                                textCapitalization:
                                TextCapitalization.characters,
                                controller: addMemberScreenController.ifscCode
                                    .value,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r'\s'),
                                  ),
                                ],
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
                                  // hintText: "45336778907",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.w),
                            CommonWidgets().commonText(
                              text: "UploadProofBlankChequePassBook".tr,
                              fontSize: 16.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                                height: 2.w),
                            GestureDetector(
                              onTap: () async {
                                Get.dialog(
                                  Dialog(
                                    backgroundColor: AppColors()
                                        .colorFFFFFF,
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
                                            'SelectImageByBelowOptions'.tr,
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
                                                  final XFile? image = await addMemberScreenController
                                                      .picker.pickImage(
                                                      source: ImageSource
                                                          .camera,
                                                      imageQuality: 50);
                                                  Navigator.pop(context);
                                                  if (image != null) {
                                                    addMemberScreenController
                                                        .bankImage
                                                        ?.value =
                                                        File(image.path);
                                                  }
                                                },
                                                child: Container(
                                                  padding:
                                                  EdgeInsets.symmetric(
                                                    vertical: 2.w,
                                                    horizontal: 6.w,
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
                                                    "Camera".tr,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontFamily: "PlusJakartaSansMedium",
                                                      color: AppColors()
                                                          .color5B6AEA,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 2.w),
                                              GestureDetector(
                                                onTap: () async {
                                                  final XFile? image = await addMemberScreenController
                                                      .picker.pickImage(
                                                      source: ImageSource
                                                          .gallery,
                                                      imageQuality: 50);
                                                  Navigator.pop(context);
                                                  if (image != null) {
                                                    addMemberScreenController
                                                        .bankImage
                                                        ?.value =
                                                        File(image.path);
                                                  }
                                                },
                                                child: Container(
                                                  padding:
                                                  EdgeInsets.symmetric(
                                                    vertical: 2.w,
                                                    horizontal: 6.w,
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
                                                        "Gallery".tr,
                                                        style: TextStyle(
                                                          color: AppColors()
                                                              .color5B6AEA,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily: "PlusJakartaSansMedium",
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
                              child: DottedBorder(
                                color: AppColors().colorD7D7D7,
                                strokeWidth: 2,
                                dashPattern: [6, 3],
                                borderType: BorderType.RRect,
                                radius: Radius.circular(10),
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/upload.svg",
                                            height: 30,
                                            width: 30,
                                            fit: BoxFit.fill,
                                          ),
                                          SizedBox(width: 2.w),
                                          CommonWidgets().commonText(
                                            text: "Upload",
                                            fontSize: 16.sp,
                                            fontColor: AppColors().colorD7D7D7,
                                            fontFamily: "PlusJakartaSansRegular",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      Obx(
                                              () {
                                            return addMemberScreenController
                                                .bankImage
                                                ?.value == null
                                                ? SizedBox()
                                                : Icon(Icons.check,
                                              color: Colors.green,);
                                          }
                                      )
                                    ],
                                  ),
                                  // child: TextFormField(
                                  //   decoration: InputDecoration(
                                  //     disabledBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide(
                                  //         color: AppColors().color787878,
                                  //       ),
                                  //     ),
                                  //     enabledBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide(
                                  //         color: AppColors().colorD7D7D7,
                                  //       ),
                                  //     ),
                                  //     focusedBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide(
                                  //         color: AppColors().color5B6AEA,
                                  //       ),
                                  //     ),
                                  //     contentPadding: EdgeInsets.only(left: 10),
                                  //     border: const OutlineInputBorder(),
                                  //     hintText: "shubham47@gmail.com",
                                  //     hintStyle: TextStyle(
                                  //       fontSize: 16,
                                  //       fontFamily: "PlusJakartaSansRegular",
                                  //       fontWeight: FontWeight.w600,
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.w),
                            CommonWidgets().commonText(
                              text: "KycInformation".tr,
                              fontSize: 18.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansMedium",
                              fontWeight: FontWeight.bold,
                            ),

                            SizedBox(
                                height: 2.w), Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "AadharcardNumber".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 2.w),
                            Container(
                              height: 42,
                              child: TextFormField(
                                controller: addMemberScreenController
                                    .adharNumber.value,
                                keyboardType: TextInputType.number,
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
                                  contentPadding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  border: const OutlineInputBorder(),
                                  // hintText: "324767546896",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: AppColors().color1E1E1E,
                                    fontFamily: "PlusJakartaSansRegular",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              // child: TextFormField(
                              //   decoration: InputDecoration(
                              //     disabledBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(
                              //         color: AppColors().color787878,
                              //       ),
                              //     ),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(
                              //         color: AppColors().colorD7D7D7,
                              //       ),
                              //     ),
                              //     focusedBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(
                              //         color: AppColors().color5B6AEA,
                              //       ),
                              //     ),
                              //     contentPadding: EdgeInsets.only(left: 10),
                              //     border: const OutlineInputBorder(),
                              //     hintText: "shubham47@gmail.com",
                              //     hintStyle: TextStyle(
                              //       fontSize: 16,
                              //       fontFamily: "PlusJakartaSansRegular",
                              //       fontWeight: FontWeight.w600,
                              //     ),
                              //   ),
                              // ),
                            ),
                            SizedBox(
                                height: 2.w),

                            CommonWidgets().commonText(
                              text: "UploadPhotos".tr,
                              fontSize: 16.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 2.w),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      Get.dialog(
                                        Dialog(
                                          backgroundColor: AppColors()
                                              .colorFFFFFF,
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
                                                  'SelectImageByBelowOptions'
                                                      .tr,
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
                                                        final XFile? image = await addMemberScreenController
                                                            .picker.pickImage(
                                                            source: ImageSource
                                                                .camera,
                                                            imageQuality: 50);
                                                        Navigator.pop(context);
                                                        if (image != null) {
                                                          addMemberScreenController
                                                              .adharFrontSide
                                                              ?.value =
                                                              File(image.path);
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                        EdgeInsets.symmetric(
                                                          vertical: 2.w,
                                                          horizontal: 6.w,
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
                                                          "Camera".tr,
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            fontFamily: "PlusJakartaSansMedium",
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final XFile? image = await addMemberScreenController
                                                            .picker.pickImage(
                                                            source: ImageSource
                                                                .gallery,
                                                            imageQuality: 50);
                                                        Navigator.pop(context);
                                                        if (image != null) {
                                                          addMemberScreenController
                                                              .adharFrontSide
                                                              ?.value =
                                                              File(image.path);
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                        EdgeInsets.symmetric(
                                                          vertical: 2.w,
                                                          horizontal: 6.w,
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
                                                              "Gallery".tr,
                                                              style: TextStyle(
                                                                color: AppColors()
                                                                    .color5B6AEA,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                fontFamily: "PlusJakartaSansMedium",
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
                                    child: DottedBorder(
                                      color: AppColors().colorD7D7D7,
                                      strokeWidth: 2,
                                      dashPattern: [6, 3],
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(10),
                                      child: Center(
                                        child: Container(
                                          padding: EdgeInsets.all(2.w),
                                          child: Column(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/upload.svg",
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.fill,
                                              ),
                                              SizedBox(width: 2.w),
                                              CommonWidgets().commonText(
                                                text: "AadharCardFrontSide".tr,
                                                fontSize: 16.sp,
                                                fontColor:
                                                AppColors().colorD7D7D7,
                                                fontFamily:
                                                "PlusJakartaSansRegular",
                                                fontWeight: FontWeight.bold,
                                                textAlign: TextAlign.center,
                                              ),

                                              Obx(
                                                      () {
                                                    return addMemberScreenController
                                                        .adharFrontSide
                                                        ?.value == null
                                                        ? SizedBox(height: 24,)
                                                        : Icon(Icons.check,
                                                      color: Colors.green,);
                                                  }
                                              )
                                            ],
                                          ),
                                          // child: TextFormField(
                                          //   decoration: InputDecoration(
                                          //     disabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(
                                          //         color: AppColors().color787878,
                                          //       ),
                                          //     ),
                                          //     enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(
                                          //         color: AppColors().colorD7D7D7,
                                          //       ),
                                          //     ),
                                          //     focusedBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(
                                          //         color: AppColors().color5B6AEA,
                                          //       ),
                                          //     ),
                                          //     contentPadding: EdgeInsets.only(left: 10),
                                          //     border: const OutlineInputBorder(),
                                          //     hintText: "shubham47@gmail.com",
                                          //     hintStyle: TextStyle(
                                          //       fontSize: 16,
                                          //       fontFamily: "PlusJakartaSansRegular",
                                          //       fontWeight: FontWeight.w600,
                                          //     ),
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      Get.dialog(
                                        Dialog(
                                          backgroundColor: AppColors()
                                              .colorFFFFFF,
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
                                                  'SelectImageByBelowOptions'
                                                      .tr,
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
                                                        final XFile? image = await addMemberScreenController
                                                            .picker.pickImage(
                                                            source: ImageSource
                                                                .camera,
                                                            imageQuality: 50);
                                                        Navigator.pop(context);
                                                        if (image != null) {
                                                          addMemberScreenController
                                                              .adharBackSide
                                                              ?.value =
                                                              File(image.path);
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                        EdgeInsets.symmetric(
                                                          vertical: 2.w,
                                                          horizontal: 6.w,
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
                                                          "Camera".tr,
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            fontFamily: "PlusJakartaSansMedium",
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final XFile? image = await addMemberScreenController
                                                            .picker.pickImage(
                                                            source: ImageSource
                                                                .gallery,
                                                            imageQuality: 50);
                                                        Navigator.pop(context);
                                                        if (image != null) {
                                                          addMemberScreenController
                                                              .adharBackSide
                                                              ?.value =
                                                              File(image.path);
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                        EdgeInsets.symmetric(
                                                          vertical: 2.w,
                                                          horizontal: 6.w,
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
                                                              "Gallery".tr,
                                                              style: TextStyle(
                                                                color: AppColors()
                                                                    .color5B6AEA,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                fontFamily: "PlusJakartaSansMedium",
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

                                    child: DottedBorder(
                                      color: AppColors().colorD7D7D7,
                                      strokeWidth: 2,
                                      dashPattern: [6, 3],
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(10),
                                      child: Center(
                                        child: Container(
                                          padding: EdgeInsets.all(2.w),
                                          child: Column(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/upload.svg",
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.fill,
                                              ),
                                              SizedBox(width: 2.w),
                                              CommonWidgets().commonText(
                                                text: "AadharCardBackSide".tr,
                                                fontSize: 16.sp,
                                                fontColor:
                                                AppColors().colorD7D7D7,
                                                fontFamily:
                                                "PlusJakartaSansRegular",
                                                fontWeight: FontWeight.bold,
                                                textAlign: TextAlign.center,
                                              ),
                                              Obx(
                                                      () {
                                                    return addMemberScreenController
                                                        .adharBackSide
                                                        ?.value == null
                                                        ? SizedBox(height: 24,)
                                                        : Icon(Icons.check,
                                                      color: Colors.green,);
                                                  }
                                              )
                                            ],
                                          ),
                                          // child: TextFormField(
                                          //   decoration: InputDecoration(
                                          //     disabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(
                                          //         color: AppColors().color787878,
                                          //       ),
                                          //     ),
                                          //     enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(
                                          //         color: AppColors().colorD7D7D7,
                                          //       ),
                                          //     ),
                                          //     focusedBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(
                                          //         color: AppColors().color5B6AEA,
                                          //       ),
                                          //     ),
                                          //     contentPadding: EdgeInsets.only(left: 10),
                                          //     border: const OutlineInputBorder(),
                                          //     hintText: "shubham47@gmail.com",
                                          //     hintStyle: TextStyle(
                                          //       fontSize: 16,
                                          //       fontFamily: "PlusJakartaSansRegular",
                                          //       fontWeight: FontWeight.w600,
                                          //     ),
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: 3.w),

                            CommonWidgets().commonText(
                              text: "PanDetails".tr,
                              fontSize: 16.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 2.w),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      Get.dialog(
                                        Dialog(
                                          backgroundColor: AppColors()
                                              .colorFFFFFF,
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
                                                  'SelectImageByBelowOptions'
                                                      .tr,
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
                                                        final XFile? image = await addMemberScreenController
                                                            .picker.pickImage(
                                                            source: ImageSource
                                                                .camera,
                                                            imageQuality: 50);
                                                        Navigator.pop(context);
                                                        if (image != null) {
                                                          addMemberScreenController
                                                              .panImage
                                                              ?.value =
                                                              File(image.path);
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                        EdgeInsets.symmetric(
                                                          vertical: 2.w,
                                                          horizontal: 6.w,
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
                                                          "Camera".tr,
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            fontFamily: "PlusJakartaSansMedium",
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 2.w),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final XFile? image = await addMemberScreenController
                                                            .picker.pickImage(
                                                            source: ImageSource
                                                                .gallery,
                                                            imageQuality: 50);
                                                        Navigator.pop(context);
                                                        if (image != null) {
                                                          addMemberScreenController
                                                              .panImage
                                                              ?.value =
                                                              File(image.path);
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                        EdgeInsets.symmetric(
                                                          vertical: 2.w,
                                                          horizontal: 6.w,
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
                                                              "Gallery".tr,
                                                              style: TextStyle(
                                                                color: AppColors()
                                                                    .color5B6AEA,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                fontFamily: "PlusJakartaSansMedium",
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
                                    child: DottedBorder(
                                      color: AppColors().colorD7D7D7,
                                      strokeWidth: 2,
                                      dashPattern: [6, 3],
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(10),
                                      child: Center(
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/icons/upload.svg",
                                                    height: 30,
                                                    width: 30,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  CommonWidgets()
                                                      .commonText(
                                                    text: "UploadPanCard".tr,
                                                    fontSize: 14,
                                                    fontColor:
                                                    AppColors().colorD7D7D7,
                                                    fontFamily:
                                                    "PlusJakartaSansRegular",
                                                    fontWeight: FontWeight.bold,
                                                    textAlign: TextAlign.center,
                                                    overFlow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ],
                                              ),
                                              Obx(
                                                      () {
                                                    return addMemberScreenController
                                                        .panImage
                                                        ?.value == null
                                                        ? SizedBox(height: 24,)
                                                        : Icon(Icons.check,
                                                      color: Colors.green,);
                                                  }
                                              )
                                            ],
                                          ),
                                          // child: TextFormField(
                                          //   decoration: InputDecoration(
                                          //     disabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(
                                          //         color: AppColors().color787878,
                                          //       ),
                                          //     ),
                                          //     enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(
                                          //         color: AppColors().colorD7D7D7,
                                          //       ),
                                          //     ),
                                          //     focusedBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(
                                          //         color: AppColors().color5B6AEA,
                                          //       ),
                                          //     ),
                                          //     contentPadding: EdgeInsets.only(left: 10),
                                          //     border: const OutlineInputBorder(),
                                          //     hintText: "shubham47@gmail.com",
                                          //     hintStyle: TextStyle(
                                          //       fontSize: 16,
                                          //       fontFamily: "PlusJakartaSansRegular",
                                          //       fontWeight: FontWeight.w600,
                                          //     ),
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(
                                height: 4.w), Row(
                              children: [
                                CommonWidgets().commonText(
                                  text: "PanNumber".tr,
                                  fontSize: 16.sp,
                                  fontColor: AppColors().color1E1E1E,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                                CommonWidgets().commonText(
                                  text: " *",
                                  fontSize: 16.sp,
                                  fontColor: AppColors().colorFF0000,
                                  fontFamily: "PlusJakartaSansRegular",
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 2.w),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 42,
                                    child: TextFormField(
                                      controller: addMemberScreenController
                                          .panController.value,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                          RegExp(r'\s'),
                                        ),
                                      ],
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
                                        contentPadding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        border: const OutlineInputBorder(),
                                        // hintText: "GYH7GTF7JF",
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          color: AppColors().color1E1E1E
                                          ,
                                          fontFamily: "PlusJakartaSansRegular",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    // child: TextFormField(
                                    //   decoration: InputDecoration(
                                    //     disabledBorder: OutlineInputBorder(
                                    //       borderSide: BorderSide(
                                    //         color: AppColors().color787878,
                                    //       ),
                                    //     ),
                                    //     enabledBorder: OutlineInputBorder(
                                    //       borderSide: BorderSide(
                                    //         color: AppColors().colorD7D7D7,
                                    //       ),
                                    //     ),
                                    //     focusedBorder: OutlineInputBorder(
                                    //       borderSide: BorderSide(
                                    //         color: AppColors().color5B6AEA,
                                    //       ),
                                    //     ),
                                    //     contentPadding: EdgeInsets.only(left: 10),
                                    //     border: const OutlineInputBorder(),
                                    //     hintText: "shubham47@gmail.com",
                                    //     hintStyle: TextStyle(
                                    //       fontSize: 16,
                                    //       fontFamily: "PlusJakartaSansRegular",
                                    //       fontWeight: FontWeight.w600,
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 4.w),


                            Obx(
                                    () {
                                  return addMemberScreenController.bankImage
                                      ?.value ==
                                      null ? SizedBox() : Container(
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10.sp),
                                      border: Border.all(
                                        color: AppColors().colorD7D7D7,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(

                                              margin: EdgeInsets.all(1.w),
                                              decoration: BoxDecoration(
                                                color: AppColors().colorD7D7D7,
                                                borderRadius: BorderRadius
                                                    .circular(
                                                  10.sp,
                                                ),
                                                border: Border.all(
                                                  color: AppColors()
                                                      .colorD7D7D7,
                                                ),
                                              ),
                                              child: Image.file(
                                                  height: 15.w,
                                                  width: 20.w,
                                                  fit: BoxFit.fill,
                                                  addMemberScreenController
                                                      .bankImage.value!),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                CommonWidgets().commonText(
                                                  text: "Check/PassBook.jpg",
                                                  // text: "${addMemberScreenController
                                                  //     .bankImage.value?.path
                                                  //     .toString()}",
                                                  fontSize: 18.sp,
                                                  fontColor: AppColors()
                                                      .color1E1E1E,
                                                  fontFamily: "PlusJakartaSansMedium",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                // CommonWidgets().commonText(
                                                //   text: "1MB",
                                                //   fontSize: 18.sp,
                                                //   fontColor: AppColors()
                                                //       .color1E1E1E,
                                                //   fontFamily: "PlusJakartaSansMedium",
                                                //   fontWeight: FontWeight.bold,
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            addMemberScreenController
                                                .bankImage
                                                ?.value = null;
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: 2.w),
                                            child: SvgPicture.asset(
                                              "assets/icons/redDelete.svg",
                                              height: 30,
                                              width: 30,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            ),
                            SizedBox(height: 2.w,),
                            Obx(
                                    () {
                                  return addMemberScreenController
                                      .adharFrontSide
                                      ?.value ==
                                      null ? SizedBox() : Container(
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10.sp),
                                      border: Border.all(
                                        color: AppColors().colorD7D7D7,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(

                                              margin: EdgeInsets.all(1.w),
                                              decoration: BoxDecoration(
                                                color: AppColors().colorD7D7D7,
                                                borderRadius: BorderRadius
                                                    .circular(
                                                  10.sp,
                                                ),
                                                border: Border.all(
                                                  color: AppColors()
                                                      .colorD7D7D7,
                                                ),
                                              ),
                                              child: Image.file(
                                                  height: 15.w,
                                                  width: 20.w,
                                                  fit: BoxFit.fill,
                                                  addMemberScreenController
                                                      .adharFrontSide.value!),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                CommonWidgets().commonText(
                                                  text: "Adhar front-side.jpg",
                                                  // text: "${addMemberScreenController
                                                  //     .bankImage.value?.path
                                                  //     .toString()}",
                                                  fontSize: 18.sp,
                                                  fontColor: AppColors()
                                                      .color1E1E1E,
                                                  fontFamily: "PlusJakartaSansMedium",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                // CommonWidgets().commonText(
                                                //   text: "1MB",
                                                //   fontSize: 18.sp,
                                                //   fontColor: AppColors()
                                                //       .color1E1E1E,
                                                //   fontFamily: "PlusJakartaSansMedium",
                                                //   fontWeight: FontWeight.bold,
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            addMemberScreenController
                                                .adharFrontSide
                                                ?.value = null;
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: 2.w),
                                            child: SvgPicture.asset(
                                              "assets/icons/redDelete.svg",
                                              height: 30,
                                              width: 30,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            ),
                            SizedBox(height: 2.w,),
                            Obx(
                                    () {
                                  return addMemberScreenController.adharBackSide
                                      ?.value ==
                                      null ? SizedBox() : Container(
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10.sp),
                                      border: Border.all(
                                        color: AppColors().colorD7D7D7,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(

                                              margin: EdgeInsets.all(1.w),
                                              decoration: BoxDecoration(
                                                color: AppColors().colorD7D7D7,
                                                borderRadius: BorderRadius
                                                    .circular(
                                                  10.sp,
                                                ),
                                                border: Border.all(
                                                  color: AppColors()
                                                      .colorD7D7D7,
                                                ),
                                              ),
                                              child: Image.file(
                                                  height: 15.w,
                                                  width: 20.w,
                                                  fit: BoxFit.fill,
                                                  addMemberScreenController
                                                      .adharBackSide.value!),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                CommonWidgets().commonText(
                                                  text: "Adhar back-side.jpg",
                                                  // text: "${addMemberScreenController
                                                  //     .bankImage.value?.path
                                                  //     .toString()}",
                                                  fontSize: 18.sp,
                                                  fontColor: AppColors()
                                                      .color1E1E1E,
                                                  fontFamily: "PlusJakartaSansMedium",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                // CommonWidgets().commonText(
                                                //   text: "1MB",
                                                //   fontSize: 18.sp,
                                                //   fontColor: AppColors()
                                                //       .color1E1E1E,
                                                //   fontFamily: "PlusJakartaSansMedium",
                                                //   fontWeight: FontWeight.bold,
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            addMemberScreenController
                                                .adharBackSide
                                                ?.value = null;
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: 2.w),
                                            child: SvgPicture.asset(
                                              "assets/icons/redDelete.svg",
                                              height: 30,
                                              width: 30,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            ),
                            SizedBox(height: 2.w,),
                            Obx(
                                    () {
                                  return addMemberScreenController.panImage
                                      ?.value ==
                                      null ? SizedBox() : Container(
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10.sp),
                                      border: Border.all(
                                        color: AppColors().colorD7D7D7,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(

                                              margin: EdgeInsets.all(1.w),
                                              decoration: BoxDecoration(
                                                color: AppColors().colorD7D7D7,
                                                borderRadius: BorderRadius
                                                    .circular(
                                                  10.sp,
                                                ),
                                                border: Border.all(
                                                  color: AppColors()
                                                      .colorD7D7D7,
                                                ),
                                              ),
                                              child: Image.file(
                                                  height: 15.w,
                                                  width: 20.w,
                                                  fit: BoxFit.fill,
                                                  addMemberScreenController
                                                      .panImage.value!),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                CommonWidgets().commonText(
                                                  text: "Pan-image.jpg",
                                                  // text: "${addMemberScreenController
                                                  //     .bankImage.value?.path
                                                  //     .toString()}",
                                                  fontSize: 18.sp,
                                                  fontColor: AppColors()
                                                      .color1E1E1E,
                                                  fontFamily: "PlusJakartaSansMedium",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                // CommonWidgets().commonText(
                                                //   text: "1MB",
                                                //   fontSize: 18.sp,
                                                //   fontColor: AppColors()
                                                //       .color1E1E1E,
                                                //   fontFamily: "PlusJakartaSansMedium",
                                                //   fontWeight: FontWeight.bold,
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            addMemberScreenController
                                                .panImage
                                                ?.value = null;
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: 2.w),
                                            child: SvgPicture.asset(
                                              "assets/icons/redDelete.svg",
                                              height: 30,
                                              width: 30,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            ),

                            SizedBox(height: 25.w),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () async {
              print(addMemberScreenController.storedCategory.value.toString());
              print(addMemberScreenController.storedsubDustrictId.value
                  .toString());


              String email = addMemberScreenController.emailAddress.value.text
                  .trim();

              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              String bloodGroup = addMemberScreenController
                  .bloodGroup
                  .value
                  .text
                  .trim();

              // ✅ Matches A+, A-, B+, B-, O+, O-, AB+, AB-
              final bloodGroupRegex = RegExp(r'^(A|B|AB|O)[+-]$');
              if (addMemberScreenController.profileImage.value == null) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please select image",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.fullName.value.text
                  .toString()
                  .isEmpty) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please enter valid full name",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.userName.value.text
                  .toString()
                  .isEmpty) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please enter valid user name",
                  Colors.red,
                  Colors.white,
                );
              } else if (email.isEmpty) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please enter your email address",
                  Colors.red,
                  Colors.white,
                );
              } else if (!emailRegex.hasMatch(email)) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please enter a valid email address",
                  Colors.red,
                  Colors.white,
                );
              } else
              if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{6,}$')
                  .hasMatch(
                  addMemberScreenController.password.value.text.toString())) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Password must be at least 6 characters long and include letters and numbers Abc@123.",
                  Colors.red,
                  Colors.white,
                );
              }
              else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{6,}$')
                  .hasMatch(addMemberScreenController.confirmPassword.value.text
                  .toString())) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Confirm password must be at least 6 characters long and include letters and numbers Abc@123.",
                  Colors.red,
                  Colors.white,
                );
              }
              else if (addMemberScreenController.password.value.text
                  .toString() !=
                  addMemberScreenController.confirmPassword.value.text
                      .toString()) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Password and confirm password should be same",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.confirmPassword.value.text
                  .toString() !=
                  addMemberScreenController.password.value.text.toString()) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Password and confirm password should be same",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.phoneNumber.value.text
                  .toString()
                  .length >
                  10 ||
                  addMemberScreenController.phoneNumber.value.text
                      .toString()
                      .length <
                      10) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please enter a valid phone number",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController
                  .emergencyMobileNumber
                  .value
                  .text
                  .toString()
                  .length >
                  10 ||
                  addMemberScreenController.emergencyMobileNumber.value.text
                      .toString()
                      .length <
                      10) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please enter a valid emergency phone number",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.birthDate.value.text
                  .toString()
                  .isEmpty) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please select valid birth date",
                  Colors.red,
                  Colors.white,
                );
              } else if (bloodGroup.isEmpty) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please enter your blood group",
                  Colors.red,
                  Colors.white,
                );
              } else if (!bloodGroupRegex.hasMatch(bloodGroup.toUpperCase())) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please enter a valid blood group (e.g. A+, B-, O+, AB-)",
                  Colors.red,
                  Colors.white,
                );
              } else
              if (addMemberScreenController.storedsubDustrictId.value == null) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please select town or taluka",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.personAddress.value.text
                  .toString()
                  .isEmpty) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please enter valid address",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.bankName.value.text
                  .toString()
                  .isEmpty) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please enter valid bank name",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.branchName.value.text
                  .toString()
                  .isEmpty) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please enter valid branch name",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.bankAccountHolderName.value
                  .text
                  .toString()
                  .isEmpty) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please enter valid bank account holder name",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.bankAccountNumber.value.text
                  .toString()
                  .length < 9 ||
                  addMemberScreenController.bankAccountNumber.value.text
                      .toString()
                      .length > 18) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Account number must be between 9 and 18 digits.",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.ifscCode.value.text
                  .toString()
                  .length < 11 || addMemberScreenController.ifscCode.value.text
                  .toString()
                  .length > 11) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Ifsc code must be 11 digit",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.bankImage.value == null) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please select bank image",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.adharNumber.value.text
                  .toString()
                  .length < 12 ||
                  addMemberScreenController.adharNumber.value.text
                      .toString()
                      .length > 12) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please enter 12 digit aadhar number",
                  Colors.red,
                  Colors.white,
                );
              }


              else if (addMemberScreenController.adharFrontSide.value == null) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please select adharcard front side",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.adharBackSide.value ==
                  null) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please select adharcard back side",
                  Colors.red,
                  Colors.white,
                );
              } else if (addMemberScreenController.panImage.value == null) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "Please select pan image",
                  Colors.red,
                  Colors.white,
                );
              }
              else if (addMemberScreenController.panController.value.text
                  .toString()
                  .length > 10 ||
                  addMemberScreenController.panController.value.text
                      .toString()
                      .length < 10) {
                CommonWidgets().showSnackBar(
                  "Alert",
                  "PAN number must be exactly 10 characters.",
                  Colors.red,
                  Colors.white,
                );
              } else {
                addMemberScreenController.addTeamMember(context);
              }

              print({
                "sub_district_id": addMemberScreenController.storedCategory
                    .value == 2
                    ? addMemberScreenController.storedsubDustrictId.value
                    .toString()
                    : "",
                "town_id": addMemberScreenController.storedCategory.value == 1
                    ? addMemberScreenController.storedsubDustrictId.value
                    .toString()
                    : "",
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 5.w, right: 5.w),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppColors().color5B6AEA,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Center(
                child: CommonWidgets().commonText(
                  text: "Save".tr,
                  fontSize: 16.sp,
                  fontColor: AppColors().colorFFFFFF,
                  fontFamily: "PlusJakartaSansRegular",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
