import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../utils/appColors.dart';
import '../utils/commonWidgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
                        children: [
                          Image.asset(
                            "assets/icons/backWard.png",
                            height: 25.sp,
                            width: 25.sp,
                            fit: BoxFit.contain,
                          ),
                          Container(height: 25.sp, width: 25.sp),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              CommonWidgets().commonText(
                                text: "EDIT PROFILE",
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
                Container(
                  width: 100.w,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    border: Border.all(color: AppColors().colorFFFFFF),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              height: 25.w,
                              width: 25.w,
                              "assets/icons/personTest.png",
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
                      ),
                      SizedBox(height: 4.w),
                      CommonWidgets().commonText(
                        text: "Shubham Joshi",
                        fontSize: 18.sp,
                        fontColor: AppColors().color1E1E1E,
                        fontFamily: "PlusJakartaSansMedium",
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 1.w),
                      CommonWidgets().commonText(
                        text: "shubham47@gmail.com",
                        fontSize: 18.sp,
                        fontColor: AppColors().color5B6AEA,
                        fontFamily: "PlusJakartaSansRegular",
                        fontWeight: FontWeight.w400,
                      ),
                    ],
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
                        text: "Full Name",
                        fontSize: 16.sp,
                        fontColor: AppColors().color1E1E1E,
                        fontFamily: "PlusJakartaSansRegular",
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 1.w),
                      Container(
                        height: 40,
                        child: TextFormField(
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
                            hintText: "Full Name",
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
                        text: "Email Address",
                        fontSize: 16.sp,
                        fontColor: AppColors().color1E1E1E,
                        fontFamily: "PlusJakartaSansRegular",
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 1.w),
                      Container(
                        height: 40,
                        child: TextFormField(
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
                            hintText: "Email Address",
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
                        text: "Phone Number",
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
                          decoration: InputDecoration(
                            // prefixIcon: IconButton(
                            //   onPressed: () {},
                            //   icon: SvgPicture.asset(
                            //     "assets/icons/calendar.svg",
                            //     height: 20,
                            //     width: 20,
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
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
                            hintText: "Phone Number",
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
                        text: "Date Of Birth",
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
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                "assets/icons/calendar.svg",
                                height: 20,
                                width: 20,
                                fit: BoxFit.fill,
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
                            hintText: "Email Address",
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
                        text: "Gender",
                        fontSize: 16.sp,
                        fontColor: AppColors().color1E1E1E,
                        fontFamily: "PlusJakartaSansRegular",
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 1.w),
                      Container(
                        height: 42,

                        child: DropdownButtonFormField<int>(
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
                          items: [],
                          onChanged: (int? value) {},
                          // value: ans.answer,
                          // items: q.options
                          //     .map(
                          //       (opt) => DropdownMenuItem(
                          //     value: opt.id,
                          //     child: Text(
                          //       opt.label,
                          //       style: TextStyle(
                          //         fontSize: 16.sp,
                          //         fontFamily: "PlusJakartaSansRegular",
                          //         fontWeight: FontWeight.w600,
                          //       ),
                          //     ),
                          //   ),
                          // )
                          //     .toList(),
                          // onChanged: (v) => controller.updateAnswer(q.id, v),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.w),
                Container(
                  margin: EdgeInsets.only(left: 5.w, right: 5.w),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppColors().color5B6AEA,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Center(
                    child: CommonWidgets().commonText(
                      text: "Save",
                      fontSize: 16.sp,
                      fontColor: AppColors().colorFFFFFF,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.w600,
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
