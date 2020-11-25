import 'dart:io';

import 'package:Pigeon/config/assets.dart';
import 'package:Pigeon/constants.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker/emoji_picker.dart';

class TextFieldWithButton extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function onSubmit;
  final Function onEmojiTap;
  final bool showEmojiKeyboard;
  final BuildContext context;

  TextFieldWithButton({
    @required this.context,
    @required this.textEditingController,
    @required this.onSubmit,
    this.onEmojiTap,
    this.showEmojiKeyboard = false,
  });

  @override
  _TextFieldWithButtonState createState() => _TextFieldWithButtonState();
}

class _TextFieldWithButtonState extends State<TextFieldWithButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: Platform.isIOS
                          ? EdgeInsets.only(left: 5, right: 5)
                          : EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: Color(0xFFDDDDDD),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Platform.isIOS
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    widget.onEmojiTap(widget.showEmojiKeyboard);
                                    setState(() {
                                      widget.textEditingController.text = "";
                                    });
                                  },
                                  child: Icon(
                                    Icons.insert_emoticon,
                                    color: Colors.grey,
                                  ),
                                ),
                          Expanded(
                            child: Scrollbar(
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {});
                                },
                                cursorHeight: 20,
                                autocorrect: true,
                                maxLines: 5,
                                minLines: 1,
                                showCursor: true,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                cursorColor: MyColors.primaryColor,
                                controller: widget.textEditingController,
                                onSubmitted: (_) {
                                  widget.onSubmit();
                                },
                                onTap: () {
                                  if (widget.showEmojiKeyboard) {
                                    widget.onEmojiTap(widget.showEmojiKeyboard);
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Type a message",
                                  hintStyle: TextStyle(color: Colors.grey[700]),
                                  // suffixIcon: Icon(Icons.add),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.attach_file,
                              color: Colors.black,
                            ),
                            onTap: () {},
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          widget.textEditingController.text == ""
                              ? InkWell(
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
                          (widget.textEditingController.text == "")
                              ? const SizedBox(
                                  width: 12,
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Material(
                    child: widget.textEditingController.text == ""
                        ? GestureDetector(
                            onTap: () {
                              print("mic");
                            },
                            child: CircleAvatar(
                              backgroundColor: MyColors.primaryColor,
                              radius: 25,
                              child: Image.asset(
                                Assets.mic,
                                scale: 4,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              widget.onSubmit();
                            },
                            child: CircleAvatar(
                              backgroundColor: MyColors.primaryColor,
                              radius: 25,
                              child: Image.asset(
                                Assets.send,
                                scale: 4,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
        renderEmojiKeyboard(),
      ],
    );
  }

  Widget renderEmojiKeyboard() {
    if (widget.showEmojiKeyboard) {
      FocusScope.of(widget.context).requestFocus(FocusNode());
    }
    if (widget.showEmojiKeyboard && !_keyboardIsVisible()) {
      return EmojiPicker(
        rows: 3,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          final emojiImage = emoji.emoji;
          widget.textEditingController.text =
              "${widget.textEditingController.text}$emojiImage";
        },
      );
    }
    return Container(width: 0, height: 0);
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(widget.context).viewInsets.bottom == 0.0);
  }
}
