import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_flutter/common/local/local_storage.dart';
import 'package:github_flutter/common/localization/localizations.dart';
import 'package:github_flutter/common/style/gsy_style.dart';
import 'package:github_flutter/common/utils/common_utils.dart';
import 'package:github_flutter/common/utils/navigator_utils.dart';
import 'package:github_flutter/redux/gsy_state.dart';
import 'package:github_flutter/redux/login_redux.dart';
import 'package:github_flutter/widgets/gsy_flex_button.dart';
import 'package:github_flutter/widgets/gsy_input_widget.dart';
import 'package:github_flutter/widgets/animated_background.dart';
import 'package:github_flutter/widgets/particle/particle_widget.dart';
import 'package:github_flutter/common/config/config.dart';
import 'package:github_flutter/common/net/address.dart';

/**
 * 登录页
 */

class LoginPage extends StatefulWidget {
  static final String sName = 'login';

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginBloc {
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
                          controller: userController,
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        GSYInputWidget(
                          hitText: GSYLocalizations.i18n(context)
                              .login_password_hint_text,
                          iconData: GSYICons.LOGIN_PW,
                          controller: pwController,
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Container(
                            child: Row(
                          children: [
                            Expanded(
                                child: GSYFlexButton(
                              text: GSYLocalizations.i18n(context).login_text,
                              color: Theme.of(context).primaryColor,
                              textColor: GSYColors.textWhite,
                              fontSize: 16,
                              onPress: loginIn,
                            )),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                                child: GSYFlexButton(
                              text: GSYLocalizations.i18n(context).oauth_text,
                              color: Theme.of(context).primaryColor,
                              textColor: GSYColors.textWhite,
                              fontSize: 16,
                              onPress: oauthIn,
                            ))
                          ],
                        )),
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

mixin LoginBloc on State<LoginPage> {
  var _username = "";
  var _password = "";
  final TextEditingController userController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initParams();
    userController.addListener(_usernameChange);
    pwController.addListener(_passwordChange);
  }

  initParams() async {
    _username = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);
    userController.value = TextEditingValue(text: _username ?? "");
    pwController.value = TextEditingValue(text: _password ?? "");
  }

  @override
  void dispose() {
    super.dispose();
    userController.removeListener(_usernameChange);
    pwController.removeListener(_passwordChange);
  }

  _usernameChange() {
    _username = userController.text;
  }

  _passwordChange() {
    _password = pwController.text;
  }

  loginIn() {
    Fluttertoast.showToast(
        msg: GSYLocalizations.i18n(context).Login_deprecated,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG);
  }

  oauthIn() async {
    String code = await NavigatorUtils.goLoginWebView(context,
        Address.getOauthUrl(), GSYLocalizations.i18n(context).oauth_text);

    print("########### $code");

    if (code != null && code.length > 0) {
      print("########### 执行逻辑");
      StoreProvider.of<GSYState>(context).dispatch(OAuthAction(context, code));
    }
  }
}
