import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_flutter/redux/gsy_state.dart';
import 'package:github_flutter/redux/theme_redux.dart';

/**
 * 动态 tab页
 */

class DynamicPage extends StatefulWidget {
  DynamicPage({Key key}) : super(key: key);
  @override
  DynamicPageState createState() => DynamicPageState();
}

class DynamicPageState extends State<DynamicPage> {
  void changeThemeData(BuildContext context, Store store) {
    print("我点击了");
    ThemeData themeData = ThemeData(primarySwatch: Colors.blue);
    print("$themeData");
    print(store.state.login);
    // StoreProvider.of<GSYState>(context)
    //     .dispatch(RefreshThemeDataAction(themeData));
    store.dispatch(new RefreshThemeDataAction(themeData));
  }

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    print(StoreProvider.of<GSYState>(context).state.themeData);

    return StoreBuilder<GSYState>(
      builder: (context, store) {
        return Scaffold(
          body: Center(
            child: Text('${store.state.themeData}'),
          ),
          floatingActionButton: FloatingActionButton(
            child: Text('点击'),
            onPressed: () => changeThemeData(context, store),
          ),
        );
      },
    );
  }
}
