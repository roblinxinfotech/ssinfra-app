import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/model/teamListModel.dart';

import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';

class TeamDetailScreen extends StatefulWidget {
  TeamList? teamDetail;

  TeamDetailScreen({super.key, this.teamDetail});

  @override
  State<TeamDetailScreen> createState() => _TeamDetailScreenState();
}

class _TeamDetailScreenState extends State<TeamDetailScreen> {
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
                          text: "TeamDetail".tr,
                          fontSize: 18.sp,
                          fontColor: AppColors().color1E1E1E,
                          fontFamily: "PlusJakartaSansMedium",
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Container(height: 25.sp, width: 25.sp),
                  ],
                ),
              ),
              SizedBox(height: 5.w),
              Expanded(
                child: ListView(
                  children: [
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(20.w),
                    //   child: Image.network(
                    //     height: 40.w,
                    //     width: 40.w,
                    //     fit: BoxFit.fill,
                    //     "${widget.teamDetail?.profilePhoto.toString()}",
                    //     errorBuilder: (context, error, stackTrace) =>
                    //         SvgPicture.asset(
                    //           "assets/icons/profile.svg",
                    //           height: 20.w,
                    //           width: 20.w,
                    //           fit: BoxFit.fill,
                    //         ),
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 2.w, left: 2.w, right: 2.w),
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
                                  // Get.dialog(
                                  //   Dialog(
                                  //     backgroundColor: AppColors().colorFFFFFF,
                                  //     child: Padding(
                                  //       padding: EdgeInsets.only(
                                  //         top: 8.w,
                                  //         bottom: 4.w,
                                  //         left: 2.w,
                                  //         right: 2.w,
                                  //       ),
                                  //       child: Column(
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             'Select image by below options.',
                                  //             textAlign: TextAlign.center,
                                  //             style: TextStyle(
                                  //               fontSize: 18.sp,
                                  //               fontWeight: FontWeight.bold,
                                  //               fontFamily: "PlusJakartaSansRegular",
                                  //             ),
                                  //           ),
                                  //           SizedBox(height: 4.w),
                                  //
                                  //           Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               GestureDetector(
                                  //                 onTap: () async {},
                                  //                 child: Container(
                                  //                   padding: EdgeInsets.symmetric(
                                  //                     vertical: 2.w,
                                  //                     horizontal: 6.w,
                                  //                   ),
                                  //                   alignment: Alignment.center,
                                  //                   decoration: BoxDecoration(
                                  //                     color: AppColors().color5B6AEA
                                  //                         .withValues(alpha: 0.3),
                                  //                     border: Border.all(
                                  //                       color:
                                  //                           AppColors().color5B6AEA,
                                  //                     ),
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(1.w),
                                  //                   ),
                                  //                   child: Text(
                                  //                     "Camera",
                                  //                     style: TextStyle(
                                  //                       fontSize: 16.sp,
                                  //                       fontWeight: FontWeight.w600,
                                  //                       fontFamily:
                                  //                           "PlusJakartaSansMedium",
                                  //                       color:
                                  //                           AppColors().color5B6AEA,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               SizedBox(width: 2.w),
                                  //               GestureDetector(
                                  //                 onTap: () async {},
                                  //                 child: Container(
                                  //                   padding: EdgeInsets.symmetric(
                                  //                     vertical: 2.w,
                                  //                     horizontal: 6.w,
                                  //                   ),
                                  //                   alignment: Alignment.center,
                                  //                   decoration: BoxDecoration(
                                  //                     color: AppColors().color5B6AEA
                                  //                         .withValues(alpha: 0.3),
                                  //                     border: Border.all(
                                  //                       color:
                                  //                           AppColors().color5B6AEA,
                                  //                     ),
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(1.w),
                                  //                   ),
                                  //
                                  //                   child: Column(
                                  //                     mainAxisAlignment:
                                  //                         MainAxisAlignment.center,
                                  //                     crossAxisAlignment:
                                  //                         CrossAxisAlignment.center,
                                  //                     children: [
                                  //                       Text(
                                  //                         "Gallery",
                                  //                         style: TextStyle(
                                  //                           color: AppColors()
                                  //                               .color5B6AEA,
                                  //                           fontWeight:
                                  //                               FontWeight.w400,
                                  //                           fontFamily:
                                  //                               "PlusJakartaSansMedium",
                                  //                           fontSize: 16.sp,
                                  //                         ),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // );

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
                                child: Container(
                                  margin: EdgeInsets.all(2.w),
                                  child: Container(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors().color787878
                                            .withValues(alpha: 0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        child: Center(
                                          child: Image.network(
                                            "${widget.teamDetail?.profilePhoto.toString()}",
                                            height: 25.w,
                                            width: 25.w,
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
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.w),

                    Container(
                      margin: EdgeInsets.only(top: 2.w, left: 2.w, right: 2.w),
                      padding: EdgeInsets.only(top: 4.w, left: 2.w, right: 2.w),
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
                            fontFamily: "PlusJakartaSansRegular",
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonWidgets().commonText(
                                text: "FullName".tr,
                                fontSize: 18.sp,
                                fontColor: AppColors().color666666,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                              Flexible(
                                child: CommonWidgets().commonText(
                                  text:
                                      "${widget.teamDetail?.fullname.toString()}",
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
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonWidgets().commonText(
                                text: "EmailAddress".tr,
                                fontSize: 18.sp,
                                fontColor: AppColors().color666666,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                              Flexible(
                                child: CommonWidgets().commonText(
                                  text:
                                      "${widget.teamDetail?.email.toString()}",
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
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonWidgets().commonText(
                                text: "PhoneNumber".tr,
                                fontSize: 18.sp,
                                fontColor: AppColors().color666666,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                              Flexible(
                                child: CommonWidgets().commonText(
                                  text:
                                      "${widget.teamDetail?.mobile.toString()}",
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
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonWidgets().commonText(
                                text: "EmergencyMobile".tr,
                                fontSize: 18.sp,
                                fontColor: AppColors().color666666,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                              Flexible(
                                child: CommonWidgets().commonText(
                                  text:
                                      "${widget.teamDetail?.emergencyMobile ?? "N/A"}",
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
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonWidgets().commonText(
                                text: "DateOfBirth".tr,
                                fontSize: 18.sp,
                                fontColor: AppColors().color666666,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                              Flexible(
                                child: CommonWidgets().commonText(
                                  text: "${widget.teamDetail?.dob ?? "N/A"}",
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
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      "${widget.teamDetail?.bloodGroup ?? "N/A"}",
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
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  text: "${widget.teamDetail?.gender ?? "N/A"}",
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
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonWidgets().commonText(
                                text: "Address".tr,
                                fontSize: 18.sp,
                                fontColor: AppColors().color666666,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                              Flexible(
                                child: CommonWidgets().commonText(
                                  text:
                                      "${widget.teamDetail?.address ?? "N/A"}",
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
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonWidgets().commonText(
                                text: "Status".tr,
                                fontSize: 18.sp,
                                fontColor: AppColors().color666666,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                              Flexible(
                                child: CommonWidgets().commonText(
                                  text:
                                      "${widget.teamDetail?.isVerified == 0
                                          ? "Pending"
                                          : widget.teamDetail?.isVerified == 1
                                          ? "Approved"
                                          : widget.teamDetail?.isVerified == 2
                                          ? "Rejected"
                                          : ""}",
                                  fontSize: 18.sp,
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
                          SizedBox(height: 4.w),
                          widget.teamDetail?.isVerified == 2
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonWidgets().commonText(
                                          text: "Reason".tr,
                                          fontSize: 18.sp,
                                          fontColor: AppColors().color666666,
                                          fontFamily: "PlusJakartaSansRegular",
                                          fontWeight: FontWeight.w600,
                                        ),
                                        Flexible(
                                          child: CommonWidgets().commonText(
                                            text:
                                                "${widget.teamDetail?.rejectionReason}",
                                            fontSize: 18.sp,
                                            fontColor: AppColors().color1E1E1E,
                                            fontFamily:
                                                "PlusJakartaSansRegular",
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
                                    SizedBox(height: 5.w),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2.w, left: 2.w, right: 2.w),
                      padding: EdgeInsets.only(top: 4.w, left: 2.w, right: 2.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.w),
                        color: AppColors().colorFFFFFF.withValues(alpha: 0.9),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidgets().commonText(
                            text: "BankInformation".tr,
                            fontSize: 18.sp,
                            fontColor: AppColors().color1E1E1E,
                            fontFamily: "PlusJakartaSansRegular",
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonWidgets().commonText(
                                text: "BankName".tr,
                                fontSize: 18.sp,
                                fontColor: AppColors().color666666,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                              Flexible(
                                child: CommonWidgets().commonText(
                                  text:
                                      "${widget.teamDetail?.bankName.toString()}",
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
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonWidgets().commonText(
                                text: "BranchName".tr,
                                fontSize: 18.sp,
                                fontColor: AppColors().color666666,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                              Flexible(
                                child: CommonWidgets().commonText(
                                  text:
                                      "${widget.teamDetail?.branchName.toString()}",
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
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonWidgets().commonText(
                                text: "AccountHolderName".tr,
                                fontSize: 18.sp,
                                fontColor: AppColors().color666666,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                              Flexible(
                                child: CommonWidgets().commonText(
                                  text:
                                      "${widget.teamDetail?.accountHolderName.toString()}",
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
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonWidgets().commonText(
                                text: "AccountNo".tr,
                                fontSize: 18.sp,
                                fontColor: AppColors().color666666,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                              Flexible(
                                child: CommonWidgets().commonText(
                                  text:
                                      "${widget.teamDetail?.accountNumber ?? "N/A"}",
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
                          SizedBox(height: 4.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonWidgets().commonText(
                                text: "IFSCCode".tr,
                                fontSize: 18.sp,
                                fontColor: AppColors().color666666,
                                fontFamily: "PlusJakartaSansRegular",
                                fontWeight: FontWeight.w600,
                              ),
                              Flexible(
                                child: CommonWidgets().commonText(
                                  text:
                                      "${widget.teamDetail?.ifscCode ?? "N/A"}",
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
                          SizedBox(height: 4.w),
                          CommonWidgets().commonText(
                            text: "SavePhotos".tr,
                            fontSize: 18.sp,
                            fontColor: AppColors().color1E1E1E,
                            fontFamily: "PlusJakartaSansRegular",
                            fontWeight: FontWeight.w600,
                          ),

                          SizedBox(height: 5.w),
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: InteractiveViewer(
                                  panEnabled: true,
                                  minScale: 1,
                                  maxScale: 4,
                                  child: Image.network(
                                    height: 60.w,
                                    width: 100.w,
                                    "${widget.teamDetail?.panFile?.toString()}",
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
                              ),
                              SizedBox(width: 2.w,height: 2.w,),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: InteractiveViewer(
                                  panEnabled: true,
                                  minScale: 1,
                                  maxScale: 4,
                                  child: Image.network(
                                    height: 60.w,
                                    width: 100.w,
                                    "${widget.teamDetail?.aadharFront?.toString()}",
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
                              ),
                            ],
                          ),
                          SizedBox(height: 2.w),
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: InteractiveViewer(
                                  panEnabled: true,
                                  minScale: 1,
                                  maxScale: 4,
                                  child: Image.network(
                                    height: 60.w,
                                    width: 100.w,
                                    "${widget.teamDetail?.bankProof.toString()}",
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
                              ),
                              SizedBox(width: 2.w,height: 2.w,),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: InteractiveViewer(
                                  panEnabled: true,
                                  minScale: 1,
                                  maxScale: 4,
                                  child: Image.network(
                                    height: 60.w,
                                    width: 100.w,
                                    "${widget.teamDetail?.aadharBack?.toString()}",
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
                              ),
                            ],
                          ),
                          SizedBox(height: 5.w),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
//
//
//
//
//
//
//
//
//
//
//
//
//
// SizedBox(height: 1.w),
// Align(
// alignment: Alignment.center,
// child: CommonWidgets().commonText(
// text:
// "Rejection :- ${widget.teamDetail?.rejectionReason ?? "N/A"}",
// fontSize: 18.sp,
// fontColor: AppColors().color1E1E1E,
// fontFamily: "PlusJakartaSansRegular",
// fontWeight: FontWeight.w600,
// textAlign: TextAlign.center,
// ),
// ),
// SizedBox(height: 1.w),
// SizedBox(height: 1.w),
// widget.teamDetail?.subDistrictId != null
// ? Expanded(
// child: Column(
// children: [
// CommonWidgets().commonText(
// text: "Assigned Village",
// fontSize: 18.sp,
// fontColor: AppColors().color1E1E1E,
// fontFamily: "PlusJakartaSansRegular",
// fontWeight: FontWeight.w600,
// textAlign: TextAlign.center,
// line: TextDecoration.underline,
// ),
// Expanded(
// child: ListView.builder(
// itemCount: widget
//     .teamDetail
//     ?.assignedVillages
//     ?.length,
// itemBuilder: (context, index) {
// return Padding(
// padding: EdgeInsets.only(
// top: 4.w,
// left: 2.w,
// right: 2.w,
// ),
// child: Align(
// alignment: Alignment.centerLeft,
// child: CommonWidgets().commonText(
// text:
// "(${index + 1}). ${widget.teamDetail?.assignedVillages?[index].name}",
// fontSize: 17.sp,
// fontColor:
// AppColors().color1E1E1E,
// fontFamily:
// "PlusJakartaSansRegular",
// fontWeight: FontWeight.w600,
// textAlign: TextAlign.start,
// ),
// ),
// );
// },
// ),
// ),
// ],
// ),
// )
//     : widget.teamDetail?.townId != null
// ? Expanded(
// child: Column(
// children: [
// CommonWidgets().commonText(
// text: "Assigned Wards",
// fontSize: 18.sp,
// fontColor: AppColors().color1E1E1E,
// fontFamily: "PlusJakartaSansRegular",
// fontWeight: FontWeight.w600,
// textAlign: TextAlign.center,
// line: TextDecoration.underline,
// ),
// Expanded(
// child: ListView.builder(
// itemCount: widget
//     .teamDetail
//     ?.assignedWards
//     ?.length,
// itemBuilder: (context, index) {
// return Padding(
// padding: EdgeInsets.only(
// top: 4.w,
// left: 2.w,
// right: 2.w,
// ),
// child: Align(
// alignment: Alignment.centerLeft,
// child: CommonWidgets().commonText(
// text:
// "(${index + 1}). ${widget.teamDetail?.assignedWards?[index].name}",
// fontSize: 17.sp,
// fontColor:
// AppColors().color1E1E1E,
// fontFamily:
// "PlusJakartaSansRegular",
// fontWeight: FontWeight.w600,
// textAlign: TextAlign.start,
// ),
// ),
// );
// },
// ),
// ),
// ],
// ),
// )
//     : SizedBox(height: 1.w),
