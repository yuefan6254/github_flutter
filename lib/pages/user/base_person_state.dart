import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:github_flutter/model/User.dart';
import 'package:github_flutter/widgets/pull/nested/gsy_sliver_header_delegate.dart';
import 'package:github_flutter/pages/user/widget/user_header.dart';

/**
 * 个人详情页 基础抽象类
 */

abstract class BasePersonState<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<T> {
  List<Widget> sliverBuilder(BuildContext context, bool innerBoxIsScrolled,
      User userInfo, Color notifyColor, String beStaredCount, refreshCallback) {
    double headerSize = 210;
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
                        userInfo, Theme.of(context).primaryColor)),
              ),
            );
          },
        ),
      ),
    ];
  }
}
