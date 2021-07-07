import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            CupertinoTextField(
              maxLines: 5,
              minLines: 5,
              placeholder: "Input",
              controller: textEditingController,
            ),
            Expanded(child: Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.2, color: Colors.grey),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(padding: EdgeInsets.all(8),child: SingleChildScrollView(child: Text(textValue, style: TextStyle(color: colorText, fontSize: 16)))),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(child: Text("Encode"), onPressed: (){
                  if(textEditingController.text.isEmpty) return;
                  setState(() {
                    textValue = textToBinary(text: textEditingController.text);
                    colorText = Colors.black;
                  });

                }, color: Colors.red,),
                CupertinoButton(child: Text("Donate"), onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Payment()));
                }, color: Colors.cyan,),
              ],
            )
          ],
        ),
      ),
    ));
  }

  String textToBinary({required String text}) {
    return text.codeUnits.map((e) => e.toRadixString(2).padLeft(8, '0')).join(" ");
  }
}
