part of 'login_bloc.dart';

///
/// Created by fgyong on 2020/8/19.
///
/// 事件变更状态[正在请求，报错，登陆成功，初始化]
enum Login2Progress { isRequesting, error, success, init }

/// 存储数据的model 在[bloc]中称作[state]
class LoginState2 extends Equatable {
  final String name;
  final String password;
  final Login2Progress progress;
  LoginState2({this.name, this.password, this.progress = Login2Progress.init});
  @override
  List<Object> get props => [name, password, btnVisiable, progress];
  LoginState2 copyWith(
      {String name, String pwd, Login2Progress login2progress}) {
    return LoginState2(
        name: name ?? this.name,
        password: pwd ?? this.password,
        progress: login2progress ?? this.progress);
  }

  /// 使用 [UserName] &&[UserPassword]来校验规则
  bool get btnVisiable => nameVisiable && passwordVisiable;
  bool get nameVisiable => UserName(name).visiable;
  bool get passwordVisiable => UserPassword(password).visiable;

  /// 是否展示名字错误信息

  bool get showNameErrorText {
    if (name?.isEmpty ?? true) return false;
    return nameVisiable == false;
  }

  /// 是否展示密码错误信息
  bool get showPasswordErrorText {
    if (password?.isEmpty ?? true) return false;
    return passwordVisiable == false;
  }

  @override
  String toString() {
    return '$props';
  }
}
