// To parse this JSON data, do
//
//     final userChat = userChatFromJson(jsonString);

import 'dart:convert';

UserChat userChatFromJson(String str) => UserChat.fromJson(json.decode(str));

String userChatToJson(UserChat data) => json.encode(data.toJson());

class UserChat {
  UserChat({
    this.message,
    this.messageID,
    this.chatType,
    this.time,
    this.senderID,
    this.receiverID,
    this.senderName,
    this.receiverName,
    this.timeOfMsgDelivered,
    this.timeOfMsgSent,
  });
  String messageID;
  String chatType;
  String message;
  String time;
  String senderID;
  String receiverID;
  String senderName;
  String receiverName;
  int timeOfMsgDelivered;
  int timeOfMsgSent;

  factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        messageID: json['_id'],
        message: json['message'],
        chatType: json['chatType'],
        time: json["time"],
        senderID: json["senderID"],
        receiverID: json["receiverID"],
        senderName: json["senderName"],
        receiverName: json["receiverName"],
        timeOfMsgDelivered: json["timeOfMsgDelivered"],
        timeOfMsgSent: json["timeOfMsgSent"],
      );

  Map<String, dynamic> toJson() => {
        "_id": messageID,
        "message": message,
        "chatType": chatType,
        "time": time,
        "senderID": senderID,
        "receiverID": receiverID,
        "senderName": senderName,
        "receiverName": receiverName,
        "timeOfMsgDelivered": timeOfMsgDelivered,
        "timeOfMsgSent": timeOfMsgSent,
      };
}

// final List<UserChat> chat = [
//   UserChat(
//     time: "12073231102020",
//     senderID: "5f89ce7695388b08988e6ec0",
//     receiverID: "",
//     senderName: "Shanu",
//     receiverName: "Ankit",
//     msg: "hello!",
//     timeOfMsgDelivered: "12073231102020",
//     timeOfMsgSent: "12073231102020",
//   ),
//   UserChat(
//     time: "12073231102020",
//     senderID: "",
//     receiverID: "5f89ce7695388b08988e6ec0",
//     senderName: "Ankit",
//     receiverName: "Shanu",
//     msg: "hello Ankit!",
//     timeOfMsgDelivered: "12073231102020",
//     timeOfMsgSent: "12073231102020",
//   ),
//   UserChat(
//     time: "12073231102020",
//     senderID: "5f89ce7695388b08988e6ec0",
//     receiverID: "",
//     senderName: "Shanu",
//     receiverName: "Ankit",
//     msg: "or kya krra h?",
//     timeOfMsgDelivered: "12073231102020",
//     timeOfMsgSent: "12073231102020",
//   ),
//   UserChat(
//     time: "12073231102020",
//     senderID: "",
//     receiverID: "5f89ce7695388b08988e6ec0",
//     senderName: "Ankit",
//     receiverName: "Shanu",
//     msg: "kuch nhi yrr!",
//     timeOfMsgDelivered: "12073231102020",
//     timeOfMsgSent: "12073231102020",
//   ),
//   UserChat(
//     time: "12073231102020",
//     senderID: "5f89ce7695388b08988e6ec0",
//     receiverID: "",
//     senderName: "Shanu",
//     receiverName: "Ankit",
//     msg: "MBBS ki tyaari kaisi chal ri h",
//     timeOfMsgDelivered: "12073231102020",
//     timeOfMsgSent: "12073231102020",
//   ),
//   UserChat(
//     time: "12073231102020",
//     senderID: "",
//     receiverID: "5f89ce7695388b08988e6ec0",
//     senderName: "Ankit",
//     receiverName: "Shanu",
//     msg: "bs physic pdh ra tha",
//     timeOfMsgDelivered: "12073231102020",
//     timeOfMsgSent: "12073231102020",
//   ),
//   UserChat(
//     time: "12073231102020",
//     senderID: "5f89ce7695388b08988e6ec0",
//     receiverID: "",
//     senderName: "Shanu",
//     receiverName: "Ankit",
//     msg: "ohh, okk!",
//     timeOfMsgDelivered: "12073231102020",
//     timeOfMsgSent: "12073231102020",
//   ),
//   UserChat(
//     time: "12073231102020",
//     senderID: "",
//     receiverID: "5f89ce7695388b08988e6ec0",
//     senderName: "Ankit",
//     receiverName: "Shanu",
//     msg: "or ghar sab thik",
//     timeOfMsgDelivered: "12073231102020",
//     timeOfMsgSent: "12073231102020",
//   ),
//   UserChat(
//     time: "12073231102020",
//     senderID: "5f89ce7695388b08988e6ec0",
//     receiverID: "",
//     senderName: "Shanu",
//     receiverName: "Ankit",
//     msg: "haan sab mast h",
//     timeOfMsgDelivered: "12073231102020",
//     timeOfMsgSent: "12073231102020",
//   ),
//   UserChat(
//     time: "12073231102020",
//     senderID: "",
//     receiverID: "5f89ce7695388b08988e6ec0",
//     senderName: "Ankit",
//     receiverName: "Shanu",
//     msg: "or tu suna",
//     timeOfMsgDelivered: "12073231102020",
//     timeOfMsgSent: "12073231102020",
//   ),
//   UserChat(
//     time: "12073231102020",
//     senderID: "5f89ce7695388b08988e6ec0",
//     receiverID: "",
//     senderName: "Shanu",
//     receiverName: "Ankit",
//     msg: "me bhi mst hu yrr",
//     timeOfMsgDelivered: "12073231102020",
//     timeOfMsgSent: "12073231102020",
//   ),
//   UserChat(
//     time: "12073231102020",
//     senderID: "5f89ce7695388b08988e6ec0",
//     receiverID: "",
//     senderName: "Ankit",
//     receiverName: "Shanu",
//     msg: "chl thik h baad me krta hu baat",
//     timeOfMsgDelivered: "12073231102020",
//     timeOfMsgSent: "12073231102020",
//   ),
// ];
