import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payment/payment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<dynamic> listData;
  String quote = "Welcome";
  String image ="image1.jpg";
  Random random = Random();
  List<String> listImage = ["image1.jpg", "image2.jpg", "image3.jpg", "image4.jpg", "image5.jpg"];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                  child: Image.asset(
                "assets/images/" + image,
                fit: BoxFit.cover,
              )),
              Positioned.fill(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.grey.withOpacity(0.05),
                  alignment: Alignment.center,
                  child: FutureBuilder<List<dynamic>>(
                    future: readData(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                       listData = snapshot.data!;
                       quote = listData[random.nextInt(listData.length)];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                           quote,
                            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator(color: Colors.deepOrangeAccent,));
                    }
                  ),
                ),
              ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(child: Text("Random"), onPressed: () {
                setState(() {
                  quote = listData[random.nextInt(listData.length)];
                  image = listImage[random.nextInt(listImage.length)];
                });
              }, color: Colors.red),
              CupertinoButton(child: Text("Donate"), onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Payment()));
              }, color: Colors.cyan),
            ],
          ),
        )
      ],
    ));
  }
  Future<List<dynamic>> readData() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/data/data.json");
    final jsonResult = json.decode(data);
    List<dynamic> result = jsonResult["data"].toList();
    return result;
  }
}
