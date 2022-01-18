import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:payment/diamond.dart';
import 'package:payment/payment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamController<int> controller = StreamController<int>();
  TextEditingController textEditingController = TextEditingController(text: "One, Two, Three");
  List<String> listItem = <String>[].obs;
  @override
  void initState() {
    super.initState();
    listItem.addAll(textEditingController.text.split(','));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
    controller.close();
  }
  @override
  Widget build(BuildContext context) {
    final Diamond diamond = Get.put(Diamond.instance);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Fortune Wheel', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    InkWell(
                      onTap: (){
                        Get.to(() => Payment(diamond: diamond));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              FaIcon(FontAwesomeIcons.gem, size: 15,),
                              SizedBox(width: 4,),
                              Obx(() => Text(diamond.diamondTotal.value.toString()))
                            ],
                          ),
                          Text('Buy Diamonds')
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 24),
                width: 350,
                height: 350,
                child: Obx(() => FortuneWheel(
                    selected: controller.stream,
                    animateFirst: false,
                    indicators: [
                      FortuneIndicator(
                          alignment: Alignment.topCenter,
                          child: TriangleIndicator(
                            color: Colors.red,
                          )
                      )
                    ],
                    items: listItem.map((e) => FortuneItem(child: Text(e.toString()))).toList()
                )),
              ),
              Container(
                  margin: EdgeInsets.all(8),
                  width: double.infinity,
                  height: 200,
                  child: Card(
                    child: CupertinoTextField(
                      controller: textEditingController,
                      onChanged: (text){
                        List<String> values = text.split(',');
                        if(values.length > 1){
                          listItem.clear();
                          listItem.addAll(values);
                        }
                      },
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Turn ("),
                    FaIcon(FontAwesomeIcons.gem, size: 15,),
                    SizedBox(width: 4,),
                    Text('1)')
                  ],
                ), color: Colors.red, onPressed: (){
                    if(diamond.diamondTotal.value > 0){
                      controller.add(Random().nextInt(listItem.length + 1));
                    }
                    diamond.subDiamond(1);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
