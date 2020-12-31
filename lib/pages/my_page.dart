import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_flutter/common/style/gsy_style.dart';
import 'package:github_flutter/pages/user/base_person_state.dart';
import 'package:github_flutter/redux/gsy_state.dart';

/**
 * 我的 tab页
 */

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends BasePersonState<MyPage> {
  String beStaredCount = '---';
  Color notifyColor = GSYColors.subTextColor;

  @override
  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    super.build(context);
    return StoreBuilder<GSYState>(
      builder: (context, store) {
        return Scaffold(
          body: CustomScrollView(
            slivers: sliverBuilder(context, false, store.state.userInfo,
                notifyColor, beStaredCount, () {}),
          ),
        );
      },
    );
  }
}
