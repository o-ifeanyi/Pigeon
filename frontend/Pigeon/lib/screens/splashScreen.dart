import 'dart:async';
import 'package:Pigeon/constants.dart';
import 'package:Pigeon/screens/registrationScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegistrationScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Hero(
          tag: 'animatedLogo',
          child: Container(
            child: Image.asset(
              'assets/images/15022019-21.jpg',
              height: 200,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    startTimer();
  }
}
