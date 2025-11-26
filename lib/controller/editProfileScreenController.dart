import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/model/profileModel.dart';
import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';

import '../utils/commonWidgets.dart';

class EditProfileScreenController extends GetxController {
  Rx<TextEditingController> fullName = TextEditingController().obs;
  Rx<TextEditingController> emailAddress = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> birthDate = TextEditingController().obs;
  RxString gender = "male".obs;
  final ImagePicker picker = ImagePicker();
  var data;
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  Rxn<File> profileImage = Rxn<File>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    data = Get.arguments;
    profileModel.value = data["profileData"];
    fullName.value.text = profileModel.value.data?.fullname.toString() ?? "";
    emailAddress.value.text = profileModel.value.data?.email.toString() ?? "";
    phoneNumber.value.text = profileModel.value.data?.mobile.toString() ?? "";
    birthDate.value.text = profileModel.value.data?.dob == null
        ? ""
        : formatDate(profileModel.value.data!.dob.toString());
    gender.value = profileModel.value.data!.gender.toString();
    print(profileModel.value.data!.gender.toString());
  }

  editProfile(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Image.asset(
              "assets/images/splashLoader.gif",
              height: 25.w,
              width: 25.w,
              fit: BoxFit.fill,
            ),
          );
        },
      );
      // if (profileImage.value == null) {
      //   var res = await ApiServices().uploadDataWithFiles(
      //     url: ApiEndPoint.updateProfile,
      //     fields: {
      //       "fullname": fullName.value.text.toString(),
      //       "mobile": phoneNumber.value.text.toString(),
      //       "email": emailAddress.value.text.toString(),
      //       "gender": gender.value.toString(),
      //       "dob": birthDate.value.text.toString(),
      //     },
      //     files: {},
      //   );
      //   print(res);
      //   print({
      //     "fullname": fullName.value.text.toString(),
      //     "mobile": phoneNumber.value.text.toString(),
      //     "gender": gender.value.toString(),
      //     "email": emailAddress.value.text.toString(),
      //     "dob": formatDate(profileModel.value.data!.dob.toString()),
      //   });
      //   print("fghfghf");
      // } else {
      var res = await ApiServices().uploadDataWithFiles(
        url: ApiEndPoint.updateProfile,
        fields: {
          "fullname": fullName.value.text.toString(),
          "email": emailAddress.value.text.toString(),
          "mobile": phoneNumber.value.text.toString(),
          "gender": gender.value.toString(),
          "dob": formatDate(birthDate.value.text.toString()),
        },
        files: {"profile_photo": profileImage.value},
      );
      print(res);
      print("fghfghf");
      print({
        "fullname": fullName.value.text.toString(),
        "email": emailAddress.value.text.toString(),
        "mobile": phoneNumber.value.text.toString(),
        "gender": gender.value.toString(),
        "dob": formatDate(profileModel.value.data!.dob.toString()),
      });

      var data = jsonDecode(res);
      print(data["message"]);
      print("dxfgbfdgddf");
      if (data["status"] == 200) {
        CommonWidgets().showSnackBar(
          "Message",
          data["message"],
          Colors.green,
          Colors.white,
        );
      } else {
        CommonWidgets().showSnackBar(
          "Message",
          data["message"],
          Colors.red,
          Colors.white,
        );
      }
      // }
      Navigator.pop(context);
    } catch (e) {
      print(e);
      print("sofkhgwrewrwr;lohsgk");
    }
    Navigator.pop(context);
  }
}

String formatDate(String apiDate) {
  // Ensure 2-digit month & day
  final parts = apiDate.split('-');

  final year = parts[0];
  final month = parts[1].padLeft(2, '0');
  final day = parts[2].padLeft(2, '0');

  final normalized = "$year-$month-$day";

  final date = DateTime.parse(normalized);

  return "${date.year}-"
      "${date.month.toString().padLeft(2, '0')}-"
      "${date.day.toString().padLeft(2, '0')}";
}
