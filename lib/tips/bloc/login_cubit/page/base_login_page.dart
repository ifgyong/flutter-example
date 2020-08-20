import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../base_login_cubit.dart';

///
/// Created by fgyong on 2020/8/19.
///
class BaseLoginPageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(LoginModel()),
      child: BaseLoginPage(),
    );
  }

  static String routeName = '/BaseLoginPageRoute';
  MaterialPageRoute get route =>
      MaterialPageRoute(builder: (_) => BaseLoginPageRoute());
}
