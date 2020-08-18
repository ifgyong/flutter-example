import 'package:fish_redux/fish_redux.dart';

class fishReduxState implements Cloneable<fishReduxState> {

  @override
  fishReduxState clone() {
    return fishReduxState();
  }
}

fishReduxState initState(Map<String, dynamic> args) {
  return fishReduxState();
}
