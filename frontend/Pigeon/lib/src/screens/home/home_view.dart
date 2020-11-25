import 'package:Pigeon/config/assets.dart';
import 'package:Pigeon/src/screens/home/home_controller.dart';
import 'package:Pigeon/src/widgets/menu_button.dart';
import 'package:Pigeon/src/widgets/chat_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:Pigeon/src/data/providers/chats_provider.dart';
import 'package:Pigeon/src/screens/contact/contact_view.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  HomeController _homeController;

  AnimationController rotationController;
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();

  @override
  void initState() {
    _homeController = HomeController(context: context);
    super.initState();
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  void dispose() {
    _homeController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _homeController.initProvider();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    return StreamBuilder<Object>(
      stream: _homeController.streamController.stream,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              'Pigeon',
              style: TextStyle(
                color: Color(0xff2AD266),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Color(0xffFBFBFD),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: usersList(context),
          ),
          bottomNavigationBar: menuButtons(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
        );

        //     Scaffold(
        //   appBar: CustomAppBar(
        //     title: Text(_homeController.loading ? 'Connecting...' : 'Chats'),
        //     actions: <Widget>[
        //       IconButton(
        //         icon: Icon(Icons.settings),
        //         onPressed: () {
        //           Navigator.of(context).pushNamed(SettingsScreen.routeName);
        //         },
        //       ),
        //     ],
        //   ),
        //   body: SafeArea(
        //     child: usersList(context),
        //   ),
        //   floatingActionButton: FloatingActionButton(
        //     onPressed: _homeController.openAddChatScreen,
        //     backgroundColor: Theme.of(context).primaryColor,
        //     child: Icon(
        //       Icons.message,
        //       color: Theme.of(context).accentColor,
        //     ),
        //   ),
        // );
      },
    );
  }

  Widget usersList(BuildContext context) {
    // if (_homeController.loading) {
    //   return SliverFillRemaining(
    //     child: Center(
    //       child: CupertinoActivityIndicator(),
    //     ),
    //   );
    // }
    // if (_homeController.error) {
    //   return SliverFillRemaining(
    //     child: Center(
    //       child: Text('Ocorreu um erro ao buscar suas conversas.'),
    //     ),
    //   );
    // }
    if (_homeController.chats.length == 0) {
      return Center(
        child: Text('You have no conversations.'),
      );
    }
    bool theresChatsWithMessages = _homeController.chats.where((chat) {
          return chat.messages.length > 0;
        }).length >
        0;
    if (!theresChatsWithMessages) {
      return Center(
        child: Text('You don\'t have conversations.'),
      );
    }
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: _homeController.chats.map((chat) {
            if (chat.messages.length == 0) {
              return Container(height: 0, width: 0);
            }
            return Column(
              children: <Widget>[
                // userChats(context, chat),
                ChatCard(
                  chat: chat,
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  void stateChanged(bool isShow) {
    isShow ? rotationController.forward() : rotationController.reverse();
  }

  void onClickMenu(MenuItemProvider item) {
    switch (item.menuTitle) {
      case 'Create group':
        _homeController.openAddChatScreen();
        break;
      case 'Chat':
        _homeController.openAddChatScreen();
        break;
      default:
    }
    print('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {}
}
