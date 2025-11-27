import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/utils/commonWidgets.dart';
import 'package:ssinfra/view/editFormScreen.dart';
import '../controller/formScreenController.dart';
import '../utils/appColors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, String? formid});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final DynamicFormController controller = Get.put(DynamicFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().colorE1E5FD,
      body: SafeArea(
        top: true,
        bottom: false,
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
          child: Obx(
            () => Padding(
              padding: EdgeInsets.only(left: 3.w, right: 3.w),
              child: controller.showLoader == true
                  ? Center(
                      child: Image.asset(
                        height: 25.w,
                        width: 25.w,
                        "assets/images/splashLoader.gif",
                        fit: BoxFit.fill,
                      ),
                    )
                  : controller.error == true
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            ],
                          ),

                          Column(
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

                          Container(height: 25.sp, width: 25.sp),
                        ],
                      ),
                    )
                  : controller.questions.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            ],
                          ),
                          Column(
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
                          Container(height: 25.sp, width: 25.sp),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Row(
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
                            Expanded(
                              child: Column(
                                children: [
                                  CommonWidgets().commonText(
                                    text:
                                        "${controller.title.toString().toUpperCase()}",
                                    fontSize: 20.sp,
                                    fontColor: AppColors().color1E1E1E,
                                    fontFamily: "PlusJakartaSansMedium",
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 2.w),
                                  Container(
                                    height: 1,
                                    width: 30.w,
                                    color: AppColors().color5B6AEA,
                                  ),
                                ],
                              ),
                            ),
                            Container(height: 25.sp, width: 25.sp),
                          ],
                        ),
                        SizedBox(height: 3.w),
                        Obx(
                          () => controller.gradientProgressBar(
                            controller.progress.value,
                          ),
                        ),
                        SizedBox(height: 3.w),
                        Expanded(
                          child: ListView(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 2.w,
                                  right: 2.w,
                                  top: 2.w,
                                  bottom: 2.w,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors().colorFFFFFF,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors().colorFFFFFF,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: AppColors().colorD7D7D7,
                                        ),
                                      ),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            controller.categoryList.length,
                                        itemBuilder: (context, index) {
                                          return Obx(() {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                right: 4.w,
                                              ),
                                              child: Row(
                                                children: [
                                                  Radio<int>(
                                                    visualDensity:
                                                        VisualDensity(
                                                          horizontal: -4,
                                                          vertical: -4,
                                                        ),
                                                    value: controller
                                                        .categoryList
                                                        .value[index]
                                                        .id!,
                                                    groupValue: controller
                                                        .storedCategory
                                                        .value,
                                                    fillColor:
                                                        WidgetStateProperty.resolveWith(
                                                          (states) =>
                                                              AppColors()
                                                                  .color5B6AEA,
                                                        ),
                                                    onChanged: (val) {
                                                      controller
                                                              .storedCategory
                                                              .value =
                                                          val;

                                                      if (val == 1) {
                                                        controller.filterForms(
                                                          controller
                                                              .wardStored
                                                              .value,
                                                        );
                                                      } else if (val == 2) {
                                                        controller.filterForms(
                                                          controller
                                                              .villageStored
                                                              .value,
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  Text(
                                                    "${controller.categoryList[index].name?.capitalizeFirst.toString()}",
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontFamily:
                                                          "PlusJakartaSansMedium",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 2.w),

                                    controller.storedCategory == 2
                                        ? Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 40,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          labelText: 'State'.tr,
                                                          hintText:
                                                              "${controller.assignedVillageWardModel.value.data?.state?.name ?? "N/A"}",
                                                          labelStyle: TextStyle(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .colorD7D7D7,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .color5B6AEA,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(width: 2.w),

                                                  // 🟡 Code Field
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 40,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          labelText: 'Code'.tr,
                                                          hintText:
                                                              "${controller.assignedVillageWardModel.value.data?.state?.code ?? "N/A"}",
                                                          labelStyle: TextStyle(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .colorD7D7D7,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .color5B6AEA,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2.w),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 40,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "${controller.assignedVillageWardModel.value.data?.district?.name ?? "N/A"}",
                                                          labelText:
                                                              'District'.tr,
                                                          labelStyle: TextStyle(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .colorD7D7D7,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .color5B6AEA,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(width: 2.w),

                                                  // 🟡 Code Field
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 40,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "${controller.assignedVillageWardModel.value.data?.district?.code ?? "N/A"}",
                                                          labelText: 'Code'.tr,
                                                          labelStyle: TextStyle(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .colorD7D7D7,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .color5B6AEA,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2.w),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 40,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "${controller.assignedVillageWardModel.value.data?.subdistrict?.name ?? "N/A"}",
                                                          labelText:
                                                              'Block/Tehsil'.tr,
                                                          labelStyle: TextStyle(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .colorD7D7D7,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .color5B6AEA,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(width: 2.w),

                                                  // 🟡 Code Field
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 40,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "${controller.assignedVillageWardModel.value.data?.subdistrict?.code ?? "N/A"}",
                                                          labelText: 'Code'.tr,
                                                          labelStyle: TextStyle(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .colorD7D7D7,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .color5B6AEA,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 2.w),
                                              Container(
                                                height: 42,
                                                child: DropdownButtonFormField<int>(
                                                  value: controller
                                                      .villageStored
                                                      .value,
                                                  hint: Text(
                                                    "SelectVillage".tr,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 10,
                                                        ),
                                                    suffixIcon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      size: 30,
                                                      color: AppColors()
                                                          .color1E1E1E,
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: AppColors()
                                                                .colorD7D7D7,
                                                          ),
                                                        ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                          ),
                                                        ),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  items: controller
                                                      .assignedVillageWardModel
                                                      .value
                                                      .data
                                                      ?.villages!
                                                      .map(
                                                        (
                                                          opt,
                                                        ) => DropdownMenuItem(
                                                          value: opt.id,
                                                          child: Text(
                                                            opt.name.toString(),
                                                            style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontFamily:
                                                                  "PlusJakartaSansRegular",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged:
                                                      (dynamic value) async {
                                                        controller
                                                                .villageStored
                                                                .value =
                                                            value;
                                                        await controller
                                                            .filterForms(
                                                              controller
                                                                  .villageStored
                                                                  .value,
                                                            );
                                                      },
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
                                          )
                                        : Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 40,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          labelText: 'State'.tr,
                                                          hintText:
                                                              "${controller.wardListDataModel.value.data?.state?.name ?? "N/A"}",
                                                          labelStyle: TextStyle(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .colorD7D7D7,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .color5B6AEA,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(width: 2.w),

                                                  // 🟡 Code Field
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 40,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          labelText: 'Code'.tr,
                                                          hintText:
                                                              "${controller.wardListDataModel.value.data?.state?.code ?? "N/A"}",
                                                          labelStyle: TextStyle(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .colorD7D7D7,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .color5B6AEA,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2.w),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 40,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "${controller.wardListDataModel.value.data?.district?.name ?? "N/A"}",
                                                          labelText:
                                                              'District'.tr,
                                                          labelStyle: TextStyle(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .colorD7D7D7,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .color5B6AEA,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(width: 2.w),

                                                  // 🟡 Code Field
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 40,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "${controller.wardListDataModel.value.data?.district?.code ?? "N/A"}",
                                                          labelText: 'Code'.tr,
                                                          labelStyle: TextStyle(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .colorD7D7D7,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .color5B6AEA,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2.w),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 40,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "${controller.wardListDataModel.value.data?.town?.name ?? "N/A"}",
                                                          labelText: 'Town'.tr,
                                                          labelStyle: TextStyle(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .colorD7D7D7,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .color5B6AEA,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(width: 2.w),

                                                  // 🟡 Code Field
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 40,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              "${controller.wardListDataModel.value.data?.town?.code ?? "N/A"}",
                                                          labelText: 'Code'.tr,
                                                          labelStyle: TextStyle(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                "PlusJakartaSansRegular",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                              ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .colorD7D7D7,
                                                            ),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: AppColors()
                                                                  .color5B6AEA,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 2.w),
                                              Container(
                                                height: 42,
                                                child: DropdownButtonFormField<int>(
                                                  hint: Text("SelectWard".tr),
                                                  value: controller
                                                      .wardStored
                                                      .value,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 10,
                                                        ),
                                                    suffixIcon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      size: 30,
                                                      color: AppColors()
                                                          .color1E1E1E,
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: AppColors()
                                                                .colorD7D7D7,
                                                          ),
                                                        ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: AppColors()
                                                                .color5B6AEA,
                                                          ),
                                                        ),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  items: controller
                                                      .wardListDataModel
                                                      .value
                                                      .data
                                                      ?.wards!
                                                      .map(
                                                        (
                                                          opt,
                                                        ) => DropdownMenuItem(
                                                          value: opt.id,
                                                          child: Text(
                                                            opt.name.toString(),
                                                            style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontFamily:
                                                                  "PlusJakartaSansRegular",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged:
                                                      (dynamic value) async {
                                                        controller
                                                                .wardStored
                                                                .value =
                                                            value;
                                                        await controller
                                                            .filterForms(
                                                              controller
                                                                  .wardStored
                                                                  .value,
                                                            );
                                                      },
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
                                  ],
                                ),
                              ),
                              Obx(() {
                                return controller.filledForm.length == 0
                                    ? SizedBox()
                                    : Padding(
                                        padding: EdgeInsets.only(
                                          top: 3.w,
                                          bottom: 3.w,
                                        ),

                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: 3.w,
                                            right: 3.w,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),

                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                              dividerColor: Colors
                                                  .transparent, // removes both lines
                                            ),
                                            child: ExpansionTile(
                                              title: Text(
                                                "AllForms".tr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      "PlusJakartaSansMedium",
                                                ),
                                              ),
                                              tilePadding: EdgeInsets.zero,
                                              childrenPadding: EdgeInsets.zero,

                                              children: [
                                                Container(
                                                  height: 150,
                                                  child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    itemCount: controller
                                                        .filledForm
                                                        .length,
                                                    itemBuilder: (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          print("color5B6AEA");
                                                          print(
                                                            controller
                                                                .filledForm[index]
                                                                .id,
                                                          );

                                                          Get.to(
                                                            EditFormScreen(),
                                                            arguments: {
                                                              "formId": controller
                                                                  .filledForm[index]
                                                                  .id,
                                                              "categoryId":
                                                                  controller
                                                                      .storedCategory
                                                                      .value,
                                                              "surveyId": controller
                                                                  .filledForm[index]
                                                                  .surveyId,
                                                            },
                                                          );
                                                        },
                                                        child: ListTile(
                                                          contentPadding:
                                                              EdgeInsets.all(0),
                                                          title: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                  2.w,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    2.w,
                                                                  ),
                                                              border: Border.all(
                                                                width: 1,
                                                                color: AppColors()
                                                                    .color1E1E1E,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "${controller.filledForm[index].name.toString()}",
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        "PlusJakartaSansRegular",
                                                                  ),
                                                                ),
                                                                Icon(
                                                                  Icons.edit,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                              }),

                              SingleChildScrollView(
                                child: Container(
                                  // padding: EdgeInsets.only(left: 2.w, right: 2.w),
                                  // decoration: BoxDecoration(
                                  //   color: AppColors().colorFFFFFF,
                                  //   borderRadius: BorderRadius.circular(10),
                                  // ),
                                  child: Column(
                                    children: List.generate(
                                      controller.questions.length,
                                      (i) => _buildQuestion(
                                        controller.questions[i],
                                        index: i + 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: Obx(() {
        return controller.questions.length != 0
            ? SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (controller.storedCategory.value == 2) {
                          if (controller.villageStored.value == null) {
                            CommonWidgets().showSnackBar(
                              "Message",
                              "Please select village",
                              Colors.red,
                              Colors.white,
                            );
                          } else {
                            await controller.submit(context);
                          }
                        } else if (controller.storedCategory.value == 1) {
                          if (controller.wardStored.value == null) {
                            CommonWidgets().showSnackBar(
                              "Message",
                              "Please select ward",
                              Colors.red,
                              Colors.white,
                            );
                          } else {
                            await controller.submit(context);
                          }
                        } else {
                          print("Select Category");
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
                            text: "Submit".tr,
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
              )
            : SizedBox();
      }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: controller.submit,
      //   child: const Icon(Icons.check),
      // ),
    );
  }

  Widget _buildQuestion(QuestionModel q, {int? index}) {
    final visible = controller.shouldShowQuestion(q);
    final isAutofilled = q.autofill?.hasFormula ?? false;

    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: AppColors().colorFFFFFF,
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (q.type != "label")
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: index != null ? "$index. ${q.label} " : q.label,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: "PlusJakartaSansRegular",
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // main text color
                      ),
                    ),
                    if (q.isRequired == true)
                      TextSpan(
                        text: " *",
                        style: TextStyle(
                          color: AppColors().colorFF0000, // 🔴 red star
                          fontSize: 18.sp,
                          fontFamily: "PlusJakartaSansRegular",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
              if (q.type != "label") const SizedBox(height: 8),
              if (isAutofilled && q.type != "label")
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _AutoFormulaBanner(type: q.autofill?.type),
                ),
              _buildField(q),
              if (q.childrens.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Column(
                    children: q.childrens
                        .map(
                          (e) => _buildQuestion(e),
                        ) // 👈 No index for children
                        .toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(QuestionModel q) {
    final ans =
        controller.answers.firstWhereOrNull((a) => a.id == q.id) ??
        AnswerModel(id: q.id, answer: null);

    switch (q.type) {
      case "radio":
        return Column(
          children: q.options
              .map(
                (opt) => RadioListTile<int>(
                  contentPadding: EdgeInsets.zero,
                  // 👈 removes default left-right padding
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  // 👈 reduces spacing
                  activeColor: AppColors().color5B6AEA,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  radioSide: BorderSide(
                    color: AppColors().color5B6AEA,
                    width: 1.5,
                  ),
                  title: Text(
                    opt.label,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  value: opt.id,
                  groupValue: ans.answer,
                  onChanged: (v) => controller.updateAnswer(q.id, v),
                ),
              )
              .toList(),
        );

      case "checkbox":
        // Safely handle checkbox answer - ensure it's always a List<int>
        List<int> selected = [];
        if (ans.answer != null) {
          if (ans.answer is List) {
            selected = (ans.answer as List)
                .map((e) {
                  if (e is int) return e;
                  if (e is num) return e.toInt();
                  return int.tryParse(e.toString()) ?? 0;
                })
                .where((e) => e != 0)
                .toList();
          } else {
            // If it's not a list, try to convert it
            final value = ans.answer;
            if (value is int) {
              selected = [value];
            } else if (value is num) {
              selected = [value.toInt()];
            } else {
              final parsed = int.tryParse(value.toString());
              if (parsed != null) {
                selected = [parsed];
              }
            }
          }
        }
        final maxSelect = q.maxSelect ?? q.options.length;

        return Column(
          children: q.options.map((opt) {
            final isChecked = selected.contains(opt.id);
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              // 👈 removes default left-right padding
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              // 👈 reduces spacing
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              side: BorderSide(color: AppColors().color5B6AEA, width: 1.5),
              activeColor: AppColors().color5B6AEA,
              title: Text(
                opt.label,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: "PlusJakartaSansRegular",
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: isChecked,
              onChanged: (v) {
                if (v == true) {
                  if (selected.length >= maxSelect) {
                    Get.snackbar(
                      "Limit reached",
                      "Maximum $maxSelect choices allowed.",
                      titleText: Text(
                        "Limit reached",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      messageText: Text(
                        "Maximum $maxSelect choices allowed.",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      backgroundColor: Colors.orangeAccent,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  selected.add(opt.id);
                } else {
                  selected.remove(opt.id);
                }
                controller.updateAnswer(q.id, List.from(selected));
              },
            );
          }).toList(),
        );

      case "select":
        return Container(
          height: 42,
          child: DropdownButtonFormField<int>(
            isExpanded: true,
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
                borderSide: BorderSide(color: AppColors().colorD7D7D7),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors().color5B6AEA),
              ),
              border: OutlineInputBorder(),
            ),
            value: ans.answer,
            items: q.options
                .map(
                  (opt) => DropdownMenuItem(
                    value: opt.id,
                    child: Text(
                      opt.label,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "PlusJakartaSansRegular",
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) => controller.updateAnswer(q.id, v),
          ),
        );

      case "input":
        return _InputFieldWidget(question: q, controller: controller);
      case "textarea":
        return _TextareaFieldWidget(question: q, controller: controller);

      case "number":
        return _NumberFieldWidget(question: q, controller: controller);

      case "file":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: ElevatedButton.icon(
                onPressed: () async {
                  // if (Platform.isAndroid) {
                  var status = await Permission.location.request();
                  Position? position;
                  if (status.isGranted) {
                    // Check if GPS is enabled
                    bool serviceEnabled =
                        await Geolocator.isLocationServiceEnabled();
                    if (!serviceEnabled) {
                      // Open device location settings
                      await Geolocator.openLocationSettings();
                      position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high,
                      );
                      if (position != null) {
                      } else {}
                    } else {
                      // Get current position
                      position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high,
                      );
                      print(
                        "Location: ${position.latitude}, ${position.longitude}",
                      );
                      if (position != null) {
                        controller.latitude=position.latitude.toString();
                        controller.longitude=position.longitude.toString();
                      } else {}
                    }
                  } else if (status.isPermanentlyDenied) {
                    // Open app settings
                    await openAppSettings();
                    position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high,
                    );
                    if (position != null) {
                    } else {}
                  } else {
                    print("Permission denied");
                  }
                  // Map<Permission, PermissionStatus> statuses = await [
                  //   Permission.location,
                  // ].request();

                  // await Utils.getCurrentLocation().then((value) async {
                  //   print(value);
                  //   print(value);
                  //   if (position != null) {
                  //     permissionDenied.value = false;
                  //     currentLocationMarker =
                  //         Image.asset(AppAssets.appIcon, width: 30, height: 30);
                  //     markers.add(
                  //       Marker(
                  //         markerId: const MarkerId('current_location'),
                  //         position: LatLng(position.latitude, position.longitude),
                  //         icon:
                  //             BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                  //       ),
                  //     );
                  //   } else {
                  //     isLoading.value = false;
                  //     permissionDenied.value = true;
                  //   }
                  // });
                  // }

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
                              'Select image by below options.',
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
                                    final XFile? image = await controller.picker
                                        .pickImage(
                                          source: ImageSource.camera,
                                          imageQuality: 50,
                                        );
                                    Navigator.pop(context);
                                    final result = image;
                                    if (result != null) {
                                      controller.updateAnswer(
                                        q.id,
                                        result.path,
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
                                      color: AppColors().color5B6AEA.withValues(
                                        alpha: 0.3,
                                      ),
                                      border: Border.all(
                                        color: AppColors().color5B6AEA,
                                      ),
                                      borderRadius: BorderRadius.circular(1.w),
                                    ),
                                    child: Text(
                                      "Camera",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "PlusJakartaSansMedium",
                                        color: AppColors().color5B6AEA,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                GestureDetector(
                                  onTap: () async {
                                    final XFile? image = await controller.picker
                                        .pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 50,
                                        );
                                    Navigator.pop(context);
                                    final result = image;
                                    if (result != null) {
                                      controller.updateAnswer(
                                        q.id,
                                        result.path,
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
                                      color: AppColors().color5B6AEA.withValues(
                                        alpha: 0.3,
                                      ),
                                      border: Border.all(
                                        color: AppColors().color5B6AEA,
                                      ),
                                      borderRadius: BorderRadius.circular(1.w),
                                    ),

                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Gallery",
                                          style: TextStyle(
                                            color: AppColors().color5B6AEA,
                                            fontWeight: FontWeight.w400,
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
                icon: Icon(Icons.upload_file, color: AppColors().color1E1E1E),
                label: Text(
                  "Upload File",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors().color1E1E1E,
                    fontFamily: "PlusJakartaSansRegular",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            if (ans.answer != null)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Selected file: ${ans.answer}",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: "PlusJakartaSansRegular",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.w),
                    child: Image.file(
                      File(ans.answer.toString()),
                      height: 50.w,
                      width: 100.w,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        "assets/icons/placeHolder.png",
                        height: 20.w,
                        width: 20.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}

/// Stateful widget for number fields to properly manage TextEditingController
class _NumberFieldWidget extends StatefulWidget {
  final QuestionModel question;
  final DynamicFormController controller;

  const _NumberFieldWidget({required this.question, required this.controller});

  @override
  State<_NumberFieldWidget> createState() => _NumberFieldWidgetState();
}

class _NumberFieldWidgetState extends State<_NumberFieldWidget> {
  late TextEditingController _textController;
  late FocusNode _focusNode;
  bool _isUserEditing = false;

  @override
  void initState() {
    super.initState();
    final ans = widget.controller.answers.firstWhereOrNull(
      (a) => a.id == widget.question.id,
    );
    _textController = TextEditingController(
      text: ans?.answer?.toString() ?? '',
    );
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _isUserEditing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isAutoFilled = widget.question.autofill?.hasFormula ?? false;
      final currentAns =
          widget.controller.answers.firstWhereOrNull(
            (a) => a.id == widget.question.id,
          ) ??
          AnswerModel(id: widget.question.id, answer: null);
      final currentValue = currentAns.answer?.toString() ?? '';

      // Only update controller if value changed externally (autofill) and user is not editing
      if (!_isUserEditing && _textController.text != currentValue) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_isUserEditing) {
            _textController.value = TextEditingValue(
              text: currentValue,
              selection: TextSelection.collapsed(offset: currentValue.length),
            );
          }
        });
      }

      return Row(
        children: [
          Flexible(
            child: Container(
              height: 40,
              child: TextFormField(
                key: ValueKey('number_field_${widget.question.id}'),
                // Stable key
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors().color5B6AEA),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors().color787878),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors().colorD7D7D7),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: "${widget.question.label}",
                  hintStyle: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: "PlusJakartaSansRegular",
                    fontWeight: FontWeight.w600,
                  ),
                  filled: isAutoFilled,
                  fillColor: isAutoFilled
                      ? AppColors().colorE1E5FD.withOpacity(0.4)
                      : null,
                  suffixIcon: isAutoFilled
                      ? _AutoBadgeChip(type: widget.question.autofill?.type)
                      : null,
                  suffixIconConstraints: const BoxConstraints(
                    minHeight: 0,
                    minWidth: 0,
                  ),
                ),
                keyboardType: TextInputType.number,
                focusNode: _focusNode,
                onTap: () {
                  _isUserEditing = true;
                },
                onChanged: (v) {
                  _isUserEditing = true;
                  widget.controller.updateAnswer(
                    widget.question.id,
                    v.toString().isEmpty ? 0 : v,
                  );
                },
                onEditingComplete: () {
                  _isUserEditing = false;
                  _focusNode.unfocus();
                },
              ),
            ),
          ),
          widget.question.unit?.name != null
              ? Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Text(
                    "${widget.question.unit?.name.toString()}",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      );
    });
  }
}

/// Stateful widget for input fields to preserve text across hide/show
class _InputFieldWidget extends StatefulWidget {
  final QuestionModel question;
  final DynamicFormController controller;

  const _InputFieldWidget({required this.question, required this.controller});

  @override
  State<_InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<_InputFieldWidget> {
  late TextEditingController _textController;
  late FocusNode _focusNode;
  bool _isUserEditing = false;

  @override
  void initState() {
    super.initState();
    final ans = widget.controller.answers.firstWhereOrNull(
      (a) => a.id == widget.question.id,
    );
    _textController = TextEditingController(
      text: ans?.answer?.toString() ?? '',
    );
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _isUserEditing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isAutoFilled = widget.question.autofill?.hasFormula ?? false;
      final currentAns =
          widget.controller.answers.firstWhereOrNull(
            (a) => a.id == widget.question.id,
          ) ??
          AnswerModel(id: widget.question.id, answer: null);
      final currentValue = currentAns.answer?.toString() ?? '';

      if (!_isUserEditing && _textController.text != currentValue) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_isUserEditing) {
            _textController.value = TextEditingValue(
              text: currentValue,
              selection: TextSelection.collapsed(offset: currentValue.length),
            );
          }
        });
      }

      return Row(
        children: [
          Flexible(
            child: Container(
              height: 40,
              child: TextFormField(
                key: ValueKey('input_field_${widget.question.id}'),
                controller: _textController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors().color787878),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors().colorD7D7D7),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors().color5B6AEA),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  border: const OutlineInputBorder(),
                  hintText: "${widget.question.label}",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: "PlusJakartaSansRegular",
                    fontWeight: FontWeight.w600,
                  ),
                  filled: isAutoFilled,
                  fillColor: isAutoFilled
                      ? AppColors().colorE1E5FD.withOpacity(0.4)
                      : null,
                  suffixIcon: isAutoFilled
                      ? _AutoBadgeChip(type: widget.question.autofill?.type)
                      : null,
                  suffixIconConstraints: const BoxConstraints(
                    minHeight: 0,
                    minWidth: 0,
                  ),
                ),
                onTap: () {
                  _isUserEditing = true;
                },
                onChanged: (v) {
                  _isUserEditing = true;
                  widget.controller.updateAnswer(widget.question.id, v);
                },
                onEditingComplete: () {
                  _isUserEditing = false;
                  _focusNode.unfocus();
                },
              ),
            ),
          ),
          widget.question.unit?.name != null
              ? Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Text(
                    "${widget.question.unit?.name.toString()}",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      );
    });
  }
}

/// Stateful widget for textarea fields to preserve text across hide/show
class _TextareaFieldWidget extends StatefulWidget {
  final QuestionModel question;
  final DynamicFormController controller;

  const _TextareaFieldWidget({
    required this.question,
    required this.controller,
  });

  @override
  State<_TextareaFieldWidget> createState() => _TextareaFieldWidgetState();
}

class _TextareaFieldWidgetState extends State<_TextareaFieldWidget> {
  late TextEditingController _textController;
  late FocusNode _focusNode;
  bool _isUserEditing = false;

  @override
  void initState() {
    super.initState();
    final ans = widget.controller.answers.firstWhereOrNull(
      (a) => a.id == widget.question.id,
    );
    _textController = TextEditingController(
      text: ans?.answer?.toString() ?? '',
    );
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _isUserEditing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isAutoFilled = widget.question.autofill?.hasFormula ?? false;
      final currentAns =
          widget.controller.answers.firstWhereOrNull(
            (a) => a.id == widget.question.id,
          ) ??
          AnswerModel(id: widget.question.id, answer: null);
      final currentValue = currentAns.answer?.toString() ?? '';

      if (!_isUserEditing && _textController.text != currentValue) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_isUserEditing) {
            _textController.value = TextEditingValue(
              text: currentValue,
              selection: TextSelection.collapsed(offset: currentValue.length),
            );
          }
        });
      }

      return Row(
        children: [
          Flexible(
            child: TextFormField(
              key: ValueKey('textarea_field_${widget.question.id}'),
              controller: _textController,
              focusNode: _focusNode,
              maxLines: 5,
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors().color787878),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors().colorD7D7D7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors().color5B6AEA),
                ),
                contentPadding: EdgeInsets.only(left: 10),
                border: const OutlineInputBorder(),
                hintText: "${widget.question.label}",
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontFamily: "PlusJakartaSansRegular",
                  fontWeight: FontWeight.w600,
                ),
                filled: isAutoFilled,
                fillColor: isAutoFilled
                    ? AppColors().colorE1E5FD.withOpacity(0.4)
                    : null,
                suffixIcon: isAutoFilled
                    ? _AutoBadgeChip(type: widget.question.autofill?.type)
                    : null,
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 0,
                  minWidth: 0,
                ),
              ),
              onTap: () {
                _isUserEditing = true;
              },
              onChanged: (v) {
                _isUserEditing = true;
                widget.controller.updateAnswer(widget.question.id, v);
              },
              onEditingComplete: () {
                _isUserEditing = false;
                _focusNode.unfocus();
              },
            ),
          ),
          widget.question.unit?.name != null
              ? Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Text(
                    "${widget.question.unit?.name.toString()}",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      );
    });
  }
}

class _AutoBadgeChip extends StatelessWidget {
  final String? type;

  const _AutoBadgeChip({this.type});

  @override
  Widget build(BuildContext context) {
    final label = (type?.isNotEmpty ?? false) ? type! : "Auto";
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors().color5B6AEA.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          fontFamily: "PlusJakartaSansMedium",
          fontWeight: FontWeight.bold,
          color: AppColors().color5B6AEA,
        ),
      ),
    );
  }
}

class _AutoFormulaBanner extends StatelessWidget {
  final String? type;

  const _AutoFormulaBanner({this.type});

  @override
  Widget build(BuildContext context) {
    final label = (type?.isNotEmpty ?? false) ? type! : "Auto";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors().colorE1E5FD.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, color: AppColors().color5B6AEA, size: 16),
          const SizedBox(width: 6),
          Text(
            "${label.toUpperCase()} filled",
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: "PlusJakartaSansRegular",
              fontWeight: FontWeight.w600,
              color: AppColors().color1E1E1E,
            ),
          ),
        ],
      ),
    );
  }
}
