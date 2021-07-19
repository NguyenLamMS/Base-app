import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}
const List<String> _kProductIds = <String>[
  "one_week",
  "one_month",
  "three_month",
  "six_month",
  "one_year"
];

class _PaymentState extends State<Payment> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
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
      return Card();
    }
    List<Widget> productList = <Widget>[];
    productList.add(Card(
      child: ListTile(
        title: Image.asset('assets/icons/donate.png', width: 150, height: 150),
        subtitle: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'You can donate to me so that i can have funds to develop other apps.',
            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ));
    Map<String, PurchaseDetails> purchases = Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
    productList.addAll(_products.map(
      (ProductDetails productDetails) {
        PurchaseDetails? previousPurchase = purchases[productDetails.id];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
                title: Text(
                  productDetails.title,
                ),
                subtitle: Text(
                  productDetails.description,
                ),
                trailing: previousPurchase != null
                    ? Icon(Icons.check)
                    : TextButton(
                        child: Text(productDetails.price),
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          late PurchaseParam purchaseParam;
                          purchaseParam = PurchaseParam(
                            productDetails: productDetails,
                            applicationUserName: null,
                          );
                          _inAppPurchase.buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
                        },
                      )),
          ),
        );
      },
    ));

    return Column(children: productList);
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
        _notFoundIds = [];
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
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
