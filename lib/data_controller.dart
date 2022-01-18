import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DataController extends GetxController{
  List<dynamic> listData = [];
  List<dynamic> listDataSearch = [].obs;

  readData() async {
    final String response = await rootBundle.loadString('assets/data/data.json');
    final data = await json.decode(response);
    listData = data.toList();
    listDataSearch.addAll(listData);
  }

  @override
  void onInit() {
    readData();
  }
  void search(String key){
    listDataSearch.clear();
    for(var item in listData){
      if(item.toString().toLowerCase().contains(key.toLowerCase())){
        listDataSearch.add(item);
      }
    }
  }
}