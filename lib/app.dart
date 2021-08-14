import 'package:flutter/material.dart';
import 'package:payment/random_password.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RandomPassword();
  }
}
