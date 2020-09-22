import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/9/22.
///

import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  const Post({this.id, this.title, this.body});

  @override
  List<Object> get props => [id, title, body];

  @override
  String toString() => 'Post { id: $id }';
}
