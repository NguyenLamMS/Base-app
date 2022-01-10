import 'package:hive/hive.dart';

class Diamond{
  static  Diamond _instance = Diamond._();
  int diamondTotal = 0;
  var box;
  Diamond._();
  static Diamond get instance => _instance;

  init() async {
    box = await Hive.openBox("Diamond");
    diamondTotal = box.get("Total") ?? 0;
    print(diamondTotal);
  }

  sumDiamond(int value){
    diamondTotal += value;
    box.put('Total', diamondTotal);
  }
  subDiamond(int value){
    diamondTotal -= value;
    box.put('Total', diamondTotal);
  }
  getDiamond() async {
    return diamondTotal;
  }

}