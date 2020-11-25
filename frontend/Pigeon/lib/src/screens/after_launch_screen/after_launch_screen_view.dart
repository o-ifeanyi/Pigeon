import 'dart:async';

import 'package:Pigeon/src/data/local_database/db_provider.dart';
import 'package:Pigeon/src/data/providers/chats_provider.dart';
import 'package:Pigeon/src/screens/home/home_view.dart';
import 'package:Pigeon/src/screens/login/login_view.dart';
import 'package:Pigeon/src/utils/custom_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AfterLaunchScreen extends StatefulWidget {
  @override
  _AfterLaunchScreenState createState() => _AfterLaunchScreenState();
}

class _AfterLaunchScreenState extends State<AfterLaunchScreen> {
  void verifyUserLoggedInAndRedirect() async {
    String routeName = HomeScreen.routeName;
    String token = await CustomSharedPreferences.get('token');
    if (token == null) {
      routeName = LoginScreen.routeName;
    }
    var duration = new Duration(seconds: 2);
    Timer(duration, () {
      // In case user is already logged in, go to home_screen
      // otherwise, go to login_screen
      Navigator.of(context).pushReplacementNamed(routeName);
    });
  }

  @override
  void initState() {
    super.initState();
    DBProvider.db.database;
    verifyUserLoggedInAndRedirect();
  }

  @override
  void didChangeDependencies() {
    Provider.of<ChatsProvider>(context).updateChats();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Center(
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
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                "Made in India with ❤",
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
