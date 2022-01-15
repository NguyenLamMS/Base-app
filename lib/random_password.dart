import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment/diamond.dart';
import 'package:payment/payment.dart';
import 'package:username_generator/username_generator.dart';

class RandomPassword extends StatefulWidget {
  const RandomPassword({Key? key}) : super(key: key);

  @override
  _RandomPasswordState createState() => _RandomPasswordState();
}

class _RandomPasswordState extends State<RandomPassword> {
  List<String> listUser = [];
  late TextEditingController textEditingController;
  late UsernameGenerator generator;
  @override
  void initState() {
    textEditingController = TextEditingController(text: "15");
    generator = UsernameGenerator();
    userGenerator();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Diamond diamond = Get.put(Diamond.instance);
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffEB3349),
                Color(0xffF45C43)
              ]
            )
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(flex: 1,child: Container(height: 50, alignment: Alignment.center,child: Text('Username Generator', style: GoogleFonts.pacifico(textStyle: TextStyle(color: Colors.white, fontSize: 25)),))),
                Expanded(flex: 3,child: ListView.builder(
                    itemCount: listUser.length,
                    itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(child: Text(listUser[index], overflow: TextOverflow.clip,)),
                        IconButton(onPressed: (){
                          Clipboard.setData(ClipboardData(text: listUser[index]));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copy successfully"), duration: Duration(milliseconds: 200),));
                        }, icon: Icon(FontAwesomeIcons.clipboard))
                      ],
                    ),
                  );
                })),
                Expanded(flex: 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text("Length", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                                  SizedBox(width: 5,),
                                  Container(width: 50,child: CupertinoTextField(keyboardType: TextInputType.number, controller: textEditingController,)),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(FontAwesomeIcons.solidGem, size: 16, color: Colors.white,),
                              SizedBox(width: 4,),
                              Obx(() => Text(diamond.diamondTotal.value.toString(), style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white),)),
                              TextButton(onPressed: (){
                                  Get.to(() => Payment(diamond: diamond));
                              }, child: Text("| Buy Diamonds", style: TextStyle(color: Colors.white),))
                            ],
                          ),
                          CupertinoButton(child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Generetor (", style: TextStyle(color: Colors.black),),
                              FaIcon(FontAwesomeIcons.solidGem, color: Colors.black, size: 14,),
                              SizedBox(width: 3,),
                              Text("1)", style: Theme.of(context).textTheme.button)
                            ],
                          ), onPressed: (){
                            if(diamond.diamondTotal.value > 0){
                                userGenerator();
                            }
                            diamond.subDiamond(1);
                          }, color: Colors.white,),
                        ],
                      ),
                    ),
                  )),
              ],
            ),
          ),
        )
    );
  }

  userGenerator(){
    listUser.clear();
    for( var i = 0 ; i < int.parse(textEditingController.text.toString()); i++ ) {
      listUser.add(generator.generateRandom());
    }
    setState(() {

    });
  }
}
