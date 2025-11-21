import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ssinfra/model/assignedTownModel.dart';
import 'package:ssinfra/model/talukaListModel.dart';
import 'package:ssinfra/model/villageListModel.dart';
import 'package:ssinfra/services/apiEndPoint.dart';
import 'package:ssinfra/services/apiServices.dart';

class TalukaScreenController extends GetxController {
  Rx<TalukaListModel> talukaListModel = TalukaListModel().obs;
  Rx<AssignedTownModel> assignedTownModel = AssignedTownModel().obs;
  RxBool loader = true.obs;
  RxBool errorShow = false.obs;
  RxBool showSearch = false.obs;
  RxList<Datum> talukaList = <Datum>[].obs;
  RxList<AssignedTown> assignedTownList = <AssignedTown>[].obs;
  String searchText = "";
  Rx<TextEditingController> searchController = TextEditingController().obs;

  RxInt groupValue = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTalukaList();
  }

  getTalukaList() async {
    // await   Future.delayed(Duration(seconds: 5),(){});

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

      var response = await ApiServices().getData(
        url: ApiEndPoint.assignedTowns,
      );
      log(res.toString());
      assignedTownModel.value = AssignedTownModel.fromJson(
        json.decode(response),
      );
      assignedTownList.clear();
      assignedTownModel.value.data?.forEach((action) {
        assignedTownList.value.add(action);
      });
    } catch (e) {
      errorShow.value = true;
    }
    loader.value = false;
  }

  hideShowSearch() async {
    searchController.value.clear();
    searchText = "";
    await searchItem();

    showSearch.value = !showSearch.value;
  }

  searchItem() {
    if (searchText.toString().isEmpty) {
      talukaList.clear();
      talukaListModel.value.data?.forEach((action) {
        talukaList.value.add((action));
      });
    } else {
      talukaList.value = (talukaListModel.value.data ?? [])
          .where(
            (item) => item.name.toString().toLowerCase().contains(
              searchText.toLowerCase().toString(),
            ),
          )
          .toList();
    }

    if (searchText.toString().isEmpty) {
      if (groupValue.value == 0) {
        talukaList.clear();
        talukaListModel.value.data?.forEach((action) {
          talukaList.value.add((action));
        });
      } else {
        assignedTownList.clear();
        assignedTownModel.value.data?.forEach((action) {
          assignedTownList.value.add((action));
        });
      }
      // teamListModel.value.data?.forEach((action) {
      //   teamList.value.add((action));
      // });
    } else {
      if (groupValue.value == 0) {
        talukaList.value = (talukaListModel.value.data ?? [])
            .where(
              (item) => item.name.toString().toLowerCase().contains(
                searchText.toLowerCase().toString(),
              ),
            )
            .toList();
      } else {
        assignedTownList.value = (assignedTownModel.value.data ?? [])
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
