import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payment/payment.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Column(
        children: [
          Container(height: 50,decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pink,
                Colors.deepPurple
              ],
            )
          ) ,child: HomeAppBar(context)),
          Expanded(child: HomeBody(context))
        ],
      ),
    ),);
  }
  Widget HomeAppBar(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text("Cute Emoticons Symbols", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18, color: Colors.white),),
        ),
        TextButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Payment()));
        }, child: Text('Donate', style: TextStyle(fontWeight: FontWeight.w400),))
      ],
    );
  }
  Widget HomeBody(BuildContext context){
    return FutureBuilder<List>(
      future: readDataJson(context),
      builder: (context, snap){
        if(snap.hasData){
            var arrayData = snap.data;
            return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),itemCount: arrayData!.length, itemBuilder: (context, index){
              return Card(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        alignment: Alignment.center,
                        child: FittedBox(fit: BoxFit.contain ,child: Text(arrayData[index], style: Theme.of(context).textTheme.headline6,)),
                      ),
                    ),
                    Positioned(bottom: 0, right: 0, left: 0 ,child: TextButton(onPressed: (){
                      Clipboard.setData(ClipboardData(text: arrayData[index]));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copy Success"), duration: Duration(milliseconds: 100),));
                    }, child: Text('Copy')))
                  ],
                ),
              );
            });
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
        return Text("hello");
      });
  }
  Future<List> readDataJson(BuildContext context) async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/data/data.json");
    final jsonResult = jsonDecode(data);
    var arrayData = jsonResult['data'];
    return arrayData;
  }
}
