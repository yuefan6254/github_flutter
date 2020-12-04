import 'package:flutter/material.dart';
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

    Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      NavigatorUtils.goHome(context);
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
