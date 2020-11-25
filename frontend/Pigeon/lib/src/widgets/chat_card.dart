import 'dart:convert';
import 'dart:math';

import 'package:Pigeon/config/assets.dart';
import 'package:Pigeon/src/data/models/chat.dart';
import 'package:Pigeon/src/data/providers/chats_provider.dart';
import 'package:Pigeon/src/screens/contact/contact_view.dart';
import 'package:Pigeon/src/utils/dates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;

  final format = new DateFormat("HH:mm");

  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.lightBlue,
    Colors.purple,
    Colors.black,
    Colors.cyan,
  ];

  final rng = new Random();

  ChatCard({
    @required this.chat,
  });

  // =============================================================

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

  Widget build(BuildContext context) {
    // Uint8List decodedBase64ImgOfFriend = base64.decode(friend.imgURL);
    initializeDateFormatting('pt_BR', null);
    return Dismissible(
      // ignore: missing_return
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final bool res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Make an audio call to ${chat.user.name}?"),
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => VideoCallScreen(),
                        //   ),
                        // );
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
                  content: Text("Make a video call to ${chat.user.name}?"),
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => VideoCallScreen(),
                        //   ),
                        // );
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
      key: Key(chat.user.id),
      child: GestureDetector(
        onTap: () {
          ChatsProvider _chatsProvider =
              Provider.of<ChatsProvider>(context, listen: false);
          _chatsProvider.setSelectedChat(chat);
          Navigator.of(context).pushNamed(ContactScreen.routeName);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: //friend.haveStatus
                            1 == 1 ? 29 : 26,
                        backgroundColor: logoColor,
                        child: CircleAvatar(
                          radius: //friend.haveStatus
                              1 == 1 ? 28 : 26,
                          backgroundColor:
                              // friend.haveStatus
                              1 == 1 ? Colors.white : null,
                          child: GestureDetector(
                            onTap: () {
                              // friend.haveStatus
                              //     ? Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => StoryViewer()),
                              //       )
                              //     :
                              showDialog(
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
                                                  MainAxisAlignment.spaceEvenly,
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
                                                  onTap: () {
                                                    print("video");
                                                  },
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
                            child: 1 == 1
                                ? CircleAvatar(
                                    radius: 26.0,
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(
                                        "assets/images/people/Ankit_sagar_4027f99669eac45eae5027722524d2caa37d0c1b.jpeg"),
                                    // Image.memory(
                                    //   decodedBase64ImgOfFriend,
                                    // ),
                                  )
                                : CircleAvatar(
                                    child: Text(chat.user.name[0].toUpperCase(),
                                        style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        )),
                                    radius: 26,
                                    backgroundColor: Colors.blue,
                                  ),
                          ),
                        ),
                      ),
                      onlineMissedCallStatus(
                        true, // friend.isOnline
                        false, // friend.isMissedCall,
                        true, // friend.haveStatus,
                      ), // Is Online Function
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // sender Name
                        Text(
                          chat.user.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.grey[800]),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        // Messages
                        Text(
                          20 < chat.messages[0].message.length.toInt()
                              ? chat.messages[0].message.substring(0, 25) +
                                  "..."
                              : chat.messages[0].message,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        // Last seen
                        Text(
                          "last seen " +
                              UtilDates.getSendAtDayOrHour(
                                  chat.messages[0].sendAt),
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
                  unreadMessages(),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    UtilDates.getSendAtDayOrHour(chat.messages[0].sendAt),
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

//============================================

  // @override
  // Widget build(BuildContext context) {
  //   initializeDateFormatting('pt_BR', null);
  //   return Container(
  //     child: InkWell(
  //       onTap: () {
  //         ChatsProvider _chatsProvider =
  //             Provider.of<ChatsProvider>(context, listen: false);
  //         _chatsProvider.setSelectedChat(chat);
  //         Navigator.of(context).pushNamed(ContactScreen.routeName);
  //       },
  //       child: Padding(
  //         padding: EdgeInsets.only(
  //           left: 15,
  //           top: 10,
  //           bottom: 0,
  //         ),
  //         child: Container(
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               CircleAvatar(
  //                 child: Text(
  //                   chat.user.name[0].toUpperCase(),
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 radius: 20,
  //                 backgroundColor: Colors.blue,
  //               ),
  //               Expanded(
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(
  //                     left: 15,
  //                     top: 2,
  //                   ),
  //                   child: Container(
  //                     child: Column(
  //                       children: <Widget>[
  //                         Row(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: <Widget>[
  //                             Expanded(
  //                               child: Column(
  //                                 crossAxisAlignment:
  //                                     CrossAxisAlignment.stretch,
  //                                 children: <Widget>[
  //                                   Text(
  //                                     chat.user.name,
  //                                     style: TextStyle(
  //                                       color: Colors.black,
  //                                       fontSize: 16,
  //                                       fontWeight: FontWeight.bold,
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 2,
  //                                   ),
  //                                   Text(
  //                                     chat.messages[0].message,
  //                                     style: TextStyle(
  //                                       fontSize: 12,
  //                                     ),
  //                                     maxLines: 2,
  //                                   ),
  //                                   SizedBox(
  //                                     height: 15,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.only(right: 15, left: 30),
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.end,
  //                                 children: <Widget>[
  //                                   Text(
  //                                     UtilDates.getSendAtDayOrHour(chat.messages[0].sendAt),
  //                                     style: TextStyle(
  //                                       color: _numberOfUnreadMessagesByMe() > 0
  //                                           ? Theme.of(context).primaryColor
  //                                           : Colors.grey,
  //                                       fontSize: 12,
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 5,
  //                                   ),
  //                                   unreadMessages(),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(
  //                           height: 5,
  //                         ),
  //                         Container(
  //                           width: double.infinity,
  //                           height: 1,
  //                           color: Color(0xFFDDDDDD),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  String messageDate(int milliseconds) {
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return format.format(date);
  }

  int _numberOfUnreadMessagesByMe() {
    return chat.messages.where((message) => message.unreadByMe).length;
  }

  Widget unreadMessages() {
    final _unreadMessages = _numberOfUnreadMessagesByMe();
    if (_unreadMessages == 0) {
      return Container(width: 0, height: 0);
    }
    return Container(
      alignment: Alignment.center,
      height: 18.0,
      width: 18.0,
      child: Text(
        _unreadMessages.toString(),
        style: TextStyle(color: Colors.white, fontSize: 10.0),
      ),
      decoration: BoxDecoration(
          color: MyColors.primaryColor,
          // color: Color(0xff2AD266),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
