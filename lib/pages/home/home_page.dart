import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 主页
 */

class HomePage extends StatefulWidget {
  static final String sName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    // 如果是android回到桌面
    if (Platform.isAndroid) {
      // AndroidIntent intent = AndroidIntent(
      //   action: 'an'
      // );
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return _dialogExitApp(context);
        },
        child: Scaffold(
          body: Container(
            child: Text('退出应用'),
          ),
        ));
  }
}
