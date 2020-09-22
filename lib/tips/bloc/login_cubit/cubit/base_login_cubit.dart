import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest01/tips/bloc/login_cubit/model/base_login_model.dart';
import 'package:equatable/equatable.dart';

///
/// Created by fgyong on 2020/8/19.
///

class LoginCubit extends Cubit<LoginModel> {
  LoginCubit(state) : super(state);
  void login() async {
    emit(state.copyWith(loginState: LoginState.isLoading));
    await Future.delayed(Duration(seconds: 2));
    if (state.btnVisiable == true)
      emit(state.copyWith(loginState: LoginState.success));
    emit(state.copyWith(loginState: LoginState.faild));
  }

  void logOut() async {
    emit(state.copyWith(
      name: null,
      pwd: null,
    ));
  }

  void changeName({String name}) {
    emit(state.copyWith(
        name: name, pwd: state.password, loginState: state.state));
  }

  void changePassword({String pwd}) {
    emit(state.copyWith(name: state.name, pwd: pwd, loginState: state.state));
  }

  ///
  /// 把所有之间集中于一个函数，只用不同的class来区分事件
  /// 类似 mapToState
  void handleLoginEvents(LoginEvent event) {
    switch (event.runtimeType) {
      case LoginCubitChagneName:
        emit(state.copyWith(name: (event as LoginCubitChagneName).name));
        break;
      case LoginCubitChagnePassword:
        emit(state.copyWith(pwd: (event as LoginCubitChagnePassword).password));
        break;
      case LoginCubitSubmitted:
        emit(state.copyWith(loginState: LoginState.isLoading));
        Future.delayed(Duration(seconds: 2)).then((_) {
          emit(state.copyWith(
              loginState: state.btnVisiable == true
                  ? LoginState.success
                  : LoginState.faild));
        });
        break;
    }
  }
}

/// 登陆相关的事件
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

/// 修改密码
class LoginCubitChagnePassword extends LoginEvent {
  final String password;
  const LoginCubitChagnePassword({this.password});
  @override
  List<Object> get props => [password];
}

/// 修改账户
class LoginCubitChagneName extends LoginEvent {
  final String name;
  const LoginCubitChagneName({this.name});
  @override
  List<Object> get props => [name];
}

/// 提交事件
class LoginCubitSubmitted extends LoginEvent {
  const LoginCubitSubmitted();
  @override
  List<Object> get props => [];
}
