import 'package:contacts_app/ioscall.dart';
import 'package:contacts_app/ioschat.dart';
import 'package:contacts_app/ioscontact.dart';
import 'package:contacts_app/iossetting.dart';
import 'package:contacts_app/platformprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CupertionPage extends StatefulWidget {
  const CupertionPage({super.key});

  @override
  State<CupertionPage> createState() => _CupertionPageState();
}

List<Widget> tabList = [
  iosContact(),
  iosChat(),
  iosCall(),
  iosSetting(),
];

class _CupertionPageState extends State<CupertionPage> {
  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Platform Converter'),
          trailing: CupertinoSwitch(
              value: providerVar.getPlatform,
              onChanged: (value) {
                providerVar.setPlatform = value;
              })),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_add_solid)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble_2),label: 'CHATS'),
          BottomNavigationBarItem(icon: Icon(Icons.call),label: 'CALLS'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings),label: 'SETTINGS'),
        ]),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return Center(child: tabList[index]);
            },
          );
        },
      ),
    );
  }
}
