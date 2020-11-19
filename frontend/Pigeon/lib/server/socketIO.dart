import 'dart:convert';
import 'package:Pigeon/constants.dart';
import 'package:Pigeon/models/UserChatModel.dart';
import 'package:Pigeon/models/Users.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

//EVENTS
// message sending and receiving events
const String RECEIVE_MESSAGE = "RECEIVE_MESSAGE";
const String SEND_MESSAGE = "SEND_MESSAGE";
const String RECEIVE_STATUS = "RECEIVE_STATUS";
const String SEND_STATUS = "SEND_STATUS";

class ChatModel extends Model {
  List jsonData;
  Future<void> userList(Users me) async {
    http.Response res = await http.get(nodeEndPoint + "/getUser");
    jsonData = await json.decode(res.body);
    jsonData.forEach((i) {
      print(i);
      users.add(Users.fromJson(i));
      notifyListeners();
    });
    my = me;
    init();
  }

  List<Users> users = [];
  Users my;
  List<Users> friendList = List<Users>();
  List<UserChat> messages = List<UserChat>();
  String status = "Online";
  SocketIO socketIO;

  void init() {
    friendList = users.where((user) => user.id != my.id).toList();
    socketIO = SocketIOManager().createSocketIO(nodeEndPoint, '/',
        query: 'id=${my.id}', socketStatusCallback: _socketStatus);
    socketIO.init();

    socketIO.subscribe(RECEIVE_MESSAGE, (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      print(">>>>>> " +
          " receiverID " +
          data["receiverID"] +
          " senderID " +
          data["senderID"] +
          " message " +
          data['message']);

      messages.add(
        UserChat(
          message: data['message'],
          senderID: data["senderID"],
          receiverID: data["receiverID"],
        ),
      );
      notifyListeners();
    });

    socketIO.subscribe(RECEIVE_STATUS, (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);

      status = data['status'] == 'typing' ? 'typing...' : "Online";

      print(">>>>>> " +
          "receiverID " +
          data["receiverID"] +
          " senderID " +
          data["senderID"] +
          " status " +
          data['status']);
    });

    socketIO.connect();
  }

  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }

  void sendMessage(String msg, String receiverID) {
    messages.add(
      UserChat(
        message: msg,
        senderID: my.id.toString(),
        receiverID: receiverID,
      ),
    );
    socketIO.sendMessage(
      SEND_MESSAGE,
      json.encode({
        "receiverID": receiverID,
        "senderID": my.id,
        "message": msg,
      }),
    );

    notifyListeners();
  }

  void sendStatus(String sts, String receiverID) {
    socketIO.sendMessage(
      SEND_STATUS,
      json.encode({
        "receiverID": receiverID,
        "senderID": my.id,
        "status": sts,
      }),
    );
    notifyListeners();
  }

  List<UserChat> getMessagesForID(String id) {
    return messages
        .where((msg) => msg.senderID == id || msg.receiverID == id)
        .toList();
  }
}
