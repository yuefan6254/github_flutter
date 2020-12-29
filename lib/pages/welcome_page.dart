import 'dart:async';
import 'package:github_flutter/redux/gsy_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_flutter/common/dao/user_dao.dart';
import 'package:github_flutter/common/style/gsy_style.dart';
import 'package:github_flutter/common/utils/navigator_utils.dart';

/**
 * 欢迎页
 */

class WelcomePage extends StatefulWidget {
  static final String sName = '/';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (hadInit) {
      return;
    }

    hadInit = true;

    Store<GSYState> store = StoreProvider.of(context);
    new Future.delayed(const Duration(seconds: 2, milliseconds: 500), () async {
      UserDao.initUserInfo(store).then((res) {
        if (res != null && res.result) {
          NavigatorUtils.goHome(context);
        } else {
          NavigatorUtils.goLogin(context);
        }
        return true;
      });
    });
  }

  Widget build(BuildContext context) {
    return Material(
        child: Container(
      color: GSYColors.white,
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              '欢迎页',
              style: TextStyle(fontSize: 24),
            ),
          )
        ],
      ),
    ));
  }
}
