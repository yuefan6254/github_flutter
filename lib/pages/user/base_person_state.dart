import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:github_flutter/common/dao/user_dao.dart';
import 'package:github_flutter/model/User.dart';
import 'package:github_flutter/model/UserOrg.dart';
import 'package:github_flutter/widgets/gsy_event_item.dart';
import 'package:github_flutter/widgets/pull/gsy_sliver_header_delegate.dart';
import 'package:github_flutter/pages/user/widget/user_header.dart';
import 'package:github_flutter/widgets/state/gsy_list_state.dart';
import 'package:provider/provider.dart';
import 'package:github_flutter/model/Event.dart';

/**
 * 个人详情页 基础抽象类
 */

abstract class BasePersonState<T extends StatefulWidget> extends State<T>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<T>,
        GSYListState<T> {
  final List<UserOrg> orgList = List();
  final HonorModel honorModel = HonorModel();
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @protected
  getUserOrg(String userName) {
    if (page <= 1 && userName != null) {
      UserDao.getUserOrgsDao(userName, page, needDb: true).then((res) {
        if (res != null && res.result) {
          setState(() {
            orgList.clear();
            orgList.addAll(res.data);
          });

          return res.next?.call();
        }

        return Future.value(null);
      }).then((res) {
        if (res != null && res.result) {
          setState(() {
            orgList.clear();
            orgList.addAll(res.data);
          });

          return res.next?.call();
        }
      });
    }
  }

  @override
  showRefreshLoading() {
    print("basePersonState 刷新");
    Future.delayed(Duration(seconds: 0), () {
      refreshKey.currentState.show().then((value) => null);
    });
  }

  @protected
  renderItem(index, User userInfo, String beStaredCount, Color notifyColor,
      VoidCallback refreshCallBack, List<UserOrg> orgList) {
    Event event = pullLoadWidgetControl.dataList[index];
    return GSYEventItem(
      eventViewModel: EventViewModel.fromEventMap(event),
      onPressed: () {},
    );
  }

  List<Widget> sliverBuilder(BuildContext context, bool innerBoxIsScrolled,
      User userInfo, Color notifyColor, String beStaredCount, refreshCallback) {
    double headerSize = 210;
    double bottomSize = 70;
    double chartSize =
        (userInfo.login != null && userInfo.type == "Organization") ? 70 : 215;

    return <Widget>[
      // 头部信息
      SliverPersistentHeader(
        pinned: true,
        delegate: GSYSliverHeaderDelegate(
          maxHeight: headerSize,
          minHeight: headerSize,
          changeSize: true,
          vSyncs: this,
          snapConfig: FloatingHeaderSnapConfiguration(
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: 10),
          ),
          builder: (BuildContext context, double shrinkOffset,
              bool overlapsContent) {
            return Transform.translate(
              offset: Offset(0, -shrinkOffset),
              child: SizedBox.expand(
                child: Container(
                  child: UserHeaderItem(
                    userInfo,
                    Theme.of(context).primaryColor,
                    notifyColor: notifyColor,
                    orgList: orgList,
                  ),
                ),
              ),
            );
          },
        ),
      ),

      // 悬停
      SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: GSYSliverHeaderDelegate(
          minHeight: bottomSize,
          maxHeight: bottomSize,
          changeSize: true,
          vSyncs: this,
          snapConfig: FloatingHeaderSnapConfiguration(
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: 10),
          ),
          builder: (BuildContext context, double shrinkOffset,
              bool overlapsContent) {
            var radius = Radius.circular(10 - shrinkOffset / bottomSize * 10);
            return SizedBox.expand(
              child: Padding(
                padding: EdgeInsets.only(right: 0.0, bottom: 10, left: 0),
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => honorModel)
                  ],
                  child: Consumer<HonorModel>(
                    builder: (context, honorModel, _) {
                      return UserHeaderBottom(
                          userInfo,
                          honorModel.beStaredCount?.toString() ?? "---",
                          honorModel.honorList,
                          radius);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),

      // 提交图表
      SliverPersistentHeader(
          delegate: GSYSliverHeaderDelegate(
        minHeight: chartSize,
        maxHeight: chartSize,
        snapConfig: FloatingHeaderSnapConfiguration(
          curve: Curves.bounceInOut,
          duration: Duration(milliseconds: 10),
        ),
        vSyncs: this,
        changeSize: true,
        builder:
            (BuildContext context, double shrinkOffset, bool overlapsContent) {
          return SizedBox.expand(
            child: Container(
              height: chartSize,
              child: UserHeaderChart(userInfo),
            ),
          );
        },
      )),
    ];
  }
}

class HonorModel extends ChangeNotifier {
  int _beStaredCount;

  int get beStaredCount => _beStaredCount;

  set beStaredCount(int value) {
    _beStaredCount = value;
    notifyListeners();
  }

  List _honorList;
  List get honorList => _honorList;

  set honorList(List value) {
    _honorList = value;
    notifyListeners();
  }
}
