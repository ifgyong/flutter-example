import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest01/tips/bloc/login_bloc/bloc/login_bloc.dart';

///
/// Created by fgyong on 2020/8/20.
///

class BaseLogin2Page extends StatefulWidget {
  BaseLogin2Page({Key key}) : super(key: key);

  @override
  _BaseLoginPageState createState() => _BaseLoginPageState();
}

class _BaseLoginPageState extends State<BaseLogin2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('loginBLoC Cubit'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocListener<LoginBloc, LoginState2>(
      listener: (context, state) {
        if (state.progress == Login2Progress.success) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('登陆成功')));
        } else if (state.progress == Login2Progress.error) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('登陆失败')));
        }
      },
      child: Center(
        child: Column(
          children: <Widget>[
            TextFiledNameRoute(),
            TextFiledPasswordRoute(),
            const SizedBox(
              height: 20,
            ),
            LoginButton()
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    Bloc.observer = BlocObserver();
    super.initState();
  }
}

class TextFiledPasswordRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState2>(
        builder: (BuildContext context, LoginState2 state) {
          return TextField(
            onChanged: (v) {
              context.bloc<LoginBloc>().add(LoginChagnePassword(password: v));
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'password',
                errorText:
                    state.showPasswordErrorText == true ? 'password不可用' : null),
          );
        },
        buildWhen: (previos, current) => previos.password != current.password);
  }
}

class TextFiledNameRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState2>(
        builder: (BuildContext context, LoginState2 state) {
          return TextField(
            onChanged: (v) {
              context.bloc<LoginBloc>().add(LoginChagneName(name: v));
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'name',
                errorText:
                    (state.showNameErrorText == true) ? 'name不可用' : null),
          );
        },
        buildWhen: (previos, current) => previos.name != current.name);
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState2>(
        builder: (BuildContext context, LoginState2 state) {
          switch (state.progress) {
            case Login2Progress.isRequesting:
              return const CircularProgressIndicator();
            default:
              return RaisedButton(
                child: const Text('login'),
                onPressed: state.btnVisiable
                    ? () {
                        context.bloc<LoginBloc>().add(LoginSubmitted());
                      }
                    : null,
              );
          }
        },
        buildWhen: (previos, current) =>
            previos.btnVisiable != current.btnVisiable ||
            previos.progress != current.progress);
  }
}
