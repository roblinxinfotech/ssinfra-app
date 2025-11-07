import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/utils/commonWidgets.dart';
import '../controller/formScreenController.dart';
import '../utils/appColors.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

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
                    )
                  : controller.questions.length == 0
                  ? Center(
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
                    )
                  : Column(
                      children: [
                        Column(
                          children: [
                            CommonWidgets().commonText(
                              text:
                                  "${controller.title.toString().toUpperCase()}",
                              fontSize: 20.sp,
                              fontColor: AppColors().color1E1E1E,
                              fontFamily: "PlusJakartaSansMedium",
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Radio<int>(
                                                visualDensity: VisualDensity(
                                                  horizontal: -4,
                                                  vertical: -4,
                                                ),
                                                value: 1,
                                                groupValue: 1,
                                                fillColor:
                                                    WidgetStateProperty.resolveWith(
                                                      (states) => AppColors()
                                                          .color5B6AEA,
                                                    ),
                                                onChanged: (_) {},
                                              ),
                                              Text(
                                                "Rural-1",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontFamily:
                                                      "PlusJakartaSansMedium",
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                          Row(
                                            children: [
                                              Radio<int>(
                                                value: 2,
                                                groupValue: 1,
                                                fillColor:
                                                    WidgetStateProperty.resolveWith(
                                                      (states) => AppColors()
                                                          .color5B6AEA,
                                                    ),
                                                onChanged: (_) {},
                                              ),
                                              Text(
                                                "Urban-2",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontFamily:
                                                      "PlusJakartaSansMedium",
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 2.w),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 40,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'State',
                                                labelStyle: TextStyle(
                                                  color:
                                                      AppColors().color5B6AEA,
                                                  fontSize: 16.sp,
                                                  fontFamily:
                                                      "PlusJakartaSansRegular",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 10,
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
                                              decoration: InputDecoration(
                                                labelText: 'Code',
                                                labelStyle: TextStyle(
                                                  color:
                                                      AppColors().color5B6AEA,
                                                  fontSize: 16.sp,
                                                  fontFamily:
                                                      "PlusJakartaSansRegular",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 10,
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
                                              decoration: InputDecoration(
                                                labelText: 'District',
                                                labelStyle: TextStyle(
                                                  color:
                                                      AppColors().color5B6AEA,
                                                  fontSize: 16.sp,
                                                  fontFamily:
                                                      "PlusJakartaSansRegular",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 10,
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
                                              decoration: InputDecoration(
                                                labelText: 'Code',
                                                labelStyle: TextStyle(
                                                  color:
                                                      AppColors().color5B6AEA,
                                                  fontSize: 16.sp,
                                                  fontFamily:
                                                      "PlusJakartaSansRegular",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 10,
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
                                              decoration: InputDecoration(
                                                labelText: 'Block/Tehsil',
                                                labelStyle: TextStyle(
                                                  color:
                                                      AppColors().color5B6AEA,
                                                  fontSize: 16.sp,
                                                  fontFamily:
                                                      "PlusJakartaSansRegular",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 10,
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
                                              decoration: InputDecoration(
                                                labelText: 'Code',
                                                labelStyle: TextStyle(
                                                  color:
                                                      AppColors().color5B6AEA,
                                                  fontSize: 16.sp,
                                                  fontFamily:
                                                      "PlusJakartaSansRegular",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 10,
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
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await controller.submit();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 5.w,
                        right: 5.w,
                        bottom: 10.w,
                      ),
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: AppColors().color5B6AEA,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Center(
                        child: CommonWidgets().commonText(
                          text: "Submit",
                          fontSize: 16.sp,
                          fontColor: AppColors().colorFFFFFF,
                          fontFamily: "PlusJakartaSansRegular",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
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
        List<int> selected = (ans.answer ?? []).cast<int>();
        final minSelect = q.minSelect ?? 0;
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
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) => controller.updateAnswer(q.id, v),
          ),
        );

      case "input":
        return Row(
          children: [
            Flexible(
              child: Container(
                height: 40,
                child: TextFormField(
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
                    hintText: "${q.label}",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: "PlusJakartaSansRegular",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onChanged: (v) => controller.updateAnswer(q.id, v),
                ),
              ),
            ),
            q.unit?.name != null
                ? Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Text(
                      "${q.unit?.name.toString()}",
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
      case "textarea":
        return Row(
          children: [
            Flexible(
              child: TextFormField(
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
                  hintText: "${q.label}",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: "PlusJakartaSansRegular",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onChanged: (v) => controller.updateAnswer(q.id, v),
              ),
            ),
            q.unit?.name != null
                ? Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Text(
                      "${q.unit?.name.toString()}",
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
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    controller.updateAnswer(q.id, result.files.single.name);
                  }
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
                key: ValueKey(
                  'number_field_${widget.question.id}',
                ), // Stable key
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
                ),
                keyboardType: TextInputType.number,
                focusNode: _focusNode,
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
