import 'dart:convert';
import 'dart:ui';
import 'package:Pigeon/models/Users.dart';
import 'package:Pigeon/screens/splashScreen.dart';
import 'package:Pigeon/server/socketIO.dart';
import 'package:Pigeon/widgets/menuButton.dart';
import 'package:Pigeon/widgets/userChats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  static const String homePageRoute = "/";
  final String authToken;
  final Users me;

  const HomeScreen({Key key, this.authToken, this.me}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => SystemNavigator.pop(),
                child: Text("Yes"),
              ),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("No"),
              ),
            ],
          ),
        ) ??
        false;
  }

  AnimationController rotationController;
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  @override
  void initState() {
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _getData();
    ScopedModel.of<ChatModel>(context, rebuildOnChange: false)
        .userList(widget.me);
    super.initState();
  }

  @override
  void dispose() {
    saveUserData(widget.authToken);
    super.dispose();
  }

  var json;

  Future<void> _getData() async {
    CircularProgressIndicator();

    try {
      http.get(
        nodeEndPoint + "/api/userDetails",
        headers: {
          "auth-token": widget.authToken,
        },
      ).then((res) async => {
            json = jsonDecode(res.body),
            print(">>>>>>" + json.toString() + "<<<<<<<"),
          });
    } catch (err) {
      print(err);
    }
  }

  double angle = 0;
  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            title,
            style: TextStyle(
              color: Color(0xff2AD266),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: ScopedModelDescendant<ChatModel>(
          builder: (context, child, model) {
            return Container(
              decoration: BoxDecoration(
                color: Color(0xffFBFBFD),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: ListView.builder(
                itemCount: model.friendList.length,
                itemBuilder: (BuildContext context, int index) {
                  Users friend = model.friendList[index];
                  return userChats(context, friend);
                },
              ),
            );
          },
        ),
        bottomNavigationBar: menuButtons(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          key: btnKey,
          onPressed: () {
            menu = PopupMenu(
                backgroundColor: MyColors.primaryColorLight,
                items: [
                  MenuItem(
                    title: 'Create group',
                    image: Icon(
                      Icons.group_add,
                      color: Colors.white,
                    ),
                  ),
                  MenuItem(
                      title: 'Chat',
                      image: Icon(
                        Icons.chat,
                        color: Colors.white,
                      )),
                ],
                onClickMenu: onClickMenu,
                stateChanged: stateChanged,
                onDismiss: onDismiss);
            menu.show(
              widgetKey: btnKey,
            );
          },
          tooltip: 'Create/Add: Contacts,status,group',
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            color: Colors.white,
            progress: rotationController,
          ),
          backgroundColor: MyColors.primaryColor,
          elevation: 2.0,
        ),
      ),
    );
  }

  void stateChanged(bool isShow) {
    isShow ? rotationController.forward() : rotationController.reverse();
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {}
}

saveUserData(authToken) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("IS_LOGGED_IN", true);
  sharedPreferences.setString("AUTH_TOKEN", authToken);
}
