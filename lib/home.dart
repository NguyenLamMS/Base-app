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
  late Map<String, dynamic> listBaseData;
  late Map<String, dynamic> listData;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    listBaseData = Map();
    listData = Map();
    loadJson().then((value){
      setState(() {
        listBaseData = value;
        listData = Map.from(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Payment()));
        },
        child: Icon(CupertinoIcons.money_dollar_circle),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Phone Code",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                CupertinoTextField(
                  onChanged: (text) {
                    search(text: text);
                  },
                  controller: textEditingController,
                  placeholder: "Search...",
                  prefix: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: Icon(
                      CupertinoIcons.search,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              listData.keys.elementAt(index),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            Text("+" + listData.values.elementAt(index),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16))
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      )),
    );
  }

  Future<Map<String, dynamic>> loadJson() async {
    String data = await rootBundle.loadString('assets/data/data.json');
    Map<String, dynamic> result = json.decode(data);
    return result;
  }

  search({required String text}) {
    listData.clear();
    print(text);
    if (text.isEmpty) {
      listData = Map.from(listBaseData);
      setState(() {});
      return;
    }
    listBaseData.forEach((key, value) {
      if (key.toLowerCase().contains(text.toLowerCase())) {
        listData.addAll({key: value});
      }
    });
    setState(() {});
  }
}
