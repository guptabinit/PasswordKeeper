import 'dart:async';

import 'package:flutter/material.dart';

import 'loginPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 1),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pink,
        child: const Center(
            child: Text(
          'Password\nKeeper',
          style: TextStyle(
              fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
