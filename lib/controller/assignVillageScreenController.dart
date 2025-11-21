import 'dart:convert';
import 'dart:developer';

import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';
import 'package:flutter/material.dart';
import '../model/assignedVillageListModel.dart';
import '../model/villageListAssignModel.dart';
import '../utils/commonWidgets.dart';

class AssignVillageScreenController extends GetxController {
  Rx<VillageListAssignModel> villageListAssignModel =
      VillageListAssignModel().obs;
  Rx<AssignedVillageListModel> assignedVillageListModel =
      AssignedVillageListModel().obs;
  RxBool loader = true.obs;
  RxBool errorShow = false.obs;
  var arguments;
  String? talukaId;
  String? userId;
  bool? assigned;
  RxList villageId = [].obs;
  RxList assignedVillage = [].obs;
  RxInt groupValue = 0.obs;
  RxBool showSearch = false.obs;

  String searchText = "";
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<Datum> villageList = <Datum>[].obs;
  RxList<AssignedVillage> assignedVillageList = <AssignedVillage>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVillageList();
  }

  hideShowSearch() async {
    searchController.value.clear();
    // if (showSearch.value == true) {
    searchText = "";
    //   await sortData();
    //   // await searchItem();
    // }
    searchItem();
    showSearch.value = !showSearch.value;
  }

  searchItem() {
    if (searchText.toString().isEmpty) {
      if (groupValue.value == 0) {
        villageList.clear();
        villageListAssignModel.value.data?.forEach((action) {
          villageList.value.add((action));
        });
      } else {
        assignedVillageList.clear();
        assignedVillageListModel.value.data?.forEach((action) {
          assignedVillageList.value.add((action));
        });
      }
      // teamListModel.value.data?.forEach((action) {
      //   teamList.value.add((action));
      // });
    } else {
      if (groupValue.value == 0) {
        villageList.value = (villageListAssignModel.value.data ?? [])
            .where(
              (item) => item.name.toString().toLowerCase().contains(
                searchText.toLowerCase().toString(),
              ),
            )
            .toList();
      } else {
        assignedVillageList.value = (assignedVillageListModel.value.data ?? [])
            .where(
              (item) => item.name.toString().toLowerCase().contains(
                searchText.toLowerCase().toString(),
              ),
            )
            .toList();
      }
      // teamList.value = (teamListModel.value.data ?? []).where((item) {
      //   final name = (item.fullname ?? "").toLowerCase();
      //   return name.contains(searchText.toLowerCase()) &&
      //       item.isVerified == groupValue.value;
      // }).toList();
    }
  }

  getVillageList() async {
    var data = Get.arguments;
    talukaId = data["talukaId"];
    assigned = data["assigned"];
    userId = data["userId"];
    print(
      ApiEndPoint.villageOnTalukaSubDistrictId +
          "${talukaId}" +
          ApiEndPoint.isAssigned +
          "${true}",
    );
    try {
      var res = await ApiServices().getData(
        url:
            ApiEndPoint.villageOnTalukaSubDistrictId +
            "${talukaId}" +
            ApiEndPoint.isAssigned +
            "${false}",
      );

      villageListAssignModel.value = VillageListAssignModel.fromJson(
        json.decode(res),
      );
      villageList.clear();
      villageListAssignModel.value.data?.forEach((action) {
        villageList.add(action);
      });

      var response = await ApiServices().getData(
        url: ApiEndPoint.userAssignedVillage + "${userId}",
      );
      log(res);
      log(response);
      assignedVillageListModel.value = AssignedVillageListModel.fromJson(
        json.decode(response),
      );
      assignedVillageList.clear();
      assignedVillageListModel.value.data?.forEach((action) {
        assignedVillageList.add(action);
      });
      assignedVillage.clear();
      assignedVillageListModel.value.data?.forEach((action) {
        assignedVillage.add(action.id);
      });
    } catch (e) {
      errorShow.value = true;
    }
    loader.value = false;
  }

  void villageSelection(int? id) {
    if (villageId.value.contains(id)) {
      villageId.remove(id);
    } else {
      villageId.add(id);
    }
  }

  Future<void> submit(BuildContext context) async {
    if (villageId.value.length != 0) {
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
      try {
        final authUserData = {
          "user_id": userId.toString(),
          "village_ids": villageId.value,
        };

        log("📤 Request Data: ${jsonEncode(authUserData)}");

        var response = await ApiServices().postData(
          url: ApiEndPoint.assignVillageToUser,
          data: jsonEncode(authUserData),
        );
        var datas = jsonDecode(response);
        if (datas["status"] == 200) {
          CommonWidgets().showSnackBar(
            "Message",
            datas["message"],
            Colors.green,
            Colors.white,
          );
          Navigator.pop(context);
        } else {
          CommonWidgets().showSnackBar(
            "Message",
            datas["message"],
            Colors.red,
            Colors.white,
          );
        }
        print("✅ Response: $response");
      } catch (e) {
        print(e);
        CommonWidgets().showSnackBar(
          "Message",
          e.toString(),
          Colors.red,
          Colors.white,
        );
      }
      Navigator.pop(context);
    } else {
      CommonWidgets().showSnackBar(
        "Message",
        "Please, select at least one to assign",
        Colors.red,
        Colors.white,
      );
    }
  }

  removeVillage(id, context) async {
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
      final authUserData = {};

      log("📤 Request Data:${id} ${jsonEncode(authUserData)}");

      var response = await ApiServices().postData(
        url: ApiEndPoint.deleteVillage + "${id}",
        data: jsonEncode(authUserData),
      );

      var datas = jsonDecode(response);
      print(datas);
      print("datas");
      if (datas["status"] == 200) {
        var res = await ApiServices().getData(
          url:
              ApiEndPoint.villageOnTalukaSubDistrictId +
              "${talukaId}" +
              ApiEndPoint.isAssigned +
              "${false}",
        );

        log(res);

        villageListAssignModel.value = VillageListAssignModel.fromJson(
          json.decode(res),
        );
        var response = await ApiServices().getData(
          url: ApiEndPoint.userAssignedVillage + "${userId}",
        );
        assignedVillageListModel.value = AssignedVillageListModel.fromJson(
          json.decode(response),
        );
        assignedVillageListModel.value.data?.forEach((action) {
          assignedVillage.add(action.id);
        });
        assignedVillage.remove(id);
        await searchItem();
        CommonWidgets().showSnackBar(
          "Message",
          datas["message"],
          Colors.green,
          Colors.white,
        );
      } else {
        CommonWidgets().showSnackBar(
          "Message",
          datas["message"],
          Colors.red,
          Colors.white,
        );
      }
      print("✅ Response: $response");
    } catch (e) {
      print(e);
      CommonWidgets().showSnackBar(
        "Message",
        e.toString(),
        Colors.red,
        Colors.white,
      );
    }
    Navigator.pop(context);
  }
}
