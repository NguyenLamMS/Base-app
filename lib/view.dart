import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payment/home.dart';
import 'package:payment/payment.dart';

class View extends StatefulWidget {
  const View({Key? key, this.index = 0, this.color = Colors.red, this.contents = ""}) : super(key: key);
  final String contents;
  final int index;
  final Color color;
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View>{
  @override
  void initState() {
  // to hide both:
    SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);
    super.initState();
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    List<String> arrayContent = widget.contents.split('\n');
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          color: widget.color,
          child: RotatedBox(
            quarterTurns: 1,
            child: SizedBox.expand(child: FittedBox(fit: BoxFit.contain ,child: ViewStyle(widget.index, arrayContent))),
          ),
        ),
      ),
    );
  }
  Widget ViewStyle(index,List<String>  content){
    switch(index){
      case 0:
        return Rotate(content);
      case 1:
        return Fade(content);
      case 2:
        return Typer(content);
      case 3:
        return Typewriter(content);
      case 4:
        return Scale(content);
      case 5:
        return Colorize(content);
      case 6:
        return Wavy(content);
      case 7:
        return Flicker(content);
      default:
        return Rotate(content);
    }
  }
  Widget Rotate(List<String> content){
    var firt = content.first;
    content.removeAt(0);
    return Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(width: 20.0, height: 100.0),
          Text(
            firt,
            style: TextStyle(fontSize: 100.0, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 20.0, height: 100.0),
          content.length == 0 ? SizedBox.shrink() : DefaultTextStyle(
            style: const TextStyle(
              fontSize: 100.0,
              fontFamily: 'Horizon',
            ),
            child: AnimatedTextKit(
              animatedTexts: content.map((e) => RotateAnimatedText(e)).toList(),
            ),
          ),
        ],
      );
  }
  Widget Fade(List<String> content){
    return SizedBox(
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 100.0,
          fontWeight: FontWeight.bold,
        ),
        child: AnimatedTextKit(
          animatedTexts: content.map((e) => FadeAnimatedText(e)).toList(),
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }

  Widget Typer(List<String> content){
    return SizedBox(
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 100.0,
          fontFamily: 'Bobbers',
        ),
        child: AnimatedTextKit(
          animatedTexts: content.map((e) => TyperAnimatedText(e)).toList(),
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
  Widget Typewriter(List<String> content){
    return SizedBox(
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 100.0,
          fontFamily: 'Agne',
        ),
        child: AnimatedTextKit(
          animatedTexts: content.map((e) => TypewriterAnimatedText(e)).toList(),
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }

  Widget Scale(List<String> content){
    return SizedBox(
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 100.0,
          fontFamily: 'Canterbury',
        ),
        child: AnimatedTextKit(
          animatedTexts: content.map((e) => ScaleAnimatedText(e)).toList(),
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }
  Widget Colorize(List<String> content){
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 100.0,
      fontFamily: 'Horizon',
    );

    return SizedBox(
      child: AnimatedTextKit(
        animatedTexts: content.map((e) =>  ColorizeAnimatedText(
          e,
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
        )).toList(),
        isRepeatingAnimation: true,
        onTap: () {
          print("Tap Event");
        },
      ),
    );
  }
  Widget Wavy(List<String> content){
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 100.0,
      ),
      child: AnimatedTextKit(
        animatedTexts: content.map((e) => WavyAnimatedText(e)).toList(),
        isRepeatingAnimation: true,
        onTap: () {
          print("Tap Event");
        },
      ),
    );
  }

  Widget Flicker(List<String> content){
    return SizedBox(
    child: DefaultTextStyle(
      style: const TextStyle(
        fontSize: 100,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 7.0,
            color: Colors.white,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: content.map((e) => FlickerAnimatedText(e)).toList(),
        onTap: () {
          print("Tap Event");
        },
      ),
    ),
  );
  }
}
