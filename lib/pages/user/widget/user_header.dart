import 'package:flutter/material.dart';
import 'package:github_flutter/model/User.dart';
import 'package:github_flutter/widgets/gsy_card_item.dart';
import 'package:github_flutter/common/style/gsy_style.dart';

/**
 * 用户详情头部
 */

class UserHeaderItem extends StatelessWidget {
  final User userInfo;
  final Color themeColor;

  UserHeaderItem(this.userInfo, this.themeColor);

  // 用户头像
  _renderProfilePicture() {
    return RawMaterialButton(
      onPressed: null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minHeight: 0.0, minWidth: 0.0),
      child: ClipOval(
        // child: Image(
        //   image: userInfo.avatar_url,
        // ),
        child: FadeInImage.assetNetwork(
          placeholder: GSYICons.DEFAULT_USER_ICON,
          image: userInfo.avatar_url,
          height: 80.0,
          width: 80.0,
        ),
      ),
    );
  }

  //通知icon
  _getNotifyIcon() {}

  // 用户基础信息
  _renderUserInfo() {}

  // 用户博客
  _renderBlog() {}

  //用户组织
  _renderOrgs() {}

  // 用户创建时间
  _renderCreateTime() {}

  @override
  Widget build(BuildContext context) {
    return GSYCardItem(
      color: themeColor,
      elevation: 0,
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0))),
      child: Padding(
        padding:
            EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _renderProfilePicture(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
