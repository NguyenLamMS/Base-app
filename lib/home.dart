import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
  late List<dynamic> listData;
  Random random = Random();
  var loading = false.obs;
  Map<String, String> listImage = {
    "https://images.pexels.com/photos/1214259/pexels-photo-1214259.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940": "1",
    "https://images.pexels.com/photos/1433052/pexels-photo-1433052.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940": "Free",
    "https://images.pexels.com/photos/719396/pexels-photo-719396.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940": "1",
    "https://images.pexels.com/photos/1591447/pexels-photo-1591447.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1": "Free",
    "https://images.pexels.com/photos/1226302/pexels-photo-1226302.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940": "1",
    "https://images.pexels.com/photos/3879071/pexels-photo-3879071.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940": "1",
    "https://images.pexels.com/photos/1723637/pexels-photo-1723637.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940": "Free",
    "https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940": "1",
    "https://images.pexels.com/photos/1067333/pexels-photo-1067333.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940": "1",
    "https://images.pexels.com/photos/2362002/pexels-photo-2362002.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940": "Free",
    "https://images.pexels.com/photos/2469122/pexels-photo-2469122.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940": "1",
    "https://images.pexels.com/photos/1955134/pexels-photo-1955134.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940": "Free",
    "https://images.pexels.com/photos/6848720/pexels-photo-6848720.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260": "1",
    "https://images.pexels.com/photos/1591382/pexels-photo-1591382.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940": "1",
  };
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Diamond diamond = Get.put(Diamond.instance);
    List<String> listUrl = listImage.keys.toList();
    List<String> prices = listImage.values.toList();
    return Scaffold(
      backgroundColor: Color(0xff191e31),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
            children: [
              MyAppBar(diamond: diamond),
              Expanded(
                child: ListView.builder(itemBuilder: (context, int index){
                  return Container(
                    padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 200,
                      child: Stack(children: [
                        Positioned.fill(child: Image.network(listUrl[index], fit: BoxFit.cover,)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: TextButton(
                                onPressed: () async {
                                  if(prices[index].contains("Free")){
                                    setWallpaper(listUrl[index]);
                                  }else{
                                    if(diamond.diamondTotal.value > 0){
                                      setWallpaper(listUrl[index]);
                                    }
                                    int price = int.parse(prices[index]);
                                    diamond.subDiamond(price);
                                  }
                              }, child: Text('Set Background'), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white54)),),
                            ),
                            Row(
                              children: [
                                FaIcon(FontAwesomeIcons.gem, color: Colors.white, size: 15,),
                                SizedBox(width: 4,),
                                Text(prices[index], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                                SizedBox(width: 4,),
                              ],
                            )
                          ],
                        ),
                      ],)
                  );
                }, itemCount: listImage.length,),
              )
            ],
    ),
            Center(
              child: Obx(() => loading.value ? Container(
                width: 100,
                height: 100,
                color: Colors.white54,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8,),
                    Text("Process...")
                  ],
                ),
              ) : SizedBox.shrink())
            )
          ],
        ),
      ));
  }
  Future setWallpaper(String url) async {
      loading.value = true;
      var file = await DefaultCacheManager().getSingleFile(url);
      await AsyncWallpaper.setWallpaperFromFile(file.path, AsyncWallpaper.HOME_SCREEN);
      loading.value = false;
      Get.snackbar("Success", "Set Wallpaper Success");
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
    required this.diamond,
  }) : super(key: key);

  final Diamond diamond;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("Random Quotes", style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: (){
                  Get.to(() => Payment(diamond: diamond));
                },
                child: Container(
                  child: Text("Buy Diamonds", style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white)),
                ),
              ),
              InkWell(
                onTap: (){
                  Get.to(() => Payment(diamond: diamond,));
                },
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.gem, size: 16, color: Colors.white,),
                    SizedBox(width: 4,),
                    Obx(() => Text(diamond.diamondTotal.toString(), style: Theme.of(context).textTheme.button?.copyWith(color: Colors.white)))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
