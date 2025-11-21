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
                          text: "Team Detail",
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
              ClipRRect(
                borderRadius: BorderRadius.circular(20.w),
                child: Image.network(
                  height: 40.w,
                  width: 40.w,
                  fit: BoxFit.fill,
                  "${widget.teamDetail?.profilePhoto.toString()}",
                  errorBuilder: (context, error, stackTrace) =>
                      SvgPicture.asset(
                        "assets/icons/profile.svg",
                        height: 20.w,
                        width: 20.w,
                        fit: BoxFit.fill,
                      ),
                ),
              ),
              SizedBox(height: 1.w),
              CommonWidgets().commonText(
                text: "Full Name :- ${widget.teamDetail?.fullname.toString()}",
                fontSize: 18.sp,
                fontColor: AppColors().color1E1E1E,
                fontFamily: "PlusJakartaSansRegular",
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 1.w),
              CommonWidgets().commonText(
                text:
                    "Status :- ${widget.teamDetail?.isVerified == 0
                        ? "Pending"
                        : widget.teamDetail?.isVerified == 1
                        ? "Approval"
                        : widget.teamDetail?.isVerified == 2
                        ? "Rejected"
                        : ""}",
                fontSize: 18.sp,
                fontColor: AppColors().color1E1E1E,
                fontFamily: "PlusJakartaSansRegular",
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 1.w),
              Align(
                alignment: Alignment.center,
                child: CommonWidgets().commonText(
                  text:
                      "Rejection :- ${widget.teamDetail?.rejectionReason ?? "N/A"}",
                  fontSize: 18.sp,
                  fontColor: AppColors().color1E1E1E,
                  fontFamily: "PlusJakartaSansRegular",
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 1.w),
              SizedBox(height: 1.w),
              widget.teamDetail?.assignedVillages?.length == 0
                  ? SizedBox()
                  : Expanded(
                      child: Column(
                        children: [
                          CommonWidgets().commonText(
                            text: "Assigned Village",
                            fontSize: 18.sp,
                            fontColor: AppColors().color1E1E1E,
                            fontFamily: "PlusJakartaSansRegular",
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            line: TextDecoration.underline,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  widget.teamDetail?.assignedVillages?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    top: 4.w,
                                    left: 2.w,
                                    right: 2.w,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: CommonWidgets().commonText(
                                      text:
                                          "(${index + 1}). ${widget.teamDetail?.assignedVillages?[index].name}",
                                      fontSize: 17.sp,
                                      fontColor: AppColors().color1E1E1E,
                                      fontFamily: "PlusJakartaSansRegular",
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 1.w),
            ],
          ),
        ),
      ),
    );
  }
}
