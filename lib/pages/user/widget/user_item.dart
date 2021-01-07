import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_flutter/common/style/gsy_style.dart';
import 'package:github_flutter/model/User.dart';
import 'package:github_flutter/model/SearchUserQL.dart';
import 'package:github_flutter/model/UserOrg.dart';
import 'package:github_flutter/redux/gsy_state.dart';
import 'package:github_flutter/widgets/gsy_card_item.dart';

/**
 * 用户item
 */

class UserItem extends StatelessWidget {
  final UserItemViewModel userItemViewModel;

  final VoidCallback onPressed;
  final bool needImage;

  UserItem(this.userItemViewModel, {this.onPressed, this.needImage = true})
      : super();

  @override
  Widget build(BuildContext context) {
    var me = StoreProvider.of<GSYState>(context).state.userInfo;

    Widget userImage = IconButton(
      onPressed: null,
      padding: EdgeInsets.only(top: 0.0, right: 0.0, bottom: 0.0, left: 0.0),
      icon: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: GSYICons.DEFAULT_USER_ICON,
          fit: BoxFit.fitWidth,
          image: userItemViewModel.userPic,
          width: 40.0,
          height: 40.0,
        ),
      ),
    );

    return Container(
      child: GSYCardItem(),
    );
  }
}

class UserItemViewModel {
  String userPic;
  String userName;
  String bio;
  int followers;
  String login;
  String lang;
  String index;

  UserItemViewModel.fromMap(User user) {
    userName = user.login;
    userPic = user.avatar_url;
    followers = user.followers;
  }

  UserItemViewModel.fromQL(SearchUserQL user, int index) {
    userName = user.name;
    userPic = user.avatarUrl;
    followers = user.followers;
    bio = user.bio;
    login = user.login;
    lang = user.lang;
    this.index = index.toString();
  }

  UserItemViewModel.fromOrgMap(UserOrg org) {
    userName = org.login;
    userPic = org.avatarUrl;
  }
}
