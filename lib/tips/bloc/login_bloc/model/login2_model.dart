import 'package:equatable/equatable.dart';

///
/// Created by fgyong on 2020/8/19.
///
abstract class UserAction {
  final String value;
  const UserAction(this.value);
  bool get visiable;
}

class UserName extends UserAction {
  UserName(String value) : super(value);

  /// 这里可以写校验规则
  @override
  bool get visiable {
    /// 名字长度大于3 符合要求

    return (value?.isNotEmpty ?? false) ? value.length > 3 : false;
  }
}

class UserPassword extends UserAction {
  UserPassword(String value) : super(value);

  /// 这里可以写校验规则
  @override
  bool get visiable {
    /// 密码长度大于3 符合要求

    return (value?.isNotEmpty ?? false) ? value.length > 1 : false;
  }
}
