import 'package:Pigeon/models/Users.dart';
import 'package:Pigeon/screens/storyView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

Widget onlineMissedCallStatus(
    bool isonline, bool isMissedCall, bool haveStatus) {
  if (isMissedCall) {
    return Positioned(
      top: haveStatus ? 40.0 : 34,
      left: haveStatus ? 40.0 : 34,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 10.0,
        child: CircleAvatar(
          child: Icon(
            Icons.call_missed,
            size: 12,
            color: Colors.white,
          ),
          radius: 8.0,
          backgroundColor: Color(0xffFD7171),
        ),
      ),
    );
  } else if (isonline) {
    return Positioned(
      top: haveStatus ? 40.0 : 38,
      left: haveStatus ? 40.0 : 38,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 8.0,
        child: CircleAvatar(
          radius: 6.0,
          backgroundColor: logoColor,
        ),
      ),
    );
  } else {
    return Container();
  }
}

Widget userChats(index, context) {
  return Dismissible(
    // ignore: missing_return
    confirmDismiss: (direction) async {
      if (direction == DismissDirection.endToStart) {
        final bool res = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(
                    "Are you sure you want to delete ${user[index].name}?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      // setState(() {
                      //   itemsList.removeAt(index);
                      // });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
        return res;
      } else {}
    },
    background: Container(
      color: Color(0xffF3F3F3),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            CircleAvatar(
              radius: 16,
              backgroundColor: logoColor,
              child: Icon(
                Icons.videocam,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    ),
    secondaryBackground: Container(
      color: Color(0xffF3F3F3),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            CircleAvatar(
              radius: 16,
              backgroundColor: logoColor,
              child: Icon(
                Icons.call,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    ),
    key: Key(user[index].name),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: user[index].haveStatus ? 29 : 26,
                    backgroundColor: logoColor,
                    child: CircleAvatar(
                      radius: user[index].haveStatus ? 28 : 26,
                      backgroundColor:
                          user[index].haveStatus ? Colors.white : null,
                      child: GestureDetector(
                        onTap: () {
                          // Toast.show("Will show user pic", context,
                          //     duration: Toast.LENGTH_LONG,
                          //     gravity: Toast.CENTER);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoryViewer()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 26.0,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                            user[index].imgURL,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onlineMissedCallStatus(
                      user[index].isOnline,
                      user[index].isMissedCall,
                      user[index].haveStatus), // Is Online Function
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // sender Name
                    Text(
                      user[index].name,
                      style: TextStyle(
                          fontWeight: FontWeight.w900, color: primaryColor),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    // Messages
                    Text(
                      user[index].msg,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    // Last seen
                    Text(
                      '02:53 PM',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              user[index].isRead
                  ? Container(
                      child: Text(''),
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: 18.0,
                      width: 18.0,
                      child: Text(
                        user[index].noOfMsgUnRead,
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xff2AD266),
                          borderRadius: BorderRadius.circular(20)),
                    ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                user[index].time,
                style: TextStyle(color: Colors.grey, fontSize: 10.0),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
