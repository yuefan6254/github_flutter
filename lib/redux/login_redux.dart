import 'package:flutter/cupertino.dart';
import 'package:github_flutter/common/utils/common_utils.dart';
import 'package:github_flutter/redux/gsy_state.dart';
import 'package:github_flutter/redux/middleware/epic_store.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

/**
 * 登录 redux
 */

final LoginReducer = combineReducers<bool>([]);

class OAuthAction {
  final BuildContext context;
  final String code;

  OAuthAction(this.context, this.code);
}

Stream<dynamic> oauthEpic(Stream<dynamic> actions, EpicStore<GSYState> store) {
  Stream _loginIn(OAuthAction action, EpicStore<GSYState> store) {
    CommonUtils.showLoadingDialog(action.context);
    Navigator.pop(action.context);
  }

  return actions
      .whereType<OAuthAction>()
      .switchMap((action) => _loginIn(action, store));
}
