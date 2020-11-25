import 'package:Pigeon/src/screens/settings/settings_controller.dart';
import 'package:Pigeon/src/widgets/custom_app_bar.dart';
import 'package:Pigeon/src/widgets/custom_cupertino_sliver_navigation_bar.dart';
import 'package:Pigeon/src/widgets/settings_container.dart';
import 'package:Pigeon/src/widgets/settings_item.dart';
import 'package:Pigeon/src/widgets/user_info_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static final String routeName = '/settings';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsController _settingsController;

  @override
  void initState() {
    _settingsController = SettingsController(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _settingsController.streamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Color(0xFFEEEEEE),
            appBar: CustomAppBar(
              title: Text('settings', style: TextStyle(color: Colors.black)),
            ),
            body: SafeArea(
              child: Container(
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    renderMyUserCard(),
                    SizedBox(
                      height: 30,
                    ),
                    SettingsContainer(
                      children: [
                        SettingsItem(
                          icon: Icons.delete_outline,
                          iconBackgroundColor: Colors.grey,
                          title: 'Delete conversations',
                          onTap: _settingsController.openModalDeleteChats,
                        ),
                        SettingsItem(
                          icon: Icons.exit_to_app,
                          iconBackgroundColor: Colors.red,
                          title: 'Get out',
                          onTap: _settingsController.openModalExitApp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget renderMyUserCard() {
    if (_settingsController.myUser != null) {
      return UserInfoItem(
        name: _settingsController.myUser.name,
        subtitle: "@${_settingsController.myUser.phone}",
      );
    }
    return Container();
  }
}
