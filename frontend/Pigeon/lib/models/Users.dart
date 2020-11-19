import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  final String id;
  final String imgURL;
  final String name;
  final bool isRead;
  final String noOfMsgUnRead;
  final String time;
  final bool isMissedCall;
  final bool isOnline;
  final bool haveStatus;

  Users({
    this.id,
    this.haveStatus,
    this.isMissedCall,
    this.isOnline,
    this.imgURL,
    this.name,
    this.isRead,
    this.time,
    this.noOfMsgUnRead,
  });

  String greeting;
  List<String> instructions;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json['_id'],
        imgURL: json['img'],
        name: json['name'],
        isRead: json['isRead'],
        time: json['time'],
        noOfMsgUnRead: json['noOfMsgUnRead'],
        isOnline: json['isOnline'],
        isMissedCall: json['isMissedCall'],
        haveStatus: json['haveStatus'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "img": imgURL,
        "name": name,
        "isRead": isRead,
        "time": time,
        "noOfMsgUnRead": noOfMsgUnRead,
        "isOnline": isOnline,
        "isMissedCall": isMissedCall,
        "haveStatus": haveStatus,
      };
}

// final List<Users> user = [
//   Users(
//     imgURL: 'assets/images/people/1.jpg',
//     name: 'Vanshita',
//     isRead: false,
//     time: 'Yesterday',
//     noOfMsgUnRead: '13',
//     msg: 'Hey, how are you?',
//     isOnline: false,
//     isMissedCall: false,
//     haveStatus: true,
//   ),
//   Users(
//     imgURL: 'assets/images/people/2.jpg',
//     name: 'Prince',
//     isRead: false,
//     time: '02:05 AM',
//     noOfMsgUnRead: '2',
//     msg: 'Hey, how are you?',
//     isOnline: true,
//     isMissedCall: false,
//     haveStatus: true,
//   ),
//   Users(
//     imgURL: 'assets/images/people/3.jpg',
//     name: 'Rumi',
//     isRead: true,
//     time: '12:05 AM',
//     noOfMsgUnRead: '',
//     msg: 'Hey, how are you?',
//     isOnline: false,
//     isMissedCall: true,
//     haveStatus: true,
//   ),
//   Users(
//     imgURL: 'assets/images/people/4.jpg',
//     name: 'hello',
//     isRead: false,
//     time: '02:05 AM',
//     noOfMsgUnRead: '10',
//     msg: 'Hey, how are you?',
//     isOnline: true,
//     isMissedCall: true,
//     haveStatus: false,
//   ),
//   Users(
//     imgURL: 'assets/images/people/5.jpg',
//     name: 'lol',
//     isRead: false,
//     time: '12:05 AM',
//     noOfMsgUnRead: '15',
//     msg: 'Hey, how are you?',
//     isOnline: true,
//     isMissedCall: false,
//     haveStatus: false,
//   ),
//   Users(
//     imgURL:
//         'assets/images/people/Ankit_sagar_4027f99669eac45eae5027722524d2caa37d0c1b.jpeg',
//     name: 'Ankit',
//     isRead: true,
//     time: '02:05 AM',
//     noOfMsgUnRead: '',
//     msg: 'Hey, how are you?',
//     isOnline: false,
//     isMissedCall: false,
//     haveStatus: false,
//   ),
//   Users(
//     imgURL: 'assets/images/people/7.jpg',
//     name: 'mom',
//     isRead: true,
//     time: '12:05 AM',
//     noOfMsgUnRead: '',
//     msg: 'Hey, how are you?',
//     isOnline: true,
//     isMissedCall: true,
//     haveStatus: true,
//   ),
//   Users(
//     imgURL: 'assets/images/people/asd.jpeg',
//     name: 'dad',
//     isRead: true,
//     time: '02:05 AM',
//     noOfMsgUnRead: '',
//     msg: 'Hey, how are you?',
//     isOnline: true,
//     isMissedCall: true,
//     haveStatus: false,
//   ),
//   Users(
//     imgURL: 'assets/images/people/9.jpg',
//     name: 'Aryanshi',
//     isRead: false,
//     time: '12:05 AM',
//     noOfMsgUnRead: '14',
//     msg: 'Hey, how are you?',
//     isOnline: true,
//     isMissedCall: true,
//     haveStatus: false,
//   ),
//   Users(
//     imgURL: 'assets/images/people/10.jpg',
//     name: 'hi',
//     isRead: true,
//     time: '02:05 AM',
//     noOfMsgUnRead: '',
//     msg: 'Hey, how are you?',
//     isOnline: true,
//     isMissedCall: true,
//     haveStatus: false,
//   ),
// ];
