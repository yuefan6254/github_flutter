import 'package:github_flutter/common/dao/user_dao.dart';
import 'package:github_flutter/redux/gsy_state.dart';
import 'package:redux/redux.dart';
import 'package:github_flutter/model/User.dart';
import 'middleware/epic_store.dart';
import 'package:rxdart/rxdart.dart';

/**
 * 用户相关redux
 */

// 通过typedReducer将UpdateUserAction和reducers关联
final UserReducer = combineReducers<User>([
  TypedReducer<User, UpadateUserAction>(_updateLoaded),
]);

// UpdateUserAction 发起请求，由_updateLoaded进行逻辑处理
User _updateLoaded(User user, action) {
  user = action.userInfo;
  return user;
}

class UpadateUserAction {
  final User userInfo;

  UpadateUserAction(this.userInfo);
}

class FetchUserAction {}

// 用户信息state 中间件
class UserInfoMiddleware implements MiddlewareClass<GSYState> {
  void call(Store<GSYState> store, dynamic action, NextDispatcher next) {
    if (action is UpadateUserAction) {
      print("*********** UserInfoMiddleware *********** ");
    }

    next(action);
  }
}

Stream<dynamic> userInfoEpic(
    Stream<dynamic> actions, EpicStore<GSYState> store) {
  Stream<dynamic> _loadUserInfo() async* {
    print("*********** userInfoEpic _loadUserInfo ***********");
    var res = await UserDao.getUserInfo(null);
    yield UpadateUserAction(res.data);
  }

  return actions
      .whereType<FetchUserAction>()
      .debounce((_) => TimerStream(true, const Duration(milliseconds: 10)))
      .switchMap((action) => _loadUserInfo());
}
