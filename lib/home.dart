import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Column(
        children: [
          Container(height: 50,child: HomeAppBar()),
          Expanded(child: HomeBody())
        ],
      ),
    ),);
  }
  Widget HomeAppBar(){
    return Row(
      children: [
        Text("")
      ],
    );
  }
  Widget HomeBody(){
    return Placeholder();
  }
}
