import 'package:fluttertest01/generated/json/base/json_convert_content.dart';
import 'package:fluttertest01/generated/json/base/json_filed.dart';

class UserEntity with JsonConvert<UserEntity> {
  @JSONField(name: "list")
  List<UserList> xList;
}

class UserList with JsonConvert<UserList> {
  String name;
}
