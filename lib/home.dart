import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:payment/diamond.dart';
import 'package:payment/payment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  late Map<dynamic, dynamic> citys ;
  Random random = Random();
  late AnimationController controller;
  late Animation flip_animation;
  static const FRONT = "assets/images/ngua.png";
  static const BACK = "assets/images/sap.png";
  var image = FRONT.obs;
  var result = "Welcome".obs;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 5));
    flip_animation = Tween(begin: 0.0, end: 15).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    controller.addListener(() {
      if(flip_animation.value.round() % 2 == 0){
        image.value = FRONT;
      }else{
        image.value = BACK;
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Diamond diamond = Get.put(Diamond.instance);
    return Scaffold(
      backgroundColor: Color(0xffe9e8eb),
      body: SafeArea(
        child: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/images/plate.png")),
          Center(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child){
                return Transform(transform: Matrix4.identity()..rotateY(2 * pi * flip_animation.value), alignment: Alignment.center ,child: Obx(()=>Image.asset(image.value)));
              },
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                TextButton(onPressed: (){
                  Get.to(() => Payment(diamond: diamond));
                }, child: Text("Buy Diamonds")),
                CupertinoButton(onPressed: (){
                  if(diamond.diamondTotal.value > 0){
                    controller.reset();
                    result.value = "Um ba la...";
                    if(Random().nextInt(2) == 1){
                      flip_animation = Tween(begin: 0.0, end: 15).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
                      controller.forward().then((value){
                        result.value = 'Back';
                      });
                    }else{
                      flip_animation = Tween(begin: 0.0, end: 14).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
                      controller.forward().then((value){
                        result.value = 'Front';
                      });
                    }
                  }
                 diamond.subDiamond(1);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Toss ('),
                    FaIcon(FontAwesomeIcons.gem, size: 15,),
                    SizedBox(width: 4,),
                    Text("1)")
                  ],
                ), color: Colors.blue,),
              ],
            )),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Toss a coin", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.gem, size: 15,),
                  SizedBox(width: 4,),
                  Obx(() => Text(diamond.diamondTotal.value.toString(), style: Theme.of(context).textTheme.button,))
                ],
              )
            ],
          )),
          Positioned(child: Container(alignment: Alignment.center ,child: Obx(() => Text(result.value, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 50),))), top: 100, left: 0, right: 0,)
        ],
    ),
  ));
  }
}

