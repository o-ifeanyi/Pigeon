import 'dart:async';
import 'package:Pigeon/configs/assets.dart';
import 'package:Pigeon/models/UserChatModel.dart';
import 'package:Pigeon/screens/storyView.dart';
import 'package:Pigeon/server/socketIO.dart';
import 'package:Pigeon/widgets/messageBubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scoped_model/scoped_model.dart';

import '../constants.dart';

class ChatScreen extends StatefulWidget {
  static const String chatPageRoute = "CHAT_PAGE_ROUTE";
  final friend;
  ChatScreen({this.friend});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

enum UserStatus { online, typing }

class _ChatScreenState extends State<ChatScreen> {
  FocusNode textFieldFocusNode;
  TextEditingController textEditingController;
  ScrollController _scrollController;
  bool haveMsg = false;
  // Timer timer;
  String newValue;
  String secondNewValue = "";
  @override
  void initState() {
    _scrollController = ScrollController();
    textFieldFocusNode = FocusNode();
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // timer.cancel();
    textFieldFocusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Uint8List decodedBase64ImgOfFriend = base64.decode(widget.friend.imgURL);
    return Material(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: widget.friend.haveStatus ? 19 : 13,
                    backgroundColor: logoColor,
                    child: CircleAvatar(
                      radius: widget.friend.haveStatus ? 18 : 13,
                      backgroundColor:
                          widget.friend.haveStatus ? Colors.white : null,
                      child: GestureDetector(
                        onTap: () {
                          widget.friend.haveStatus
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
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              child: Image.asset(
                                                "assets/images/people/Ankit_sagar_4027f99669eac45eae5027722524d2caa37d0c1b.jpeg",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
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
                                                  onTap: () => {print("video")},
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
                ],
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.friend.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff475C68),
                    ),
                  ),
                  ScopedModelDescendant<ChatModel>(
                    builder: (context, child, model) {
                      return Text(
                        // widget.friend.isOnline ? 'Online' : 'Offline',
                        model.status,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                      );
                    },
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 8,
                    child: ScopedModelDescendant<ChatModel>(
                        builder: (context, child, model) {
                      List<UserChat> messages =
                          model.getMessagesForID(widget.friend.id.toString());
                      return Container(
                        child: ListView.builder(
                          controller: _scrollController,
                          reverse: false,
                          itemCount: messages.length,
                          itemBuilder: (context, index) => GestureDetector(
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
                                        borderRadius: BorderRadius.circular(20),
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
                              key: Key(model.messages[index].message),
                              confirmDismiss: (direction) async {
                                final bool res = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                            "Are you sure you want to delete ${model.messages[index].message}?"),
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
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                model.messages.removeAt(index);
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                return res;
                              },
                              child: MessageBubble(
                                isMe: model.messages[index].senderID ==
                                    widget.friend.id,
                                text: model.messages[index].message,
                                sender: model.messages[index].senderName,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  Expanded(
                    flex: 0,
                    child: ScopedModelDescendant<ChatModel>(
                      builder: (context, child, model) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: TextField(
                                  autofocus: false,
                                  controller: textEditingController,
                                  onChanged: (value) {
                                    print("value changed: " + value);
                                    secondNewValue = value;

                                    void isTyping({value, receiverID}) {
                                      if (newValue != value) {
                                        model.sendStatus(
                                            "typing...", receiverID);
                                        newValue = value;
                                      } else {
                                        model.sendStatus("online", receiverID);
                                        newValue = value;
                                      }
                                    }

                                    setState(() {
                                      haveMsg = true;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: "Type a message",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[700]),
                                    prefixIcon: IconButton(
                                      icon: Icon(
                                        Icons.emoji_emotions_outlined,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        print('icon');
                                      },
                                    ),
                                    suffixIcon: Container(
                                      width: 77,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            child: Icon(
                                              Icons.attach_file,
                                              color: Colors.black,
                                            ),
                                            onTap: () {},
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          textEditingController.text == ""
                                              ? GestureDetector(
                                                  onTap: () {
                                                    print("Hello");
                                                  },
                                                  child: Image.asset(
                                                    Assets.camera,
                                                    scale: 3,
                                                    color: Colors.black,
                                                  ),
                                                )
                                              : SizedBox(),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                flex: 2,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: MyColors.primaryColor,
                                  child: textEditingController.text == ""
                                      ? GestureDetector(
                                          onTap: () {
                                            print("mic");
                                          },
                                          child: Image.asset(
                                            Assets.mic,
                                            scale: 4,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            _chatListScrollToBottom();
                                            model.sendMessage(
                                                textEditingController.text,
                                                widget.friend.id.toString());
                                            textEditingController.text = '';
                                          },
                                          child: Image.asset(
                                            Assets.send,
                                            scale: 4,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Scroll the Chat List when it goes to bottom
  _chatListScrollToBottom() {
    Timer(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 100),
          curve: Curves.decelerate,
        );
      }
    });
  }
}
