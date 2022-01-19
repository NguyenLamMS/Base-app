import 'dart:convert';
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

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Diamond diamond = Get.put(Diamond.instance);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Text('Convert uppercase lowercase'),
                Row(
                  children: [

                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
