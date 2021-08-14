import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RandomPassword extends StatefulWidget {
  const RandomPassword({Key? key}) : super(key: key);

  @override
  _RandomPasswordState createState() => _RandomPasswordState();
}

class _RandomPasswordState extends State<RandomPassword> {
  int length = 15;
  final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
  final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final number = '0123456789';
  final special = '@#%^*>\$@?/[]=+';
  bool isNumber = true;
  bool isSpecial = true;
  List<String> listPassword = [];
  late TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController(text: "15");
    regPassword();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.indigoAccent,
                Colors.greenAccent
              ]
            )
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(flex: 3,child: ListView.builder(
                    itemCount: listPassword.length,
                    itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(child: Text(listPassword[index], overflow: TextOverflow.clip,)),
                        IconButton(onPressed: (){
                          Clipboard.setData(ClipboardData(text: listPassword[index]));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copy successfully"), duration: Duration(milliseconds: 200),));
                        }, icon: Icon(CupertinoIcons.doc_on_clipboard))
                      ],
                    ),
                  );
                })),
                Expanded(flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text("Length", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                            SizedBox(width: 5,),
                            Container(width: 50,child: CupertinoTextField(keyboardType: TextInputType.number, controller: textEditingController,)),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Number", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                            CupertinoSwitch(value: isNumber, onChanged: (value){
                              setState(() {
                                isNumber = !isNumber;
                              });
                            }),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Special", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                            CupertinoSwitch(value: isSpecial, onChanged: (value){
                              setState(() {
                                isSpecial = !isSpecial;
                              });
                            }),
                          ],
                        ),
                      ],
                    ),
                    CupertinoButton(child: Text("Get Password", style: TextStyle(color: Colors.black),), onPressed: (){
                      regPassword();
                    }, color: Colors.white,)
                  ],
                )),
              ],
            ),
          ),
        )
    );
  }
  String generatePassword(){
    String chars = "";
    chars += '$letterLowerCase$letterUpperCase';
    if (isNumber) chars += '$number';
    if (isSpecial) chars += '$special';
    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars [indexRandom];
    }).join('');
  }
  regPassword(){
    try{
      length = int.parse(textEditingController.text);
      if(length <= 0 || length > 50){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error : Invalid length"), duration: Duration(milliseconds: 200)));
        return;
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), duration: Duration(milliseconds: 200)));
    }

    listPassword.clear();
    for(int i = 0; i< 10; i++){
      listPassword.add(generatePassword());
    }
    setState(() {

    });
  }
}
