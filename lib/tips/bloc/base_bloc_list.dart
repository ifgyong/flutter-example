import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// Created by fgyong on 2020/8/19.
///

class BaseBlocListRoute extends StatefulWidget {
  BaseBlocListRoute({Key key}) : super(key: key);

  @override
  _BaseBlocListRouteState createState() => _BaseBlocListRouteState();
}

class _BaseBlocListRouteState extends State<BaseBlocListRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下拉列表BLoC'),
      ),
      body: _body(),
    );
  }

  Widget _body() {}
}

class ListCubit extends Cubit<Model> {
  ListCubit(Model state) : super(state);

  Future<List<_Item>> request(int count) async {
    await Future.delayed(Duration(seconds: 1));
    List<_Item> list = List();
    for (int i = 0; i < count; i++) {
      list.add(_Item(title: 'title${list.length}', subTitle: 'subtitle'));
    }
    return list;
  }
}

enum ListState {
  success,
  faild,
  isLoading,
}

class Model extends Equatable {
  Model({this.list}) {
    this.list ??= List();
  }
  List<_Item> list;
  ListState state;

  Model copyWith(List<_Item> list) {
    return Model(list: list);
  }

  @override
  List<Object> get props => [list];
}

// ignore: unused_element
class _Item extends Equatable {
  String title, subTitle;
  _Item({this.title, this.subTitle});
  @override
  List<Object> get props => [title, subTitle];
}
