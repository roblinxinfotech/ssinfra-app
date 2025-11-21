import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/model/categoryModel.dart';
import 'package:ssinfra/services/apiServices.dart';
import 'package:ssinfra/utils/commonWidgets.dart';

import '../model/assignedTownModel.dart';
import '../model/talukaListModel.dart';
import '../model/teamMemberCreationModel.dart';
import '../services/apiEndPoint.dart';

class AddMemberScreenController extends GetxController {
  Rx<TextEditingController> fullName = TextEditingController().obs;
  Rx<TextEditingController> userName = TextEditingController().obs;
  Rx<TextEditingController> emailAddress = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> emergencyMobileNumber = TextEditingController().obs;
  Rx<TextEditingController> birthDate = TextEditingController().obs;
  Rx<TextEditingController> adharNumber = TextEditingController().obs;

  Rx<TextEditingController> bloodGroup = TextEditingController().obs;
  RxString gender = "male".obs;
  RxString areaType = "Urban".obs;
  Rx<TextEditingController> personAddress = TextEditingController().obs;
  Rx<TextEditingController> bankName = TextEditingController().obs;
  Rx<TextEditingController> branchName = TextEditingController().obs;
  Rx<TextEditingController> bankAccountHolderName = TextEditingController().obs;
  Rx<TextEditingController> bankAccountNumber = TextEditingController().obs;
  Rx<TextEditingController> ifscCode = TextEditingController().obs;
  Rx<TextEditingController> panController = TextEditingController().obs;
  TeamMemberCreationModel teamMemberCreationModel = TeamMemberCreationModel();

  // RxString bankProof="".obs;
  // RxString aadharFrontImage="".obs;
  // RxString aadharBackImage="".obs;
  // RxString panImage=" ".obs;
  Rx<TextEditingController> panNumber = TextEditingController().obs;
  final ImagePicker picker = ImagePicker();
  Rxn<File> bankImage = Rxn<File>();
  Rxn<File> adharFrontSide = Rxn<File>();
  Rxn<File> adharBackSide = Rxn<File>();
  Rxn<File> panImage = Rxn<File>();
  Rxn<File> profileImage = Rxn<File>();
  RxBool status = true.obs;
  RxnInt storedsubDustrictId = RxnInt();
  RxnInt storedCategory = RxnInt();

  Rx<TalukaListModel> talukaListModel = TalukaListModel().obs;
  Rx<CategoryModel> categoryModel = CategoryModel().obs;
  RxList<Datum> talukaList = <Datum>[].obs;
  RxList<CategoryList> categoryList = <CategoryList>[].obs;

