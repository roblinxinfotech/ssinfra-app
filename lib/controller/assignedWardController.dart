import 'dart:convert';
import 'dart:developer';

import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ssinfra/model/userAssignedWard.dart';
import 'package:ssinfra/model/wardDataModel.dart';
import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';
import 'package:flutter/material.dart';
import '../model/assignedVillageListModel.dart';
import '../model/villageListAssignModel.dart';
import '../utils/commonWidgets.dart';

class AssignWardScreenController extends GetxController {
  Rx<WardListModel> wardListModel = WardListModel().obs;
  Rx<UserAssignedWard> userAssignedWard = UserAssignedWard().obs;
  RxBool loader = true.obs;
  RxBool errorShow = false.obs;
  var arguments;
  String? talukaId;
  String? userId;
  bool? assigned;
  RxList wardId = [].obs;
  RxList assignedWard = [].obs;
  RxInt groupValue = 0.obs;
  RxBool showSearch = false.obs;

  String searchText = "";
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<WardList> wardList = <WardList>[].obs;
  RxList<UserAssignedWardLIst> assignedWardList = <UserAssignedWardLIst>[].obs;

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
        wardList.clear();
        wardListModel.value.data?.forEach((action) {
          wardList.value.add((action));
        });
      } else {
        assignedWardList.clear();
        userAssignedWard.value.data?.forEach((action) {
          assignedWardList.value.add((action));
        });
      }
      // teamListModel.value.data?.forEach((action) {
      //   teamList.value.add((action));
      // });
    } else {
      if (groupValue.value == 0) {
        wardList.value = (wardListModel.value.data ?? [])
            .where(
              (item) => item.name.toString().toLowerCase().contains(
                searchText.toLowerCase().toString(),
              ),
            )
            .toList();
      } else {
        assignedWardList.value = (userAssignedWard.value.data ?? [])
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
            ApiEndPoint.wardOnTown +
            "${talukaId}${ApiEndPoint.isAssigned}${false}",
      );

      wardListModel.value = WardListModel.fromJson(json.decode(res));
      wardList.clear();
      wardListModel.value.data?.forEach((action) {
        wardList.add(action);
      });

      var response = await ApiServices().getData(
        url: ApiEndPoint.userAssignedWard + "${userId}",
      );
      log(res);
      log(response);
      userAssignedWard.value = UserAssignedWard.fromJson(json.decode(response));
      assignedWard.clear();
      userAssignedWard.value.data?.forEach((action) {
        assignedWard.add(action);
      });
      assignedWard.clear();
      userAssignedWard.value.data?.forEach((action) {
        assignedWard.add(action.id);
      });
    } catch (e) {
      errorShow.value = true;
    }
    loader.value = false;
  }

  void villageSelection(int? id) {
    if (wardId.value.contains(id)) {
      wardId.remove(id);
    } else {
      wardId.add(id);
    }
  }

  Future<void> submit(BuildContext context) async {
    if (wardId.value.length != 0) {
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
          "ward_ids": wardId.value,
        };

        log("📤 Request Data: ${jsonEncode(authUserData)}");

        var response = await ApiServices().postData(
          url: ApiEndPoint.assignWardToUser,
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
        url: ApiEndPoint.deleteWardId + "${id}",
        data: jsonEncode(authUserData),
      );

      var datas = jsonDecode(response);
      print(datas);
      print("datas");
      if (datas["status"] == 200) {
        var res = await ApiServices().getData(
          url:
              ApiEndPoint.wardOnTown +
              "${talukaId}${ApiEndPoint.isAssigned}${false}",
        );

        log(res);

        wardListModel.value = WardListModel.fromJson(json.decode(res));
        var response = await ApiServices().getData(
          url: ApiEndPoint.userAssignedWard + "${userId}",
        );
        userAssignedWard.value = UserAssignedWard.fromJson(
          json.decode(response),
        );
        userAssignedWard.value.data?.forEach((action) {
          assignedWard.add(action.id);
        });
        assignedWard.remove(id);
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
