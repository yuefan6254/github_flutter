import 'package:flutter/material.dart';
import 'package:github_flutter/common/style/gsy_style.dart';

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
  }

  Widget build(BuildContext context) {
    return Material(
        child: Container(
      color: GSYColors.white,
      child: Stack(
        children: <Widget>[Text('欢迎页')],
      ),
    ));
  }
}
