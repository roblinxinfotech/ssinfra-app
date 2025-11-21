import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssinfra/model/talukaListModel.dart';
import 'package:ssinfra/model/villageListModel.dart';
import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';
import 'package:flutter/material.dart';
import '../model/teamListModel.dart';

class TeamScreenController extends GetxController {
  Rx<TeamListModel> teamListModel = TeamListModel().obs;
  RxBool loader = true.obs;
  RxBool errorShow = false.obs;
  RxList permissions = [].obs;
  RxInt groupValue = 0.obs;

  RxBool showSearch = false.obs;
  RxList<TeamList> teamList = <TeamList>[].obs;
  String searchText = "";
  Rx<TextEditingController> searchController = TextEditingController().obs;

  Future<void> getPermissions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List? permission = await prefs.getStringList("permissions");
    print(permission?.length);
    print("permission?.length");
    if (permission?.length != 0) {
      permissions.value = permission!;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getTeamList();
  }

  hideShowSearch() async {
    searchController.value.clear();
    // if (showSearch.value == true) {
    searchText = "";
    //   await sortData();
    //   // await searchItem();
    // }
    sortData();
    showSearch.value = !showSearch.value;
  }

  searchItem() {
    if (searchText.toString().isEmpty) {
      sortData();
      // teamListModel.value.data?.forEach((action) {
      //   teamList.value.add((action));
      // });
    } else {
      teamList.value = (teamListModel.value.data ?? []).where((item) {
        final name = (item.fullname ?? "").toLowerCase();
        return name.contains(searchText.toLowerCase()) &&
            item.isVerified == groupValue.value;
      }).toList();
    }
  }

  getTeamList() async {
    await getPermissions();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List? permission = await prefs.getStringList("permissions");
    if (permission?.length != 0) {
      permissions.value = permission!;
    }
    // await   Future.delayed(Duration(seconds: 5),(){});
    try {
      var res = await ApiServices().getData(url: ApiEndPoint.teams);
      log(res.toString());
      teamList.clear();
      teamListModel.value = TeamListModel.fromJson(json.decode(res));
      if (groupValue.value == 0) {
        teamListModel.value.data?.forEach((action) {
          teamList.addIf(action.isVerified == 0, action);
        });
      } else if (groupValue.value == 1) {
        teamListModel.value.data?.forEach((action) {
          teamList.addIf(action.isVerified == 1, action);
        });
      } else if (groupValue.value == 2) {
        teamListModel.value.data?.forEach((action) {
          teamList.addIf(action.isVerified == 2, action);
        });
      }
    } catch (e) {
      errorShow.value = true;
    }
    loader.value = false;
  }

  sortData() {
    if (groupValue.value == 0) {
      teamList.clear();
      teamListModel.value.data?.forEach((action) {
        teamList.addIf(action.isVerified == 0, action);
      });
    } else if (groupValue.value == 1) {
      teamList.clear();
      teamListModel.value.data?.forEach((action) {
        teamList.addIf(action.isVerified == 1, action);
      });
    } else if (groupValue.value == 2) {
      teamList.clear();
      teamListModel.value.data?.forEach((action) {
        teamList.addIf(action.isVerified == 2, action);
      });
    }
  }
}
