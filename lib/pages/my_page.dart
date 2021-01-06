import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_flutter/common/style/gsy_style.dart';
import 'package:github_flutter/pages/user/base_person_state.dart';
import 'package:github_flutter/redux/gsy_state.dart';
import 'package:github_flutter/widgets/pull/gsy_pull_load_widget.dart';

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

  @override
  void initState() {
    super.initState();
    pullLoadWidgetControl.needLoadMore.value = true;
  }

  Widget build(BuildContext context) {
    super.build(context);
    return StoreBuilder<GSYState>(
      builder: (context, store) {
        return GSYPullLoadWidget(
          control: pullLoadWidgetControl,
          onRefresh: handleRefresh,
          headerSliverBuilder: (context, _) {
            return sliverBuilder(context, false, store.state.userInfo,
                notifyColor, beStaredCount, () {});
          },
        );
      },
    );
  }
}
