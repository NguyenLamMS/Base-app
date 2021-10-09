import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:payment/payment.dart';
import 'package:payment/view.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Animated Text",
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
                style: TextStyle(color: Colors.white),
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
    ValueNotifier<Color> backgroundColor = ValueNotifier(Colors.red);
    int indexAnimation = 0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
          decoration: InputDecoration(
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
              hintText: "Enter content here"),
          scrollPadding: EdgeInsets.all(20),
          autofocus: false,
          maxLines: 10,
          controller: textFieldController,
          ),
          ValueListenableBuilder(
            valueListenable: backgroundColor,
            builder: (context, value, child){
              return Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                height: 100,
                width: double.infinity,
                child: CupertinoButton(child: Text("Backgound Color"), color: backgroundColor.value,onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Select colors'),
                        content: SingleChildScrollView(
                          child: BlockPicker(
                            pickerColor: Colors.red,
                            onColorChanged: (color){
                              backgroundColor.value = color;
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },),
              );
            },
          ),
          Expanded(
            child: Container(
              child: Center(
                child: CupertinoPicker(
                  children: [
                    Center(child: Text("Rotate")),
                    Center(child: Text("Fade")),
                    Center(child: Text("Typer")),
                    Center(child: Text("Typewriter")),
                    Center(child: Text("Scale")),
                    Center(child: Text("Colorize")),
                    Center(child: Text("Wavy")),
                    Center(child: Text("Flicker")),
                  ],
                  itemExtent: 50,
                  onSelectedItemChanged: (index){
                    indexAnimation = index;
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: CupertinoButton(
                child: Text("Start"),
                onPressed: () async {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => View(color: backgroundColor.value, contents: textFieldController.text, index: indexAnimation,)));
                },
                color: Colors.blue)
            ),
        ],
      ),
    );
  }
}
