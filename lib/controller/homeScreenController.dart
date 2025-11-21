import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../model/formListModel.dart';
import '../services/apiEndPoint.dart';
import '../services/apiServices.dart';

class HomeScreenController extends GetxController{
  Rx<FormsListModel> formsListModel = FormsListModel().obs;
  RxBool loader = true.obs;
  RxBool errorShow = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFormList();
  }

  getFormList() async {
    // await   Future.delayed(Duration(seconds: 5),(){});
    try {
      var res = await ApiServices().getData(
        url: ApiEndPoint.forms+"en",
      );
      log(res);
      formsListModel.value = FormsListModel.fromJson(json.decode(res));
    } catch (e) {
      errorShow.value = true;
    }
    loader.value = false;
  }
}