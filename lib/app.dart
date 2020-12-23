import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:github_flutter/common/event/event_bus.dart';
import 'package:github_flutter/common/event/http_error_event.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_flutter/common/localization/localizations.dart';
import 'package:github_flutter/common/net/code.dart';
import 'package:github_flutter/common/localization/gsy_localizations_delegate.dart';
import 'package:github_flutter/common/style/gsy_style.dart';
import 'package:github_flutter/common/utils/common_utils.dart';
import 'package:github_flutter/pages/login/login_page.dart';
import 'package:github_flutter/redux/gsy_state.dart';
import 'pages/welcome_page.dart';
import 'pages/home/home_page.dart';
import 'package:redux/redux.dart';
import 'model/User.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FlutterReduxApp extends StatefulWidget {
  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp> {
  // 创建容器
  final store = new Store<GSYState>(
    appReducer,

    // 中间件
    middleware: middleware,

    // 初始化数据
    initialState: new GSYState(
        userInfo: User.empty(),
        login: true,
        themeData: CommonUtils.getThemeDtata(GSYColors.primarySwatch),
        locale: null),
  );
  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new StoreBuilder<GSYState>(builder: (context, store) {
        store.state.platformLocale = WidgetsBinding.instance.window.locale;
        return MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GSYLocalizationsDelege.delegate
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {},
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('zh', 'CN')
          ],
          locale: store.state.locale,
          theme: store.state.themeData,
          // locale: store.state.locale,
          // 命名式路由
          routes: {
            WelcomePage.sName: (context) {
              return WelcomePage();
            },
            HomePage.sName: (context) {
              return HomePage();
            },
            LoginPage.sName: (context) {
              return LoginPage();
            }
          },
        );
      }),
    );
  }
}

mixin HttpErrorListener on State<FlutterReduxApp> {
  StreamSubscription stream;
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    stream = eventBus
        .on<HttpErrorEvent>()
        .listen((event) => errorHandleFunction(event.code, event.message));
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  // 网络错误提醒
  errorHandleFunction(int code, String message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        showToast(GSYLocalizations.i18n(context).network_error);
        break;
      case 401:
        showToast(GSYLocalizations.i18n(context).network_error_401);
        break;
      case 403:
        showToast(GSYLocalizations.i18n(context).network_error_403);
        break;
      case 404:
        showToast(GSYLocalizations.i18n(context).network_error_404);
        break;
      case 422:
        showToast(GSYLocalizations.i18n(context).network_error_422);
        break;
      case Code.NETWORK_TIMEOUT:
        showToast(GSYLocalizations.i18n(context).network_error_timeout);
        break;
      case Code.GITHUB_API_REFUSED:
        showToast(GSYLocalizations.i18n(context).github_refused);
        break;
      default:
        showToast(
            GSYLocalizations.i18n(context).network_error_unknown + " $message");
        break;
    }
  }

  // toast 提示框
  showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
