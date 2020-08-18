import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<fishReduxState> buildEffect() {
  return combineEffects(<Object, Effect<fishReduxState>>{
    fishReduxAction.action: _onAction,
  });
}

void _onAction(Action action, Context<fishReduxState> ctx) {
  print('_onAction');
}
