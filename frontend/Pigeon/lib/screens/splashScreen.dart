import 'dart:async';
import 'package:Pigeon/constants.dart';
import 'package:Pigeon/screens/homeScreen.dart';
import 'package:Pigeon/screens/registrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// bool isLoggedIn = false;
String authToken;

class SplashScreen extends StatefulWidget {
  static const String splashPageRoute = "SPLASH_PAGE_ROUTE";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLoggedIn();
    startTimer();
  }

  startTimer() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, () {
      authToken == ""
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegistrationScreen(),
              ),
            )
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  authToken: authToken,
                ),
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

isLoggedIn() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // isLoggedIn = sharedPreferences.getBool("IS_LOGGED_IN") ?? false;
  authToken = sharedPreferences.getString("AUTH_TOKEN") ?? "";
}
