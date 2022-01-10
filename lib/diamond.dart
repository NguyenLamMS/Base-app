import 'package:get/get.dart';
import 'package:hive/hive.dart';

class Diamond extends GetxController{
  static  Diamond _instance = Diamond._();
  var diamondTotal = 0.obs;
  var box;
  Diamond._();
  static Diamond get instance => _instance;

  init() async {
    box = await Hive.openBox("Diamond");
    diamondTotal.value = box.get("Total") ?? 0;
  }

  sumDiamond(int value){
    diamondTotal.value += value;
    box.put('Total', diamondTotal.value);
  }
  subDiamond(int value){
    if(diamondTotal.value <= 0){
      Get.snackbar("Notify", "You don't have enough diamonds", duration: Duration(milliseconds: 1000));
      return;
    }
    diamondTotal.value -= value;
    box.put('Total', diamondTotal.value);
  }

}