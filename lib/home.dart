import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:payment/data_controller.dart';
import 'package:payment/diamond.dart';
import 'package:payment/payment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Diamond diamond = Get.put(Diamond.instance);
    final DataController dataController = Get.put(DataController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("USA Zipcode", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                      InkWell(
                        onTap: (){
                          Get.to(() => Payment(diamond: diamond));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                FaIcon(FontAwesomeIcons.gem, size: 15, color: Colors.white,),
                                SizedBox(width: 4,),
                                Obx(() => Text(diamond.diamondTotal.value.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)),
                              ],
                            ),
                            Text('Buy Diamonds', style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              CupertinoTextField(placeholder: 'Search',),
              SizedBox(height: 8,),
              Expanded(child: Obx(() => ListView.builder(
                itemBuilder: (context, index){
                return Card(
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('City: ' + dataController.listDataSearch[index]['city'].toString(), style: TextStyle(fontSize: 16),),
                            SizedBox(height: 4,),
                            Text('Zip code: ' + dataController.listDataSearch[index]['zip_code'].toString())
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            if(diamond.diamondTotal.value > 0){
                              ShowDialog(dataController.listDataSearch[index]);
                            }
                            diamond.subDiamond(1);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('More', style: TextStyle(color: Colors.blue),),
                              Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.gem, size: 15, color: Colors.blue,),
                                  SizedBox(width: 4,),
                                  Text('1', style: TextStyle(color: Colors.blue),)
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }, itemCount: dataController.listDataSearch.length,)))
            ],
          ),
        ),
      ),
    );
  }
  void ShowDialog(var item){
    showModalBottomSheet(context: context, builder: (context){
      return Column(
        children: [
          Container(
            height: 50,
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text('City: ' + item['city'].toString()),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text('Zip Code: ' + item['zip_code'].toString()),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text('Longitude: ' + item['longitude'].toString()),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))
            ),
          ),          Container(
            height: 50,
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text('Latitude: ' + item['latitude'].toString()),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text('State: ' + item['state'].toString()),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text('County: ' + item['county'].toString()),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))
            ),
          )
        ],
      );
    });
  }
}

