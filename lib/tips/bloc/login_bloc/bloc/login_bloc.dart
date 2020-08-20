import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../model/login_models.dart';
part 'login_event.dart';
part 'login_state.dart';

///
/// Created by fgyong on 2020/8/19.
///

class LoginBloc extends Bloc<LoginEvent, LoginState2> {
  LoginBloc(initialState) : super(initialState);

  @override
  Stream<LoginState2> mapEventToState(event) async* {
    if (event is LoginChagneName) {
      yield _mapChangeUserNameToState(event, state);
    } else if (event is LoginChagnePassword) {
      yield _mapChangePasswordToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapSubmittedToState(event, state);
    }
  }

  /// 改变密码
  LoginState2 _mapChangePasswordToState(
      LoginChagnePassword event, LoginState2 state2) {
    return state2.copyWith(pwd: event.password ?? '');
  }

  /// 改变名字
  LoginState2 _mapChangeUserNameToState(
      LoginChagneName event, LoginState2 state2) {
    return state2.copyWith(name: event.name ?? '');
  }

  /// 提交
  Stream<LoginState2> _mapSubmittedToState(
      LoginSubmitted event, LoginState2 state2) async* {
    try {
      if (state2.name.isNotEmpty && state2.password.isNotEmpty) {
        yield state2.copyWith(login2progress: Login2Progress.isRequesting);
        await Future.delayed(Duration(seconds: 2));
        yield state2.copyWith(login2progress: Login2Progress.success);

        yield state2.copyWith(login2progress: Login2Progress.init);
      }
    } on Exception catch (e) {
      yield state2.copyWith(login2progress: Login2Progress.error);
    }
  }
}
