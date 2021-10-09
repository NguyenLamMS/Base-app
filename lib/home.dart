import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:payment/payment.dart';
import 'package:state_notifier/state_notifier.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Column(
        children: [
          Container(height: 50,child: HomeAppBar(context)),
          Expanded(child: HomeBody(context))
        ],
      ),
    ),);
  }
  Widget HomeAppBar(context){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xffd8b5ff),
            Color(0xff1eae98),
          ]
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 8),child: Text("Text To Speech", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),)),
          TextButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Payment()));
          }, child: Text('Donate', style: TextStyle(color: Colors.deepPurpleAccent),))
        ],
      ),
    );
  }
  Widget HomeBody(context){
    var inputBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.teal));
    var textFieldController = TextEditingController();
    FlutterTts flutterTts = FlutterTts();
    ValueNotifier<bool> isSpeech = ValueNotifier(false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(child: TextField(decoration: InputDecoration(enabledBorder: inputBorder, focusedBorder: inputBorder, hintText: "Enter content here"), scrollPadding: EdgeInsets.all(20), autofocus: true, maxLines: 999, controller: textFieldController,)),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: ValueListenableBuilder(
              valueListenable: isSpeech,
              builder: (context, value, child){
                return CupertinoButton(child: Text(isSpeech.value ? "Stop" : "Speech"), onPressed: () async {
                  isSpeech.value = !isSpeech.value;
                  if(!textFieldController.text.isEmpty){
                    if(isSpeech.value){
                      flutterTts.speak(textFieldController.text);
                    }
                  }
                  if(!isSpeech.value){
                    flutterTts.stop();
                  }
                }, color: isSpeech.value ? Colors.red :Colors.teal);
              },
            ),
          )
        ],
      ),
    );
  }
}
