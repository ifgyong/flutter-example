import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/9/22.
///

class PostOBs extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print('$cubit $change');
    super.onChange(cubit, change);
  }
}
