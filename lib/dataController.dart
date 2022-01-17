import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DataController extends GetxController{
  DataController({required this.context});
  final BuildContext context;
  List<dynamic> listData = [].obs;
  List<dynamic> listSearch = [].obs;
  @override
  Future<void> onInit() async {
    listData.addAll(await readData());
    listSearch.addAll(listData);
  }

  Future<List<dynamic>> readData() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/data/data.json");
    final jsonResult = json.decode(data);
    List<dynamic> result = jsonResult.toList();
    return result;
  }
   searchData(String key) async{
    listSearch.clear();
    for(var item in listData){
      if(item.toString().toLowerCase().contains(key.toLowerCase())){
        listSearch.add(item);
      }
    }
  }
}