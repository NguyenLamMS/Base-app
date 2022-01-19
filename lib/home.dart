import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Diamond diamond = Get.put(Diamond.instance);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Uppercase lowercase', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
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
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: CupertinoTextField(controller: textEditingController, maxLines: null, keyboardType:  TextInputType.multiline,),
              ),
            ),
            Row(
              children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        textEditingController.text = textEditingController.text.toUpperCase();
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        height: 50,
                        color: Colors.red,
                        alignment: Alignment.center,
                        child: Text('Uppercase', style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white),),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        textEditingController.text = textEditingController.text.toLowerCase();
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        height: 50,
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: Text('Lowercase', style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white)),
                      ),
                    ),
                  )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      if(diamond.diamondTotal.value > 0){
                        textEditingController.text = textEditingController.text.capitalize!;
                      }
                      diamond.subDiamond(1);
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: 50,
                      color: Colors.amber,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Capitalize (', style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white),),
                          FaIcon(FontAwesomeIcons.gem, color: Colors.white, size: 15,),
                          Text('1)' , style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      textEditingController.text = textEditingController.text.capitalizeFirst!;
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: 50,
                      color: Colors.deepOrange,
                      alignment: Alignment.center,
                      child: Text('Capitalize first', style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
