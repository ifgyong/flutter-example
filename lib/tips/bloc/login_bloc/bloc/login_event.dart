part of '../bloc/login_bloc.dart';

///
/// Created by fgyong on 2020/8/20.
///
/// 登陆相关的事件
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

/// 修改密码
class LoginChagnePassword extends LoginEvent {
  final String password;
  const LoginChagnePassword({this.password});
  @override
  List<Object> get props => [password];
}

/// 修改账户
class LoginChagneName extends LoginEvent {
  final String name;
  const LoginChagneName({this.name});
  @override
  List<Object> get props => [name];
}

/// 提交事件
class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
  @override
  List<Object> get props => [];
}
