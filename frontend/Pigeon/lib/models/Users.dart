class Users {
  final String imgURL;
  final String name;
  final String msg;
  final bool isRead;
  final String noOfMsgUnRead;
  final String time;
  final bool isMissedCall;
  final bool isOnline;
  final bool haveStatus;

  Users({
    this.haveStatus,
    this.isMissedCall,
    this.isOnline,
    this.imgURL,
    this.name,
    this.msg,
    this.isRead,
    this.time,
    this.noOfMsgUnRead = '',
  });
}

final List<Users> user = [
  Users(
    imgURL: 'assets/images/people/1.jpg',
    name: 'Vanshita',
    isRead: false,
    time: 'Yesterday',
    noOfMsgUnRead: '13',
    msg: 'Hey, how are you?',
    isOnline: false,
    isMissedCall: false,
    haveStatus: true,
  ),
  Users(
    imgURL: 'assets/images/people/2.jpg',
    name: 'Prince',
    isRead: false,
    time: '02:05 AM',
    noOfMsgUnRead: '2',
    msg: 'Hey, how are you?',
    isOnline: true,
    isMissedCall: false,
    haveStatus: true,
  ),
  Users(
    imgURL: 'assets/images/people/3.jpg',
    name: 'Rumi',
    isRead: true,
    time: '12:05 AM',
    noOfMsgUnRead: '',
    msg: 'Hey, how are you?',
    isOnline: false,
    isMissedCall: true,
    haveStatus: true,
  ),
  Users(
    imgURL: 'assets/images/people/4.jpg',
    name: 'hello',
    isRead: false,
    time: '02:05 AM',
    noOfMsgUnRead: '10',
    msg: 'Hey, how are you?',
    isOnline: true,
    isMissedCall: true,
    haveStatus: false,
  ),
  Users(
    imgURL: 'assets/images/people/5.jpg',
    name: 'lol',
    isRead: false,
    time: '12:05 AM',
    noOfMsgUnRead: '15',
    msg: 'Hey, how are you?',
    isOnline: true,
    isMissedCall: false,
    haveStatus: false,
  ),
  Users(
    imgURL: 'assets/images/people/6.jpg',
    name: 'Shanu',
    isRead: true,
    time: '02:05 AM',
    noOfMsgUnRead: '',
    msg: 'Hey, how are you?',
    isOnline: false,
    isMissedCall: false,
    haveStatus: false,
  ),
  Users(
    imgURL: 'assets/images/people/7.jpg',
    name: 'mom',
    isRead: true,
    time: '12:05 AM',
    noOfMsgUnRead: '',
    msg: 'Hey, how are you?',
    isOnline: true,
    isMissedCall: true,
    haveStatus: true,
  ),
  Users(
    imgURL: 'assets/images/people/8.jpg',
    name: 'dad',
    isRead: true,
    time: '02:05 AM',
    noOfMsgUnRead: '',
    msg: 'Hey, how are you?',
    isOnline: true,
    isMissedCall: true,
    haveStatus: false,
  ),
  Users(
    imgURL: 'assets/images/people/9.jpg',
    name: 'Aryanshi',
    isRead: false,
    time: '12:05 AM',
    noOfMsgUnRead: '14',
    msg: 'Hey, how are you?',
    isOnline: true,
    isMissedCall: true,
    haveStatus: false,
  ),
  Users(
    imgURL: 'assets/images/people/10.jpg',
    name: 'hi',
    isRead: true,
    time: '02:05 AM',
    noOfMsgUnRead: '',
    msg: 'Hey, how are you?',
    isOnline: true,
    isMissedCall: true,
    haveStatus: false,
  ),
];
