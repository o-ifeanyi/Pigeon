import 'package:Pigeon/config/assets.dart';
import 'package:Pigeon/src/data/models/chat.dart';
import 'package:Pigeon/src/data/models/message.dart';
import 'package:Pigeon/src/data/providers/chats_provider.dart';
import 'package:Pigeon/src/screens/contact/contact_controller.dart';
import 'package:Pigeon/src/screens/story/story_view.dart';
import 'package:Pigeon/src/utils/dates.dart';
import 'package:Pigeon/src/widgets/custom_app_bar.dart';
import 'package:Pigeon/src/widgets/text_field_with_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:emoji_picker/emoji_picker.dart';

import '../../../constants.dart';

enum MessagePosition { BEFORE, AFTER }

class ContactScreen extends StatefulWidget {
  static final String routeName = "/contact";

  ContactScreen();

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  ContactController _contactController;
  final format = new DateFormat("HH:mm");

  @override
  void initState() {
    super.initState();
    _contactController = ContactController(
      context: context,
    );
  }

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _contactController.initProvider();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _contactController.streamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius:
                            //widget.friend.haveStatus
                            1 == 1 ? 19 : 13,
                        backgroundColor: logoColor,
                        child: CircleAvatar(
                          radius:
                              //widget.friend.haveStatus
                              1 == 1 ? 18 : 13,
                          backgroundColor:
                              // widget.friend.haveStatus
                              1 == 1 ? Colors.white : null,
                          child: GestureDetector(
                            onTap: () {
                              1 == 1
                                  // widget.friend.haveStatus
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
                                                110,
                                            width: MediaQuery.of(context)
                                                    .devicePixelRatio *
                                                90,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/people/Ankit_sagar_4027f99669eac45eae5027722524d2caa37d0c1b.jpeg",
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
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
                            child: CircleAvatar(
                              radius: 17.0,
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
                      onlineMissedCallStatus(
                        true, // friend.isOnline
                        false, // friend.isMissedCall,
                        true, // friend.haveStatus,
                      ), // Is Online Function
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _contactController.selectedChat.user.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff475C68),
                        ),
                      ),
                      Text(
                        // widget.friend.isOnline ? 'Online' : 'Offline',
                        "online",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Image.asset(
                    Assets.videoCall,
                    color: Colors.black,
                    scale: 5,
                  ),
                  onPressed: () => print("video"),
                ),
                IconButton(
                    icon: Image.asset(
                      Assets.audioCall,
                      color: Colors.black,
                      scale: 5,
                    ),
                    onPressed: () => print("audio")),
                IconButton(icon: Icon(Icons.more_vert), onPressed: null),
                const SizedBox(width: 12),
              ],
            ),
            //CustomAppBar(
            //   title: GestureDetector(
            //     onTap: () {},
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: <Widget>[
            //         CircleAvatar(
            //           child: Text(
            //             _contactController.selectedChat.user.name[0]
            //                 .toUpperCase(),
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 14,
            //             ),
            //           ),
            //           radius: 16,
            //           backgroundColor: Colors.blue,
            //         ),
            //         SizedBox(
            //           width: 7,
            //         ),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Text(
            //               _contactController.selectedChat.user.name,
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16,
            //               ),
            //             ),
            //             Text(
            //               "${_contactController.selectedChat.user.phone}",
            //               style: TextStyle(
            //                 color: Colors.grey,
            //                 fontSize: 10,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/wallpapers/light_background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Scrollbar(
                          child: ListView.builder(
                            controller: _contactController.scrollController,
                            padding: EdgeInsets.only(bottom: 5),
                            reverse: true,
                            itemCount:
                                _contactController.selectedChat.messages.length,
                            itemBuilder: (BuildContext context, int index) =>
                                GestureDetector(
                              onLongPress: () {
                                showModalBottomSheet(
                                    isScrollControlled: false,
                                    isDismissible: false,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: true,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        height: 200,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 200,
                                              padding: EdgeInsets.all(0),
                                              color: Colors.white,
                                              child: GestureDetector(
                                                onVerticalDragDown:
                                                    (dragDownDetails) {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(
                                                  Icons.linear_scale,
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(12),
                                              child: Text(
                                                "08:36 AM, 26 Jan 2020",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                  child: FlatButton(
                                                    onPressed: () {},
                                                    child: Text("UnSend"),
                                                  ),
                                                ),
                                                Container(
                                                  child: FlatButton(
                                                    onPressed: () {},
                                                    child: Text("Reply"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Dismissible(
                                key: Key(_contactController
                                    .selectedChat.messages[index].message),
                                confirmDismiss: (direction) async {
                                  final bool res = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                              "Are you sure you want to delete ${_contactController.selectedChat.messages[index].message}?"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _contactController
                                                      .selectedChat.messages
                                                      .removeAt(index);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                  return res;
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 5,
                                    bottom: 0,
                                  ),
                                  child: renderMessage(
                                      context,
                                      _contactController
                                          .selectedChat.messages[index],
                                      index),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextFieldWithButton(
                        onSubmit: _contactController.sendMessage,
                        textEditingController:
                            _contactController.textController,
                        onEmojiTap: (bool showEmojiKeyboard) {
                          _contactController.showEmojiKeyboard =
                              !showEmojiKeyboard;
                        },
                        showEmojiKeyboard: _contactController.showEmojiKeyboard,
                        context: context,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget renderMessage(BuildContext context, Message message, int index) {
    if (_contactController.myUser == null) return Container();
    return Column(
      children: <Widget>[
        renderMessageSendAtDay(message, index),
        Material(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: message.from == _contactController.myUser.id
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              renderMessageSendAt(message, MessagePosition.BEFORE),
              Material(
                borderRadius: message.from == _contactController.myUser.id
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                color: message.from == _contactController.myUser.id
                    ? MyColors.senderChatColor
                    : MyColors.receiverChatColor,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Text(
                      message.message,
                      style: TextStyle(
                        color: message.from == _contactController.myUser.id
                            ? Colors.white
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
              renderMessageSendAt(message, MessagePosition.AFTER),
            ],
          ),
        ),
      ],
    );
  }

  Widget renderMessageSendAt(Message message, MessagePosition position) {
    if (message.from == _contactController.myUser.id &&
        position == MessagePosition.AFTER) {
      return Row(
        children: <Widget>[
          SizedBox(width: 6),
          Text(
            messageDate(message.sendAt),
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      );
    }
    if (message.from != _contactController.myUser.id &&
        position == MessagePosition.BEFORE) {
      return Row(
        children: <Widget>[
          Text(
            messageDate(message.sendAt),
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
          SizedBox(width: 6),
        ],
      );
    }
    return Container(height: 0, width: 0);
  }

  String messageDate(int milliseconds) {
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return format.format(date);
  }

  Widget renderMessageSendAtDay(Message message, int index) {
    if (index == _contactController.selectedChat.messages.length - 1) {
      return getLabelDay(message.sendAt);
    }
    final lastMessageSendAt = new DateTime.fromMillisecondsSinceEpoch(
        _contactController.selectedChat.messages[index + 1].sendAt);
    final messageSendAt =
        new DateTime.fromMillisecondsSinceEpoch(message.sendAt);
    final formatter = UtilDates.formatDay;
    String formattedLastMessageSendAt = formatter.format(lastMessageSendAt);
    String formattedMessageSendAt = formatter.format(messageSendAt);
    if (formattedLastMessageSendAt != formattedMessageSendAt) {
      return getLabelDay(message.sendAt);
    }
    return Container();
  }

  Widget getLabelDay(int milliseconds) {
    String day = UtilDates.getSendAtDay(milliseconds);
    return Column(
      children: <Widget>[
        SizedBox(
          height: 4,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color(0xFFC0CBFF),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: Text(
              day,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),
        SizedBox(
          height: 7,
        ),
      ],
    );
  }

  Widget onlineMissedCallStatus(
      bool isOnline, bool isMissedCall, bool haveStatus) {
    if (isMissedCall) {
      return Positioned(
        top: haveStatus ? 22.0 : 34,
        left: haveStatus ? 22.0 : 34,
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
        top: haveStatus ? 22.0 : 38,
        left: haveStatus ? 22.0 : 38,
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
}
