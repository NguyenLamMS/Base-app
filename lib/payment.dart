import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}
const Map<String, String> _typeProductIds = {
  "donate_1" : "item",
  "donate_2" : "item",
  "one_week" : "sub",
  "android.test.purchased" : "sub",
  "android.test.item_unavailable" : "item",
  "android.test.refunded" : "sub",
};
const Map<String, String> _diamond = {
  "donate_1" : "69",
  "donate_2" : "139",
  "one_week" : "349",
  "android.test.purchased" : "699",
  "android.test.item_unavailable" : "3499",
  "android.test.refunded" : "6999",
};

class _PaymentState extends State<Payment> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<ProductDetails> _subcription = [];
  List<PurchaseDetails> _purchases = [];
  bool _isAvailable = false;
  bool _loading = true;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {});
    initStoreInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView(
      children: [_buildProductList()],
    ));
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Widget _buildProductList() {
    if (_loading) {
      return Card(child: (ListTile(leading: CircularProgressIndicator(), title: Text('Fetching products...'))));
    }
    if (!_isAvailable) {
      return Card(child: Container(padding: EdgeInsets.all(16),alignment: Alignment.center,child: Text("Play store not available", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.deepOrange),)));
    }

    List<Widget> productList = <Widget>[];
    List<Widget> subcriptionList = <Widget>[];
    Map<String, PurchaseDetails> purchases = Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));

    productList.addAll(_products.map((e){
      if(_typeProductIds[e.id] == "item"){
        return itemProduct("10", e.price, (){
          PurchaseParam purchaseParam = PurchaseParam(productDetails: e);
          _inAppPurchase.buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
        });
      }
      return SizedBox.shrink();
    }));
    subcriptionList.addAll(_products.map((e){
      if(_typeProductIds[e.id] == "sub"){
        return itemSubcription(e.title, e.description, e.price, (){
          PurchaseParam purchaseParam = PurchaseParam(productDetails: e);
          _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
        });
      }
      return SizedBox.shrink();
    }));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset("assets/icons/banner.png", ),
            ),
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back))
            ]
          ),
          Text("Buy Diamond", style: Theme.of(context).textTheme.button,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
                children: productList
            ),
          ),
          Text("Subscription", style: Theme.of(context).textTheme.button,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
                children: subcriptionList
            ),
          ),
          Text("Note", style: Theme.of(context).textTheme.button,),
          Text("\n- Diamonds are used to activate the functionality of the app. If you want to use all the functions of the app buy diamonds to unlock them\n", style: Theme.of(context).textTheme.caption,),
          Text("- Subscription packages by week, month by month, and year by year for people who use the app a lot, will save money\n", style: Theme.of(context).textTheme.caption,),
          Text("- Subscriptions will automatically renew, you can cancel them in the play store", style: Theme.of(context).textTheme.caption,),
        ],
      ),
    );
  }

  Widget itemProduct(String diamond, String price, Function onTap){
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(FontAwesomeIcons.solidGem, size: 15, color: Colors.blue,),
                  SizedBox(width: 5,),
                  Text(diamond, style: Theme.of(context).textTheme.bodyText1,)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(price, style: Theme.of(context).textTheme.caption,),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemSubcription(String title ,String subtitle, String price, Function onTap){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: TextButton(
            child: Text(price),
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              primary: Colors.white,
            ),
            onPressed: (){
              onTap();
            },
          ),
        ),
      ),
    );
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print("pedding...");
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          print("Error...");
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          print("Success...");
        }
      }
      if (purchaseDetails.pendingCompletePurchase) {
        print("Complete...");
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    });
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _subcription = [];
        _notFoundIds = [];
        _loading = false;
      });
      return;
    }
    ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(_typeProductIds.keys.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _subcription = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _loading = false;
      });

    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _subcription = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _loading = false;
      });
      return;
    }
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _loading = false;
    });
  }
}
