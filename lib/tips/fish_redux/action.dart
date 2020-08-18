import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum fishReduxAction { action }

class fishReduxActionCreator {
  static Action onAction() {
    return const Action(fishReduxAction.action);
  }
}
