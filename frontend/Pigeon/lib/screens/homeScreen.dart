import 'dart:convert';
import 'dart:ui';
import 'package:Pigeon/models/Users.dart';
import 'package:Pigeon/widgets/menuButton.dart';
import 'package:Pigeon/widgets/userChats.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final String authToken;

  const HomeScreen({Key key, this.authToken}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var json;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    http.get(
      nodeEndPoint + "/api/posts",
      headers: {
        "auth-token": widget.authToken,
      },
    ).then((res) async => {
          json = jsonDecode(res.body),
        });
  }

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
        onPressed: () {
          Toast.show(json['name'], context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        },
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
