import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payment/payment.dart';

class RandomPassword extends StatefulWidget {
  const RandomPassword({Key? key}) : super(key: key);

  @override
  _RandomPasswordState createState() => _RandomPasswordState();
}

class _RandomPasswordState extends State<RandomPassword> {
  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> randomPerson() async {
    var dio = Dio();
    Response response = await dio.get('https://randomuser.me/api/');
    return response.data;
  }

  TextStyle textStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepPurpleAccent, Colors.deepOrange])),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FutureBuilder<dynamic>(
                  future: randomPerson(),
                  builder: (context, snapshot) {
                    Map<String, dynamic> listInfo = {};
                    if (snapshot.hasData) {
                      try {
                        listInfo = snapshot.data['results'][0];
                      } catch (e) {}
                      if (listInfo.length == 0) {
                        return Center(
                          child: Text("Server error !"),
                        );
                      }
                      List<dynamic> listPerson = [];
                      List<dynamic> listTitle = [];
                      listPerson.add(listInfo['name']['first'] + ' ' + listInfo['name']['last']);
                      listPerson.add(listInfo['gender']);
                      listPerson.add(listInfo['location']['street']['number'].toString() + ' ' + listInfo['location']['street']['name']);
                      listPerson.add(listInfo['location']['city']);
                      listPerson.add(listInfo['location']['state']);
                      listPerson.add(listInfo['location']['country']);
                      listPerson.add(listInfo['location']['postcode']);
                      listPerson.add(listInfo['email']);
                      listPerson.add(listInfo['dob']['date']);
                      listPerson.add(listInfo['dob']['age']);
                      listPerson.add(listInfo['phone']);
                      listPerson.add(listInfo['picture']['large']);
                      listTitle.add('Name');
                      listTitle.add('Gender');
                      listTitle.add('Street');
                      listTitle.add('City');
                      listTitle.add('State');
                      listTitle.add('Country');
                      listTitle.add('Postcode');
                      listTitle.add('Email');
                      listTitle.add('Birthday');
                      listTitle.add('Age');
                      listTitle.add('Phone');
                      listTitle.add('Avatar');
                      return Column(
                        children: [
                          Container(margin: EdgeInsets.all(8),height: 150, width: 150,child: ClipRRect(borderRadius: BorderRadius.circular(150),child: Image.network(listPerson.last, fit: BoxFit.contain,))),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index){
                                return  Container(
                                  padding: EdgeInsets.only(left: 16),
                                  color: Colors.white,
                                  margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                                  child: Row(
                                    children: [
                                      Expanded(flex: 5,child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(listTitle[index], style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w400),),
                                          Text(listPerson[index].toString(), style: textStyle, overflow: TextOverflow.clip,),
                                        ],
                                      )),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(onPressed: (){
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copy Success'), duration: Duration(milliseconds: 200),));
                                          Clipboard.setData(ClipboardData(text: listPerson[index]));
                                        }, icon: Icon(Icons.copy, size: 15,)),
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: listPerson.length,
                            ),
                          ),
                        ],
                      );
                    }
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  }),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CupertinoButton(child: Text("Generator", style: TextStyle(color: Colors.blue),), color: Colors.white, padding: EdgeInsets.all(8), onPressed: (){
                      randomPerson();
                      setState(() {
                      });
                    }),
                  ),
                  SizedBox(width: 8,),
                  Expanded(
                    child: CupertinoButton(child: Text("Donate", style: TextStyle(color: Colors.white),), color: Colors.deepPurpleAccent, padding: EdgeInsets.all(8), onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Payment()));
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
