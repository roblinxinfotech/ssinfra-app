import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/editProfileScreenController.dart';
import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileScreenController editProfileScreenController = Get.put(
    EditProfileScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().colorE1E5FD,
      body: Obx(() {
        return SafeArea(
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Row(
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
                              Container(height: 25.sp, width: 25.sp),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  CommonWidgets().commonText(
                                    text: "EditProfile".tr,
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
                            children: [Container(height: 25.sp, width: 25.sp)],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.w),
                    GestureDetector(
                      onTap: () async {
                        // final XFile? image = await editProfileScreenController
                        //     .picker
                        //     .pickImage(
                        //       source: ImageSource.camera,
                        //       imageQuality: 50,
                        //     );
                        // if (image != null) {
                        //   editProfileScreenController.profileImage?.value =
                        //       File(image.path);
                        // }
                        // print(image?.path);
                        // print(
                        //   editProfileScreenController.profileImage?.value?.path,
                        // );

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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'SelectImageByBelowOptions'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "PlusJakartaSansRegular",
                                    ),
                                  ),
                                  SizedBox(height: 4.w),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          final XFile? image =
                                              await editProfileScreenController
                                                  .picker
                                                  .pickImage(
                                                    source: ImageSource.camera,
                                                    imageQuality: 50,
                                                  );
                                          Navigator.pop(context);
                                          if (image != null) {
                                            editProfileScreenController
                                                .profileImage
                                                ?.value = File(
                                              image.path,
                                            );
                                          }
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
                                              color: AppColors().color5B6AEA,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              1.w,
                                            ),
                                          ),
                                          child: Text(
                                            "Camera".tr,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily:
                                                  "PlusJakartaSansMedium",
                                              color: AppColors().color5B6AEA,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      GestureDetector(
                                        onTap: () async {
                                          final XFile? image =
                                              await editProfileScreenController
                                                  .picker
                                                  .pickImage(
                                                    source: ImageSource.gallery,
                                                    imageQuality: 50,
                                                  );
                                          Navigator.pop(context);
                                          if (image != null) {
                                            editProfileScreenController
                                                .profileImage
                                                ?.value = File(
                                              image.path,
                                            );
                                          }
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
                                              color: AppColors().color5B6AEA,
                                            ),
                                            borderRadius: BorderRadius.circular(
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
                                                "Gallery".tr,
                                                style: TextStyle(
                                                  color:
                                                      AppColors().color5B6AEA,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      "PlusJakartaSansMedium",
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
                      child: Container(
                        width: 100.w,
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          border: Border.all(color: AppColors().colorFFFFFF),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(() {
                              return Stack(
                                children: [
                                  editProfileScreenController
                                              .profileImage
                                              ?.value !=
                                          null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                          child: Image.file(
                                            height: 25.w,
                                            width: 25.w,
                                            editProfileScreenController
                                                .profileImage!
                                                .value!,

                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                          child: Image.network(
                                            height: 25.w,
                                            width: 25.w,
                                            "${editProfileScreenController.profileModel.value?.data?.profilePhoto.toString()}",
                                            fit: BoxFit.fill,
                                            errorBuilder:
                                                (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) => Image.asset(
                                                  "assets/icons/placeHolder.png",
                                                  height: 20.w,
                                                  width: 20.w,
                                                  fit: BoxFit.fill,
                                                ),
                                          ),
                                        ),

                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: SvgPicture.asset(
                                      "assets/icons/camera.svg",
                                      height: 8.w,
                                      width: 8.w,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              );
                            }),
                            SizedBox(height: 4.w),
                            CommonWidgets().commonText(
                              text:
                                  "${editProfileScreenController.profileModel.value?.data?.username.toString()}",

                              fontSize: 18.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansMedium",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 1.w),
                            CommonWidgets().commonText(
                              text:
                                  "${editProfileScreenController.profileModel.value?.data?.email.toString()}",
                              fontSize: 18.sp,
                              fontColor: AppColors().color5B6AEA,
                              fontFamily: "PlusJakartaSansRegular",
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 5.w),
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        border: Border.all(color: AppColors().colorFFFFFF),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidgets().commonText(
                            text: "FullName".tr,
                            fontSize: 16.sp,
                            fontColor: AppColors().color1E1E1E,
                            fontFamily: "PlusJakartaSansRegular",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 1.w),
                          Container(
                            height: 40,
                            child: TextFormField(
                              controller:
                                  editProfileScreenController.fullName.value,
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
                                hintText: "Shubham Joshi",
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
                            text: "EmailAddress".tr,
                            fontSize: 16.sp,
                            fontColor: AppColors().color1E1E1E,
                            fontFamily: "PlusJakartaSansRegular",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 1.w),
                          Container(
                            height: 40,
                            child: TextFormField(
                              controller: editProfileScreenController
                                  .emailAddress
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
                                hintText: "shubham47@gmail.com",
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
                            text: "PhoneNumber".tr,
                            fontSize: 16.sp,
                            fontColor: AppColors().color1E1E1E,
                            fontFamily: "PlusJakartaSansRegular",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 1.w),
                          Container(
                            height: 40,
                            child: TextFormField(
                              controller:
                                  editProfileScreenController.phoneNumber.value,
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
                                hintText: "9973432678",
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
                            text: "DateOfBirth".tr,
                            fontSize: 16.sp,
                            fontColor: AppColors().color1E1E1E,
                            fontFamily: "PlusJakartaSansRegular",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 1.w),
                          Container(
                            height: 40,
                            child: TextFormField(
                              readOnly: true,
                              controller:
                                  editProfileScreenController.birthDate.value,
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
                                      lastDate:
                                          DateTime.now(), // Latest selectable date
                                    );
                                    if (picked != null) {
                                      editProfileScreenController
                                              .birthDate
                                              .value
                                              .text =
                                          "${picked?.year.toString()}-${picked?.month.toString()}-${picked?.day.toString()}";
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                      "assets/icons/calendar.svg",
                                    ),
                                  ),
                                ),
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
                                hintText: "2024-12-12",
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
                              value:
                                  editProfileScreenController.gender.value ==
                                      "male"
                                  ? 1
                                  : editProfileScreenController.gender.value ==
                                        "female"
                                  ? 2
                                  : 3,
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
                                  editProfileScreenController.gender.value =
                                      "male";
                                }
                                if (v == 2) {
                                  editProfileScreenController.gender.value =
                                      "female";
                                }
                                if (v == 3) {
                                  editProfileScreenController.gender.value =
                                      "other";
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 6.w),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Container(
          width: 100.w,
          color: Colors.white.withValues(alpha: 0.6),
          child: Padding(
            padding: EdgeInsets.only(top: 2.w, bottom: 0.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    String email = editProfileScreenController
                        .emailAddress
                        .value
                        .text
                        .trim();

                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );

                    if (editProfileScreenController.fullName.value.text
                        .toString()
                        .isEmpty) {
                      CommonWidgets().showSnackBar(
                        "Alert",
                        "Please enter valid full name",
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
                    } else if (editProfileScreenController
                                .phoneNumber
                                .value
                                .text
                                .toString()
                                .length >
                            10 ||
                        editProfileScreenController.phoneNumber.value.text
                                .toString()
                                .length <
                            10) {
                      CommonWidgets().showSnackBar(
                        "Alert",
                        "Please enter a valid phone number",
                        Colors.red,
                        Colors.white,
                      );
                    } else if (editProfileScreenController.birthDate.value.text
                        .toString()
                        .isEmpty) {
                      CommonWidgets().showSnackBar(
                        "Alert",
                        "Please select valid birth date",
                        Colors.red,
                        Colors.white,
                      );
                    } else {
                      editProfileScreenController.editProfile(context);
                    }
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
          ),
        ),
      ),
    );
  }
}
