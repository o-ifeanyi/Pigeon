import 'package:Pigeon/models/Users.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

Widget menuButtons(context) {
  return BottomAppBar(
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 60,
        ),
        IconButton(
          onPressed: () {},
          icon: new Image.asset(
            'assets/icons/Chat.png',
            height: 25,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: new Image.asset(
            'assets/icons/Search.png',
            height: 25,
          ),
        ),
        SizedBox(
          width: 60,
        ),
        IconButton(
          onPressed: () {
            Toast.show("Will open camera for status of send photos", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
          },
          icon: new Image.asset(
            'assets/icons/Camera.png',
            height: 25,
          ),
        ),
        IconButton(
            onPressed: () {
              Toast.show("Will open user profile", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            },
            icon: CircleAvatar(
              backgroundImage: AssetImage(user[0].imgURL),
            )),
      ],
    ),
    shape: CircularNotchedRectangle(),
    notchMargin: 6.0,
    color: Colors.white,
  );
}
