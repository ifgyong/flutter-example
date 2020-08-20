import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest01/tips/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:fluttertest01/tips/bloc/login_bloc/view/login2_view.dart';

///
/// Created by fgyong on 2020/8/19.
///
/// 使用[bloc]完成的登陆功能
class LoginBlocRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: BaseLogin2Page(),
      create: (_) => LoginBloc(LoginState2()),
    );
  }
}
