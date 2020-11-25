import 'dart:async';
import 'dart:io';

import 'package:Pigeon/src/data/models/custom_error.dart';
import 'package:Pigeon/src/data/models/user.dart';
import 'package:Pigeon/src/data/providers/chats_provider.dart';
import 'package:Pigeon/src/data/repositories/register_repository.dart';
import 'package:Pigeon/src/data/repositories/user_repository.dart';
import 'package:Pigeon/src/screens/home/home_view.dart';
import 'package:Pigeon/src/screens/login/login_view.dart';
import 'package:Pigeon/src/utils/custom_shared_preferences.dart';
import 'package:Pigeon/src/utils/socket_controller.dart';
import 'package:Pigeon/src/utils/state_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SettingsController extends StateControl {
  final BuildContext context;

  UserRepository _userRepository = UserRepository();

  IO.Socket socket = SocketController.socket;

  User myUser;

  SettingsController({
    @required this.context,
  }) {
    this.init();
  }

  void init() {
    getMyUser();
  }

  getMyUser() async {
    myUser = await CustomSharedPreferences.getMyUser();
    notifyListeners();
  }

  openModalDeleteChats() {
    String title = "Delete conversations";
    String description =
        "Are you sure you want to delete your conversations? You will not be able to recover them.";
    List<Widget> actions = [
      FlatButton(
        child: Text(Platform.isIOS ? 'Cancel' : 'CANCEL'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      FlatButton(
        child: Text(
          Platform.isIOS ? 'Delete' : 'DELETE',
          style: TextStyle(color: Platform.isIOS ? Colors.red : Colors.blue),
        ),
        onPressed: () {
          Navigator.pop(context);
          deleteChats();
        },
      ),
    ];
    showAlertDialog(title, description, actions);
  }

  deleteChats() async {
    await Provider.of<ChatsProvider>(context, listen: false).clearDatabase();
    String title = "Success";
    String description = "Your conversations have been deleted.";
    List<Widget> actions = [
      FlatButton(
        child: Text(Platform.isIOS ? 'Ok' : 'OK'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ];
    showAlertDialog(title, description, actions);
  }

  openModalExitApp() {
    String title = "Get out";
    String description =
        "Are you sure you want to quit? Your conversations will be lost.";
    List<Widget> actions = [
      FlatButton(
        child: Text(Platform.isIOS ? 'Cancel' : 'CANCEL'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      FlatButton(
        child: Text(
          Platform.isIOS ? 'Get out' : 'GET OUT',
          style: TextStyle(color: Platform.isIOS ? Colors.red : Colors.blue),
        ),
        onPressed: () {
          Navigator.pop(context);
          logout();
        },
      ),
    ];
    showAlertDialog(title, description, actions);
  }

  showAlertDialog(String title, String description, List<Widget> actions) {
    var alertDialog;
    if (Platform.isIOS) {
      alertDialog = CupertinoAlertDialog(
        title: Text(title),
        content: Text(description),
        actions: actions,
      );
    } else {
      alertDialog = AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: actions,
      );
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  void emitUserLeft() async {
    socket.emit("user-left");
  }

  logout() async {
    emitUserLeft();
    _userRepository.saveUserFcmToken(null);
    await CustomSharedPreferences.remove('user');
    await CustomSharedPreferences.remove('token');
    Provider.of<ChatsProvider>(context, listen: false).clearDatabase();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, (_) => false);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
