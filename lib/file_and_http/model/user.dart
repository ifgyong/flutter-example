import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

///
/// Created by fgyong on 2020/7/28.
///
//@JsonSerializable()
//class UserModel {
//  String name;
//  String age;
//  UserModel({this.name, this.age});
//  factory UserModel.fromJson(Map<String, dynamic> js) =>
//      _$UserModelFromJson(js);
//}
//
//@JsonSerializable()
//class UserList {
//  List<UserModel> list;
//  UserList({this.list});
//  factory UserList.fromJson(Map<String, dynamic> ll) => _$UserListFromJson(ll);
//}

class UserModel {
  List<X> list;

  UserModel({this.list});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      list: json['list'] != null
          ? (json['list'] as List).map((i) => X.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class X {
  String name;

  X({this.name});

  factory X.fromJson(Map<String, dynamic> json) {
    return X(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