  RxList<AssignedTown> assignedTownList = <AssignedTown>[].obs;
  Rx<AssignedTownModel> assignedTownModel = AssignedTownModel().obs;
  RxBool loadDropDown = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTaluka();
  }

  Future<void> getTaluka() async {
    var response = await ApiServices().getData(url: ApiEndPoint.category);

    categoryModel.value = CategoryModel.fromJson(json.decode(response));
    categoryList.clear();
    categoryModel.value.data?.forEach((action) {
      categoryList.value.add(action);
    });

    if (categoryList.length != 0) {
      storedCategory.value = categoryList[0].id;
      await getUrbanData(storedCategory.value);
    }
  }

  addTeamMember(context) async {
    print({
      "fullname": fullName.value.text.toString(),
      "username": userName.value.text.toString(),
      "email": emailAddress.value.text.toString(),
      "mobile": phoneNumber.value.text.toString(),
      "gender": gender.value.toString(),
      "dob": birthDate.value.text.toString(),
      "password": password.value.text.toString(),
      "password_confirmation": confirmPassword.value.text.toString(),
      "aadhar_no": adharNumber.value.text.toString(),
      "bank_name": bankName.value.text.toString(),
      "account_holder_name": bankAccountHolderName.value.text.toString(),
      "account_number": bankAccountNumber.value.text.toString(),
      "ifsc_code": ifscCode.value.text.toString(),
      "blood_group": bloodGroup.value.text.toString(),
      "address": personAddress.value.text.toString(),
      "emergency_mobile": emergencyMobileNumber.value.text.toString(),
      "pan_no": panNumber.value.text.toString(),
      "branch_name": branchName.value.text.toString(),
      "is_active": status,
      "sub_district_id": storedCategory.value == 2
          ? storedsubDustrictId.value.toString()
          : "",
      "town_id": storedCategory.value == 1
          ? storedsubDustrictId.value.toString()
          : "",
    });
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
      var res = await ApiServices().uploadDataWithFiles(
        url: "${ApiEndPoint.createNewUser}",
        fields: {
          "fullname": fullName.value.text.toString(),
          "username": userName.value.text.toString(),
          "email": emailAddress.value.text.toString(),
          "mobile": phoneNumber.value.text.toString(),
          "gender": gender.value.toString(),
          "dob": birthDate.value.text.toString(),
          "password": password.value.text.toString(),
          "password_confirmation": confirmPassword.value.text.toString(),
          "aadhar_no": adharNumber.value.text.toString(),
          "bank_name": bankName.value.text.toString(),
          "account_holder_name": bankAccountHolderName.value.text.toString(),
          "account_number": bankAccountNumber.value.text.toString(),
          "ifsc_code": ifscCode.value.text.toString(),
          "blood_group": bloodGroup.value.text.toString(),
          "address": personAddress.value.text.toString(),
          "emergency_mobile": emergencyMobileNumber.value.text.toString(),
          "pan_no": panController.value.text.toString(),
          "branch_name": branchName.value.text.toString(),
          "is_active": status.value == true ? "1" : "0",
          "sub_district_id": storedCategory.value == 2
              ? storedsubDustrictId.value.toString()
              : "",
          "town_id": storedCategory.value == 1
              ? storedsubDustrictId.value.toString()
              : "",
        },
        files: {
          "aadhar_front": adharFrontSide.value,
          "aadhar_back": adharBackSide.value,
          "pan_file": panImage.value,
          "bank_proof": bankImage.value,
          "profile_photo": profileImage.value,
        },
      );
      teamMemberCreationModel = TeamMemberCreationModel.fromJson(
        json.decode(res),
      );

      if (teamMemberCreationModel.status == 201) {
        CommonWidgets().showSnackBar(
          "Message",
          teamMemberCreationModel.message.toString(),
          Colors.green,
          Colors.white,
        );
        Navigator.pop(context);
      } else {
        CommonWidgets().showSnackBar(
          "Error",
          teamMemberCreationModel.message.toString(),
          Colors.red,
          Colors.white,
        );
      }
    } catch (e) {}
    Navigator.pop(context);
  }

  Future<void> getUrbanData(int? v) async {
    loadDropDown.value = false;
    try {
      var res = await ApiServices().getData(url: ApiEndPoint.assignedTowns);
      log(res.toString());
      assignedTownModel.value = AssignedTownModel.fromJson(json.decode(res));
      assignedTownList.clear();
      assignedTownModel.value.data?.forEach((action) {
        assignedTownList.value.add(action);
      });
      print(assignedTownList.length);
      if (assignedTownList.length != 0) {
        storedsubDustrictId.value = assignedTownList[0].townId;
      }
    } catch (e) {}
    loadDropDown.value = true;
  }

  Future<void> getRuralData(int? v) async {
    loadDropDown.value = false;
    try {
      var res = await ApiServices().getData(
        url: ApiEndPoint.assignedSubDistrictData,
      );
      log(res.toString());
      talukaListModel.value = TalukaListModel.fromJson(json.decode(res));
      talukaList.clear();
      talukaListModel.value.data?.forEach((action) {
        talukaList.value.add(action);
      });
      if (talukaList.length != 0) {
        storedsubDustrictId.value = talukaList[0].subDistrictId;
      }
    } catch (e) {}
    loadDropDown.value = true;
  }
}
