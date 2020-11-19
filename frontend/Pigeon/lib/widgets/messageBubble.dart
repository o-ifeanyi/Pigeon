import 'package:Pigeon/constants.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: <Widget>[
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),
            color: isMe ? MyColors.senderChatColor : MyColors.receiverChatColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                constraints: BoxConstraints(maxWidth: 200),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
