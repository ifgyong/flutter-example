import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

///
/// Created by fgyong on 2020/8/19.
///
enum LoginState {
  success,
  faild,
  isLoading,
}
enum BtnState { available, unAvailable }

class LoginModel extends Equatable {
  final String name;
  final String password;
  final LoginState state;
  LoginModel({this.name, this.password, this.state});
  @override
  List<Object> get props => [name, password, state, btnVisiable];
  LoginModel copyWith({String name, String pwd, LoginState loginState}) {
    return LoginModel(
        name: name ?? this.name,
        password: pwd ?? this.password,
        state: loginState ?? this.state);
  }

  bool get btnVisiable =>
      (password?.isNotEmpty ?? false) && (name?.isNotEmpty ?? false);
  @override
  String toString() {
    return '$props';
  }
}
