import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payment/payment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color colorText = Colors.grey;
  String textValue = "Result";
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Base64 decode and encode", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                  TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Payment()));
                  }, child: Text("Donate", style: TextStyle(fontSize: 16),))
                ],
              ),
            ),
            CupertinoTextField(
              maxLines: 5,
              minLines: 5,
              placeholder: "Input",
              controller: textEditingController,
            ),
            Expanded(child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0.2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(padding: EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 8),child: SingleChildScrollView(child: Text(textValue, style: TextStyle(color: colorText, fontSize: 16)))),
                  ),
                ),
                Positioned(top: 0,right: 0,child: TextButton(child: Text("Copy"), onPressed: (){
                  Clipboard.setData(ClipboardData(text: textValue));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success"), duration: Duration(milliseconds: 500),));
                },)),
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(child: Text("Encode"), onPressed: (){
                  if(textEditingController.text.isEmpty) return;
                  setState(() {
                    textValue = textToBase64(text: textEditingController.text);
                    colorText = Colors.black;
                  });

                }, color: Colors.redAccent,),
                CupertinoButton(child: Text("Decode"), onPressed: (){
                  if(textEditingController.text.isEmpty) return;
                  setState(() {
                    textValue = base64ToText(base64Str: textEditingController.text);
                    colorText = Colors.black;
                  });
                }, color: Colors.deepPurpleAccent,),
              ],
            )
          ],
        ),
      ),
    ));
  }

  String textToBase64({required String text}) {
      List<int> encodedText = utf8.encode(text);
      String base64Str = base64.encode(encodedText);
      return base64Str;
  }
  String base64ToText({required String base64Str}){
      return utf8.decode(base64.decode(base64Str));
  }
}
