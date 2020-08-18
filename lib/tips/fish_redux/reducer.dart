import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<fishReduxState> buildReducer() {
  return asReducer(
    <Object, Reducer<fishReduxState>>{
      fishReduxAction.action: _onAction,
    },
  );
}

fishReduxState _onAction(fishReduxState state, Action action) {
  final fishReduxState newState = state.clone();
  return newState;
}
