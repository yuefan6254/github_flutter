import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_flutter/common/localization/localizations.dart';
import 'package:github_flutter/common/utils/common_utils.dart';
import 'package:github_flutter/model/User.dart';
import 'package:github_flutter/model/UserOrg.dart';
import 'package:github_flutter/widgets/gsy_card_item.dart';
import 'package:github_flutter/common/style/gsy_style.dart';
import 'package:github_flutter/widgets/gsy_icon_text.dart';

/**
 * 用户详情 widget
 */

class UserHeaderItem extends StatelessWidget {
  final User userInfo;
  final Color themeColor;
  final List<UserOrg> orgList;
  final Color notifyColor;

  UserHeaderItem(this.userInfo, this.themeColor,
      {this.notifyColor, this.orgList});

  // 用户头像
  _renderProfilePicture() {
    return RawMaterialButton(
      onPressed: null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minHeight: 0.0, minWidth: 0.0),
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: GSYICons.DEFAULT_USER_ICON,
          image: userInfo.avatar_url,
          height: 80.0,
          width: 80.0,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  //通知icon
  _getNotifyIcon() {
    if (notifyColor == null) {
      return Container();
    }

    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
      padding: EdgeInsets.only(top: 0.0, left: 5.0, right: 5.0, bottom: 0.0),
      child: ClipOval(
        child: Icon(
          GSYICons.USER_NOTIFY,
          color: notifyColor,
          size: 18.0,
        ),
      ),
      onPressed: () {},
    );
  }

  // 用户基础信息
  _renderUserInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              userInfo.login ?? "",
              style: GSYConstant.largeTextWhiteBold,
            ),
            _getNotifyIcon(),
          ],
        ),
        Text(
          userInfo.name == null ? "" : userInfo.name,
          style: GSYConstant.smallSubLightText,
        ),
        GSYIconText(
          GSYICons.USER_ITEM_COMPANY,
          userInfo.company ?? GSYLocalizations.i18n(context).nothing_now,
          GSYConstant.smallSubLightText,
          GSYColors.subLightTextColor,
          10.0,
          padding: 3.0,
        ),
        GSYIconText(
          GSYICons.USER_ITEM_LOCATION,
          userInfo.location ?? GSYLocalizations.i18n(context).nothing_now,
          GSYConstant.smallSubLightText,
          GSYColors.subLightTextColor,
          10.0,
          padding: 3.0,
        ),
      ],
    );
  }

  // 用户博客
  _renderBlog(context) {
    return Container(
      margin: EdgeInsets.only(top: 6.0, bottom: 2.0),
      alignment: Alignment.topLeft,
      child: RawMaterialButton(
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.all(0.0),
        constraints: BoxConstraints(minHeight: 0.0, minWidth: 0.0),
        child: GSYIconText(
          GSYICons.USER_ITEM_LINK,
          userInfo.blog ?? GSYLocalizations.i18n(context).nothing_now,
          (userInfo.blog == null)
              ? GSYConstant.smallSubLightText
              : GSYConstant.smallActionLightText,
          GSYColors.subLightTextColor,
          10.0,
          padding: 3.0,
        ),
      ),
    );
  }

  //用户组织
  _renderOrgs(context) {
    if (orgList == null || orgList.length == 0) {
      return Container();
    }
  }

  // 用户创建时间
  _renderCreateTime(context) {
    return Container(
      margin: EdgeInsets.only(top: 6.0, bottom: 2.0),
      alignment: Alignment.topLeft,
      child: Text(
        GSYLocalizations.i18n(context).user_create_at +
            CommonUtils.getDateStr(userInfo.created_at),
        style: GSYConstant.smallSubLightText,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _renderProfilePicture(),
                Padding(padding: EdgeInsets.all(10.0)),
                _renderUserInfo(context),
              ],
            ),
            _renderBlog(context),
            _renderCreateTime(context),
            Padding(padding: EdgeInsets.only(bottom: 5.0))
          ],
        ),
      ),
    );
  }
}

/**
 * 仓库，粉丝，关注 Widget
 */

class UserHeaderBottom extends StatelessWidget {
  final Radius radius;
  final User userInfo;
  final String beStaredCount;
  final List honorList;

  UserHeaderBottom(
      this.userInfo, this.beStaredCount, this.honorList, this.radius);

  // 底部单独方格
  _getBottomItem(String title, var value, onPressed) {
    String data = value == null ? "" : value.toString();

    TextStyle titleStyle = (title != null && title.toString().length > 6)
        ? GSYConstant.minText
        : GSYConstant.smallSubLightText;
    TextStyle valueStyle = (value != null && value.toString().length > 6)
        ? GSYConstant.minText
        : GSYConstant.smallSubLightText;

    return Expanded(
        child: Center(
      child: RawMaterialButton(
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.all(5.0),
        constraints: BoxConstraints(minHeight: 0, minWidth: 0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(text: title, style: titleStyle),
            TextSpan(text: "\n", style: valueStyle),
            TextSpan(text: data, style: valueStyle)
          ]),
        ),
      ),
    ));
  }

  Widget build(BuildContext context) {
    final Widget dividingLine = Container(
      width: 0.3,
      height: 40,
      color: GSYColors.subLightTextColor,
      alignment: Alignment.center,
    );

    return GSYCardItem(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(bottomLeft: radius, bottomRight: radius)),
      child: Container(
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getBottomItem(GSYLocalizations.i18n(context).user_tab_repos,
                userInfo.public_repos, () {}),
            dividingLine,
            _getBottomItem(GSYLocalizations.i18n(context).user_tab_fans,
                userInfo.followers, () {}),
            dividingLine,
            _getBottomItem(GSYLocalizations.i18n(context).user_tab_focus,
                userInfo.following, () {}),
            dividingLine,
            _getBottomItem(GSYLocalizations.i18n(context).user_tab_star,
                userInfo.starred, () {}),
            dividingLine,
            _getBottomItem(GSYLocalizations.i18n(context).user_tab_honor,
                beStaredCount, () {})
          ],
        ),
      ),
    );
  }
}

/**
 * 用户提交图表
 */

class UserHeaderChart extends StatelessWidget {
  final User userInfo;

  UserHeaderChart(this.userInfo);

  // 标题
  _renderTitle(context) {
    return Container(
      child: Text(
        (userInfo.type == 'Organization')
            ? GSYLocalizations.i18n(context).user_dynamic_group
            : GSYLocalizations.i18n(context).user_dynamic_title,
        style: GSYConstant.normalTextBold,
        overflow: TextOverflow.ellipsis,
      ),
      margin: EdgeInsets.only(top: 15, bottom: 15, left: 12),
      alignment: Alignment.topLeft,
    );
  }

  // 提交记录图表
  _renderChart(context) {
    if (userInfo.login != null && userInfo.type == 'Organization') {
      return Container();
    }

    double height = 140.0;
    double width = 3 * MediaQuery.of(context).size.width / 2;

    return Card(
      margin: EdgeInsets.only(top: 0, right: 10, bottom: 0, left: 10),
      color: GSYColors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          child: SvgPicture.network(
            CommonUtils.getUserChartAddress(userInfo.login),
            width: width,
            height: height - 10,
            allowDrawingOutsideViewBox: true,
            placeholderBuilder: (BuildContext context) => Container(
              height: height,
              width: width,
              child: Center(
                child: SpinKitRipple(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _renderTitle(context),
          _renderChart(context),
        ],
      ),
    );
  }
}
