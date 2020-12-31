import 'package:flutter/material.dart';
import 'package:github_flutter/model/User.dart';
import 'package:github_flutter/model/SearchUserQL.dart';
import 'package:github_flutter/model/UserOrg.dart';

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
  Widget build(BuildContext context) {}
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
