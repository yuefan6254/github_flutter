import 'package:flutter/material.dart';
import 'package:github_flutter/common/style/gsy_style.dart';
import 'package:github_flutter/common/utils/common_utils.dart';
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
        login: false,
        themeData: CommonUtils.getThemeDtata(GSYColors.primarySwatch),
        locale: Locale('zh', 'en')),
  );
  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new StoreBuilder<GSYState>(builder: (context, store) {
        store.state.platformLocale = WidgetsBinding.instance.window.locale;
        return MaterialApp(
          theme: store.state.themeData,
          // 命名式路由
          routes: {
            WelcomePage.sName: (context) {
              return WelcomePage();
            },
            HomePage.sName: (context) {
              return HomePage();
            }
          },
        );
      }),
    );
  }
}
