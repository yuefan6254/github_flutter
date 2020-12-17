import 'dart:async';

import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';
import 'epic.dart';
import 'epic_store.dart';

class EpicMiddleware<State> extends MiddlewareClass<State> {
  final StreamController<dynamic> _actions =
      StreamController<dynamic>.broadcast();
  final StreamController<Epic<State>> _epics =
      StreamController.broadcast(sync: true);

  final bool supportAsyncGenerators;
  Epic<State> _epic;
  bool _isSubscribed = false;

  EpicMiddleware(Epic<State> epic, {this.supportAsyncGenerators = true})
      : _epic = epic;

  void call(Store<State> store, dynamic action, NextDispatcher next) {
    if (!_isSubscribed) {
      _epics.stream
          .switchMap<dynamic>((epic) => epic(_actions.stream, EpicStore(store)))
          .listen(store.dispatch);

      _epics.add(_epic);
      _isSubscribed = true;
    }

    next(action);

    if (supportAsyncGenerators) {
      Future.delayed(Duration.zero, () {
        _actions.add(action);
      });
    } else {
      _actions.add(action);
    }
  }

  Epic<State> get epic => _epic;

  set epic(Epic<State> newEpic) {
    _epic = newEpic;
    _epics.add(newEpic);
  }
}
