import 'package:fluttertest01/file_and_http/model/user_entity.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
  if (json['list'] != null) {
    data.xList = new List<UserList>();
    (json['list'] as List).forEach((v) {
      data.xList.add(new UserList().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.xList != null) {
    data['list'] = entity.xList.map((v) => v.toJson()).toList();
  }
  return data;
}

userListFromJson(UserList data, Map<String, dynamic> json) {
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  return data;
}

Map<String, dynamic> userListToJson(UserList entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['name'] = entity.name;
  return data;
}
