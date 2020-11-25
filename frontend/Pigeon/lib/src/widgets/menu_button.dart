import 'package:Pigeon/config/assets.dart';
import 'package:Pigeon/src/screens/settings/settings_view.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

Widget menuButtons(context) {
  return BottomAppBar(
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 60,
        ),
        IconButton(
          onPressed: () {},
          icon: new Image.asset(
            Assets.chat,
            height: 25,
            color: MyColors.primaryColor,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: new Image.asset(
            Assets.search,
            height: 25,
            color: MyColors.primaryColor,
          ),
        ),
        SizedBox(
          width: 60,
        ),
        IconButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return CameraExampleHome();
            //     },
            //   ),
            // );
          },
          icon: new Image.asset(
            Assets.camera_diff,
            height: 25,
            color: MyColors.primaryColor,
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
            icon: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/people/Ankit_sagar_4027f99669eac45eae5027722524d2caa37d0c1b.jpeg'),
              // MemoryImage(decodedBase64ImgOfFriend),
            )),
      ],
    ),
    shape: CircularNotchedRectangle(),
    notchMargin: 6.0,
    color: Colors.white,
  );
}
