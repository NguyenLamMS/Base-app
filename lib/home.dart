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
                Color(0xff614385),
                Color(0xff516395),
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
          child: Text("Emojis", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),),
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
            return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),itemCount: arrayData!.length, itemBuilder: (context, index){
              return TextButton(onPressed: (){
                Clipboard.setData(ClipboardData(text: arrayData[index]));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copy Success"), duration: Duration(milliseconds: 100),));
              }, child: Text(arrayData[index], style: Theme.of(context).textTheme.headline5,));
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
