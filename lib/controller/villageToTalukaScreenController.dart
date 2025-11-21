import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:ssinfra/model/villageListModel.dart';
import 'package:ssinfra/model/villageToTalukaListModel.dart';
import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';
import 'package:flutter/material.dart';

class VillageToTalukaScreenController extends GetxController {
  Rx<VillageToTalukaListModel> villageToTalukaListModel =
      VillageToTalukaListModel().obs;
  RxBool loader = true.obs;
  RxBool errorShow = false.obs;
  var arguments;
  String? talukaId;
  bool? assigned;
  RxBool showSearch = false.obs;

  RxList<Datum> villageToTalukaList = <Datum>[].obs;
  String searchText = "";
  Rx<TextEditingController> searchController = TextEditingController().obs;

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
    await searchItem();
    // }

    showSearch.value = !showSearch.value;
  }

  searchItem() {
    if (searchText.toString().isEmpty) {
      villageToTalukaList.clear();
      villageToTalukaListModel.value.data?.forEach((action) {
        villageToTalukaList.value.add((action));
      });
    } else {
      villageToTalukaList.value = (villageToTalukaListModel.value.data ?? [])
          .where(
            (item) => item.name.toString().toLowerCase().contains(
              searchText.toLowerCase().toString(),
            ),
          )
          .toList();
    }
  }

  getVillageList() async {
    var data = Get.arguments;
    talukaId = data["talukaId"];
    assigned = data["assigned"];
    try {
      var res = await ApiServices().getData(
        url:
            ApiEndPoint.villageOnTalukaSubDistrictId +
            "${talukaId}",
            //     +
            // ApiEndPoint.isAssigned +
            // "${assigned}",
      );
      log(res);
      log(res);
      villageToTalukaListModel.value = VillageToTalukaListModel.fromJson(
        json.decode(res),
      );
      villageToTalukaList.clear();
      villageToTalukaListModel.value.data?.forEach((action) {
        villageToTalukaList.add(action);
      });
    } catch (e) {
      errorShow.value = true;
    }
    loader.value = false;
  }
}
