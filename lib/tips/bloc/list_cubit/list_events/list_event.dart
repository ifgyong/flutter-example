import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/9/22.
///

import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostFetchedEvent extends PostEvent {}
