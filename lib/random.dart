import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payment/payment.dart';

class RandomNumber extends StatefulWidget {
  const RandomNumber({Key? key}) : super(key: key);

  @override
  _RandomNumberState createState() => _RandomNumberState();
}

class _RandomNumberState extends State<RandomNumber> {
  late TextEditingController textEditingControllerMin;
  late TextEditingController textEditingControllerMax;
  int random = 0;
  @override
  void initState() {
    textEditingControllerMin = TextEditingController(text: "0");
    textEditingControllerMax = TextEditingController(text: "100");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue,
              Colors.red
            ]
          )
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: size.width * 0.8,
                alignment: Alignment.center,
                child: Text(random.toString(), style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white, fontWeight: FontWeight.w300),),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5)
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Min"),
                        SizedBox(width: 10,),
                        Container(width: 100,child: CupertinoTextField(controller: textEditingControllerMin, keyboardType: TextInputType.number, maxLength: 1000000, ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Max"),
                        SizedBox(width: 10,),
                        Container(width: 100,child: CupertinoTextField(controller: textEditingControllerMax, keyboardType: TextInputType.number,maxLength: 1000000,))
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  CupertinoButton(child: Text("Get number", style: TextStyle(color: Colors.black),), onPressed: (){
                    try{
                      int min = int.parse(textEditingControllerMin.text);
                      int max = int.parse(textEditingControllerMax.text);
                      if(max < min){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Max must be bigger Min")));
                      }else{
                        random = min +   Random.secure().nextInt(max + 1 - min);
                        setState(() {

                        });
                      }
                    }catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }, color: Colors.white),
                  TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Payment()));
                  }, child: Text('Donate'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
