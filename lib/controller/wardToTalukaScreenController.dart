import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:ssinfra/model/villageListModel.dart';
import 'package:ssinfra/model/villageToTalukaListModel.dart';
import 'package:ssinfra/model/wardDataModel.dart';
import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';
import 'package:flutter/material.dart';

class WardToTownScreenController extends GetxController {
  Rx<WardListModel> wardListModel =
      WardListModel().obs;
  RxBool loader = true.obs;
  RxBool errorShow = false.obs;
  var arguments;
  String? talukaId;
  bool? assigned;
  RxBool showSearch = false.obs;

  RxList<WardList> wardList = <WardList>[].obs;
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
      wardList.clear();
      wardListModel.value.data?.forEach((action) {
        wardList.value.add((action));
      });
    } else {
      wardList.value = (wardListModel.value.data ?? [])
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
        ApiEndPoint.wardOnTown +
            "${talukaId}",
        //     +
        // ApiEndPoint.isAssigned +
        // "${assigned}",
      );
      log(res);
      log(res);
      wardListModel.value = WardListModel.fromJson(
        json.decode(res),
      );
      wardList.clear();
      wardListModel.value.data?.forEach((action) {
        wardList.add(action);
      });
    } catch (e) {
      errorShow.value = true;
    }
    loader.value = false;
  }
}
