import 'package:flutter/material.dart';
import 'package:github_flutter/common/localization/localizations.dart';
import 'package:github_flutter/common/style/gsy_style.dart';
import 'package:github_flutter/common/utils/common_utils.dart';
import 'package:github_flutter/widgets/gsy_input_widget.dart';
import 'package:github_flutter/widgets/animated_background.dart';
import 'package:github_flutter/widgets/particle/particle_widget.dart';

/**
 * 登录页
 */

class LoginPage extends StatefulWidget {
  static final String sName = 'login';

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
          body: Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Positioned.fill(child: AnimatedBackground()),
            Positioned.fill(child: ParticleWidget(30)),
            Center(
                child: SafeArea(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 5.0,
                  color: GSYColors.cardWhite,
                  margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 40.0, bottom: 0.0),
                    child: Column(
                      children: [
                        GSYInputWidget(
                          hitText: GSYLocalizations.i18n(context)
                              .login_username_hint_text,
                          iconData: GSYICons.LOGIN_USER,
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        GSYInputWidget(
                          hitText: GSYLocalizations.i18n(context)
                              .login_password_hint_text,
                          iconData: GSYICons.LOGIN_PW,
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        InkWell(
                          onTap: () => CommonUtils.showLanguageDialog(context),
                          child: Text(
                            GSYLocalizations.i18n(context).switch_language,
                            style: TextStyle(color: GSYColors.subTextColor),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(15.0))
                      ],
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      )),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
    );
  }
}
