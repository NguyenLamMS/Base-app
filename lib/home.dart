import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:payment/payment.dart';
import 'package:payment/view.dart';
import 'package:state_notifier/state_notifier.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 50, child: HomeAppBar(context)),
            Expanded(child: HomeBody(context))
          ],
        ),
      ),
    );
  }

  Widget HomeAppBar(context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Text To Speech",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Payment()));
              },
              child: Text(
                'Donate',
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
    );
  }

  Widget HomeBody(context) {
    var inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.teal));
    var textFieldController = TextEditingController();
    ValueNotifier<bool> isSpeech = ValueNotifier(false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
            decoration: InputDecoration(
                enabledBorder: inputBorder,
                focusedBorder: inputBorder,
                hintText: "Enter content here"),
            scrollPadding: EdgeInsets.all(20),
            autofocus: true,
            maxLines: 10,
            controller: textFieldController,
          )),
          CupertinoButton(child: Text("Color"), onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Select colors'),
                  content: SingleChildScrollView(
                    child: BlockPicker(
                      pickerColor: Colors.red,
                      onColorChanged: (color){},
                    ),
                  ),
                );
              },
            );
          },),
          Expanded(
            flex: 1,
            child: Container(
              child: Center(
                child: CupertinoPicker(
                  children: [
                    Text("Item 0"),
                    Text("Item 1"),
                    Text("Item 2"),
                    Text("Item 3"),
                    Text("Item 4"),
                    Text("Item 5"),
                    Text("Item 6"),
                    Text("Item 7"),
                  ],
                  itemExtent: 50,
                  onSelectedItemChanged: (index){
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: ValueListenableBuilder(
              valueListenable: isSpeech,
              builder: (context, value, child) {
                return CupertinoButton(
                    child: Text(isSpeech.value ? "Stop" : "Speech"),
                    onPressed: () async {
                      isSpeech.value = !isSpeech.value;
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => View()));
                    },
                    color: isSpeech.value ? Colors.red : Colors.teal);
              },
            ),
          )
        ],
      ),
    );
  }
}
