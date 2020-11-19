import 'package:Pigeon/widgets/menuButton.dart';
import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';

import '../constants.dart';

class CurrentUserProfile extends StatefulWidget {
  @override
  _CurrentUserProfileState createState() => _CurrentUserProfileState();
}

class _CurrentUserProfileState extends State<CurrentUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Text("hello"),
      )),
      bottomNavigationBar: menuButtons(context),
    );
  }
}
