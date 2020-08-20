import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// Created by fgyong on 2020/8/19.
///

class DefaultBlocObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    if (kDebugMode)
      print(
          '${cubit.toString()} new:${change.toString()} old:${cubit.state.toString()}');
    super.onChange(cubit, change);
  }
}
