import 'dart:ui';
import 'package:Pigeon/models/Users.dart';
import 'package:Pigeon/widgets/menuButton.dart';
import 'package:Pigeon/widgets/userChats.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xff2AD266),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffFBFBFD),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: ListView.builder(
          itemCount: user.length,
          itemBuilder: (BuildContext context, int index) {
            return userChats(index, context);
          },
        ),
      ),
      bottomNavigationBar: menuButtons(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Create/Add: Contacts,status,group',
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Color(0xff2AD266),
        elevation: 2.0,
      ),
    );
  }
}
