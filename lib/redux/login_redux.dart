import 'package:flutter/cupertino.dart';
import 'package:github_flutter/common/dao/user_dao.dart';
import 'package:github_flutter/common/utils/common_utils.dart';
import 'package:github_flutter/common/utils/navigator_utils.dart';
import 'package:github_flutter/redux/gsy_state.dart';
import 'package:github_flutter/redux/middleware/epic_store.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

/**
 * 登录 redux
 */

final LoginReducer = combineReducers<bool>([
  TypedReducer<bool, LoginSuccessAction>(_loginResult),
]);

bool _loginResult(bool result, LoginSuccessAction action) {
  if (action.success == true) {
    NavigatorUtils.goHome(action.context);
  }

  return action.success;
}

class OAuthAction {
  final BuildContext context;
  final String code;

  OAuthAction(this.context, this.code);
}

class LoginSuccessAction {
  final BuildContext context;
  final bool success;

  LoginSuccessAction(this.context, this.success);
}

Stream<dynamic> oauthEpic(Stream<dynamic> actions, EpicStore<GSYState> store) {
  Stream _loginIn(OAuthAction action, EpicStore<GSYState> store) async* {
    CommonUtils.showLoadingDialog(action.context);
    var res = await UserDao.oauth(action.code, store);
    // Navigator.pop(action.context);
    yield LoginSuccessAction(action.context, (res != null && res.result));
  }

  return actions
      .whereType<OAuthAction>()
      .switchMap((action) => _loginIn(action, store));
}
