import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:ssinfra/model/wardListDataModel.dart';

import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';
import 'package:flutter/material.dart';

import '../model/assignedVillageWardModel.dart';

class VillageScreenController extends GetxController {
  Rx<AssignedVillageWardModel> villageListModel =
      AssignedVillageWardModel().obs;
  Rx<WardListDataModel> wardListDataModel =
      WardListDataModel().obs;
  RxBool loader = true.obs;
  RxBool errorShow = false.obs;
  RxBool showSearch = false.obs;
  RxList<Village> villageList = <Village>[].obs;

  RxList<Ward> wardList = <Ward>[].obs;
  String searchText = "";
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxInt groupValue = 0.obs;
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

      villageListModel.value = AssignedVillageWardModel.fromJson(
        json.decode(res),
      );
      villageList.clear();
      villageListModel.value.data?.villages?.forEach((action) {
        villageList.value.add(action);
      });



      // var response = await ApiServices().getData(
      //   url: ApiEndPoint.assignedTowns,
      // );
      var response = await ApiServices().getData(
        url: ApiEndPoint.assignedWardWards,
      );
      log(response.toString());
      wardListDataModel.value = WardListDataModel.fromJson(
        json.decode(response),
      );
      wardList.clear();
      wardListDataModel.value.data?.wards?.forEach((action) {
        wardList.value.add(action);
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

  // searchItem() {
  //   if (searchText.toString().isEmpty) {
  //     villageList.clear();
  //     villageListModel.value.data?.villages?.forEach((action) {
  //       villageList.value.add((action));
  //     });
  //   } else {
  //     villageList.value = (villageListModel.value.data?.villages ?? [])
  //         .where(
  //           (item) => item.name.toString().toLowerCase().contains(
  //             searchText.toLowerCase().toString(),
  //           ),
  //         )
  //         .toList();
  //   }
  // }

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

    if (searchText.toString().isEmpty) {
      if (groupValue.value == 0) {
        villageList.clear();
        villageListModel.value.data?.villages?.forEach((action) {
          villageList.value.add((action));
        });
      } else {
        wardList.clear();
        wardListDataModel.value.data?.wards?.forEach((action) {
          wardList.value.add((action));
        });
      }
      // teamListModel.value.data?.forEach((action) {
      //   teamList.value.add((action));
      // });
    } else {
      if (groupValue.value == 0) {
        villageList.value = (villageListModel.value.data?.villages ?? [])
            .where(
              (item) => item.name.toString().toLowerCase().contains(
            searchText.toLowerCase().toString(),
          ),
        )
            .toList();
      } else {
        wardList.value = (wardListDataModel.value.data?.wards ?? [])
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
}
