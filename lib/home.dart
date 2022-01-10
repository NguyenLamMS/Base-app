import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payment/payment.dart';

import 'diamond.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Column(
        children: [
          Container(height: 50,child: HomeAppBar(context)),
          Expanded(child: HomeBody())
        ],
      ),
    ),);
  }
  Widget HomeAppBar(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("My App", style: Theme.of(context).textTheme.button?.copyWith(fontSize: 18),),
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Payment()));
            },
            child: Container(
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.solidGem, color: Colors.blue, size: 15,),
                  SizedBox(width: 5,),
                  Text("0", style: Theme.of(context).textTheme.button,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget HomeBody(){
    return Row(
      children: [
        Text("diamon : " + Diamond.instance.getDiamond().toString()),
        CupertinoButton(child: Text('up'), onPressed: (){
          Diamond.instance.sumDiamond(10);
          print(Diamond.instance.getDiamond());
        }),
        CupertinoButton(child: Text('down'), onPressed: (){
          Diamond.instance.subDiamond(1);
          print(Diamond.instance.getDiamond());
        })
      ],
    );
  }
}
