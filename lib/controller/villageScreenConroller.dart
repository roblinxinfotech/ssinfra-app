import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:ssinfra/model/villageListModel.dart';
import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';
import 'package:flutter/material.dart';

class VillageScreenController extends GetxController {
  Rx<VillageListModel> villageListModel = VillageListModel().obs;
  RxBool loader = true.obs;
  RxBool errorShow = false.obs;
  RxBool showSearch = false.obs;
  RxList<Village> villageList = <Village>[].obs;
  String searchText = "";
  Rx<TextEditingController> searchController = TextEditingController().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVillageList();
  }

  getVillageList() async {
    try {
      var res = await ApiServices().getData(
        url: ApiEndPoint.assignedVillageWardData,
      );
      log(res);
      log(res);
      villageListModel.value = VillageListModel.fromJson(json.decode(res));
      villageList.clear();
      villageListModel.value.data?.villages?.forEach((action) {
        villageList.value.add(action);
      });
    } catch (e) {
      errorShow.value = true;
    }
    loader.value = false;
  }

  hideShowSearch() async {
    searchController.value.clear();
    if (showSearch.value == true) {
      searchText = "";
      await searchItem();
    }
    showSearch.value = !showSearch.value;
  }

  searchItem() {
    if (searchText.toString().isEmpty) {
      villageList.clear();
      villageListModel.value.data?.villages?.forEach((action) {
        villageList.value.add((action));
      });
    } else {
      villageList.value = (villageListModel.value.data?.villages ?? [])
          .where(
            (item) => item.name.toString().toLowerCase().contains(
              searchText.toLowerCase().toString(),
            ),
          )
          .toList();
    }
  }
}
