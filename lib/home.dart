import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:payment/dataController.dart';
import 'package:payment/diamond.dart';
import 'package:payment/payment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Map<dynamic, dynamic> citys ;
  Random random = Random();
  late TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Diamond diamond = Get.put(Diamond.instance);
    DataController dataController = Get.put(DataController(context: context));
    return Scaffold(
      backgroundColor: Color(0xff202230),
      body: SafeArea(
        child: Column(
        children: [
          MyAppBar(diamond: diamond),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CupertinoTextField(
              autofocus: false,
              placeholder: 'Search',
              controller: textEditingController,
              onChanged: (value){
                dataController.searchData(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() => dataController.listSearch.length != 0 ? ListView.builder(itemBuilder: (context, index){
              return Card(
                child: ListTile(
                  title: Text('City: ' + dataController.listSearch[index]['city'].toString()),
                  subtitle: Text('Zipcode: ' + dataController.listSearch[index]['zip_code'].toString()),
                  trailing: TextButton(onPressed: () => showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: Text('Notify'),
                      content: Text('More content with 1 diamond'),
                      actions: [
                         TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                              if(diamond.diamondTotal.value > 0){
                                showModalBottom(context, dataController.listSearch[index]);
                              }
                              diamond.subDiamond(1);
                            },
                            child: const Text('OK'),
                          ),
                      ],
                    );
                  }), child: Text('More'),),
                ),
              );
            }, itemCount: dataController.listSearch.length,) : Center(child: Text('Loading...', style: TextStyle(color: Colors.white),),))
          ),
        ],
    ),
      ));

  }


  showModalBottom(context, var item){

    showModalBottomSheet(context: context, builder: (context){
      return Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            height: 50,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black, width: 0.1))
            ),
            child: Text('City: ' + item['city'].toString()),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 50,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black, width: 0.1))
            ),
            child: Text('Zip code: ' + item['zip_code'].toString()),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 50,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black, width: 0.1))
            ),
            child: Text('Latitude: ' + item['latitude'].toString()),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 50,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black, width: 0.1))
            ),
            child: Text('Longitude: ' + item['longitude'].toString()),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 50,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black, width: 0.1))
            ),
            child: Text('State: ' + item['state'].toString()),
          ),
          Container(
            padding: EdgeInsets.all(8),
            height: 50,
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black, width: 0.1))
            ),
            child: Text('County: ' + item['county'].toString()),
          ),
        ],
      );
    });
  }

}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
    required this.diamond
  }) : super(key: key);
  final Diamond diamond;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Text("USA Zip Code", style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),),
                  SizedBox(width: 4,),
                  FaIcon(FontAwesomeIcons.flagUsa, color: Colors.white, size: 15,)
                ],
              ),
              InkWell(
                onTap: (){
                  Get.to(() => Payment(diamond: diamond,));
                },
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.gem, size: 16, color: Colors.white,),
                    SizedBox(width: 4,),
                    Obx(() => Text(diamond.diamondTotal.toString(), style: Theme.of(context).textTheme.button?.copyWith(color: Colors.white)))
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 4,),
          InkWell(child: Text("Buy Diamonds", style: TextStyle(color: Colors.white),), onTap: () => Get.to(() => Payment(diamond: diamond)),)
        ],
      ),
    );
  }
}
