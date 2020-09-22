import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../base_login_cubit.dart';

///
/// Created by fgyong on 2020/8/19.
///

class BaseLoginPage extends StatefulWidget {
  BaseLoginPage({Key key}) : super(key: key);

  @override
  _BaseLoginPageState createState() => _BaseLoginPageState();
}

class _BaseLoginPageState extends State<BaseLoginPage> {
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
    return BlocListener<LoginCubit, LoginModel>(
      listener: (context, state) {
        if (state.state == LoginState.success) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('登陆成功')));
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
    return BlocBuilder<LoginCubit, LoginModel>(
        builder: (BuildContext context, LoginModel state) {
          return TextField(
            onChanged: (v) {
              context
                  .bloc<LoginCubit>()
                  .handleLoginEvents(LoginCubitChagnePassword(password: v));
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'password',
                errorText:
                    state.password?.isEmpty ?? false ? 'password不可用' : null),
          );
        },
        buildWhen: (previos, current) => previos.password != current.password);
  }
}

class TextFiledNameRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginModel>(
        builder: (BuildContext context, LoginModel state) {
          return TextField(
            onChanged: (v) {
              context
                  .bloc<LoginCubit>()
                  .handleLoginEvents(LoginCubitChagneName(name: v));
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'name',
                errorText: state.name?.isEmpty ?? false ? 'name不可用' : null),
          );
        },
        buildWhen: (previos, current) => previos.name != current.name);
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginModel>(
        builder: (BuildContext context, LoginModel state) {
          switch (state.state) {
            case LoginState.isLoading:
              return const CircularProgressIndicator();
            default:
              return RaisedButton(
                child: const Text('login'),
                onPressed: state.btnVisiable
                    ? () {
                        context
                            .bloc<LoginCubit>()
                            .handleLoginEvents(LoginCubitSubmitted());
                      }
                    : null,
              );
          }
        },
        buildWhen: (previos, current) =>
            previos.btnVisiable != current.btnVisiable ||
            (current.state != previos.state));
  }
}
