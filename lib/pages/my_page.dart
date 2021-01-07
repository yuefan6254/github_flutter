import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_flutter/common/dao/event_dao.dart';
import 'package:github_flutter/common/style/gsy_style.dart';
import 'package:github_flutter/model/UserOrg.dart';
import 'package:github_flutter/pages/user/base_person_state.dart';
import 'package:github_flutter/redux/gsy_state.dart';
import 'package:github_flutter/redux/user_redux.dart';
import 'package:github_flutter/widgets/pull/gsy_pull_load_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_flutter/model/User.dart';

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
  void initState() {
    super.initState();
    pullLoadWidgetControl.needLoadMore.value = true;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => true;

  @override
  requestRefresh() async {
    final String userName =
        StoreProvider.of<GSYState>(context)?.state?.userInfo?.login;

    if (userName != null) {
      // StoreProvider.of<GSYState>(context).dispatch(FetchUserAction());

      return await EventDao.getEventDao(userName, page: page, needDb: false);
    }
  }

  @override
  requestLoadMore() async {
    final String userName =
        StoreProvider.of<GSYState>(context)?.state?.userInfo?.login;

    if (userName != null) {
      // StoreProvider.of<GSYState>(context).dispatch(FetchUserAction());

      return await EventDao.getEventDao(userName, page: page, needDb: false);
    }
  }

  Widget build(BuildContext context) {
    super.build(context);
    return StoreBuilder<GSYState>(
      builder: (context, store) {
        return GSYPullLoadWidget(
          refreshKey: refreshKey,
          control: pullLoadWidgetControl,
          onRefresh: handleRefresh,
          headerSliverBuilder: (context, _) {
            return sliverBuilder(context, false, store.state.userInfo,
                notifyColor, beStaredCount, () {});
          },
          itemBuilder: (BuildContext context, int index) => renderItem(index,
              store.state.userInfo, beStaredCount, notifyColor, () {}, orgList),
        );
      },
    );
  }
}
