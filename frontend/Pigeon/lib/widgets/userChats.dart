import 'dart:convert';
import 'dart:typed_data';

import 'package:Pigeon/models/Users.dart';
import 'package:Pigeon/screens/chatScreen.dart';
import 'package:Pigeon/screens/storyView.dart';
import 'package:Pigeon/screens/videoCallScreen.dart';
import 'package:flutter/material.dart';
import 'package:Pigeon/configs/assets.dart';

import '../constants.dart';

Widget onlineMissedCallStatus(
    bool isOnline, bool isMissedCall, bool haveStatus) {
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
  } else if (isOnline) {
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

Widget userChats(context, Users friend) {
  Uint8List decodedBase64ImgOfFriend = base64.decode(friend.imgURL);
  return Dismissible(
    // ignore: missing_return
    confirmDismiss: (direction) async {
      if (direction == DismissDirection.endToStart) {
        final bool res = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Make an audio call to ${friend.name}?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "no, cancel it",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Yes, sure",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VideoCallScreen(),
                        ),
                      );
                    },
                  ),
                ],
              );
            });
        return res;
      } else {
        final bool res = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Make a video call to ${friend.name}?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "no, cancel it",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Yes, sure",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VideoCallScreen(),
                        ),
                      );
                    },
                  ),
                ],
              );
            });
        return res;
      }
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
    key: Key(friend.name),
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatScreen(friend: friend),
        ),
      ),
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
                      radius: friend.haveStatus ? 29 : 26,
                      backgroundColor: logoColor,
                      child: CircleAvatar(
                        radius: friend.haveStatus ? 28 : 26,
                        backgroundColor:
                            friend.haveStatus ? Colors.white : null,
                        child: GestureDetector(
                          onTap: () {
                            friend.haveStatus
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StoryViewer()),
                                  )
                                : showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            color: Colors.white,
                                          ),
                                          height: MediaQuery.of(context)
                                                  .devicePixelRatio *
                                              107,
                                          width: MediaQuery.of(context)
                                                  .devicePixelRatio *
                                              90,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                child: Image.asset(
                                                  "assets/images/people/Ankit_sagar_4027f99669eac45eae5027722524d2caa37d0c1b.jpeg",
                                                  fit: BoxFit.contain,
                                                ),
                                              ),

                                              // Image.memory(
                                              //   decodedBase64ImgOfFriend,
                                              // ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: null,
                                                    child: Container(
                                                      height: 50,
                                                      width: 50,
                                                      child: Center(
                                                        child: Image.asset(
                                                          Assets.audioCall,
                                                          scale: 5,
                                                          color: MyColors
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () =>
                                                        {print("video")},
                                                    child: Container(
                                                      height: 50,
                                                      width: 50,
                                                      child: Center(
                                                        child: Image.asset(
                                                          Assets.videoCall,
                                                          scale: 5,
                                                          color: MyColors
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: null,
                                                    child: Container(
                                                      height: 50,
                                                      width: 50,
                                                      child: Center(
                                                        child: Image.asset(
                                                          Assets.forward,
                                                          scale: 4,
                                                          color: MyColors
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                          },
                          child: CircleAvatar(
                            radius: 26.0,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                                "assets/images/people/Ankit_sagar_4027f99669eac45eae5027722524d2caa37d0c1b.jpeg"),
                            // Image.memory(
                            //   decodedBase64ImgOfFriend,
                            // ),
                          ),
                        ),
                      ),
                    ),
                    onlineMissedCallStatus(friend.isOnline, friend.isMissedCall,
                        friend.haveStatus), // Is Online Function
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // sender Name
                      Text(
                        friend.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.grey[800]),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      // Messages
                      Text(
                        //TODO: update this chat show at user as last msg
                        // chat[chat.length - 1].msg.substring(0, 20) + "...",
                        "Hello brother",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      // Last seen
                      Text(
                        friend.time,
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
                friend.isRead
                    ? Container(
                        child: Text(''),
                      )
                    : Container(
                        alignment: Alignment.center,
                        height: 18.0,
                        width: 18.0,
                        child: Text(
                          friend.noOfMsgUnRead,
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
                        ),
                        decoration: BoxDecoration(
                            color: MyColors.primaryColor,
                            // color: Color(0xff2AD266),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  friend.time,
                  style: TextStyle(color: Colors.grey, fontSize: 10.0),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
