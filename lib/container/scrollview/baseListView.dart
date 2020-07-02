import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/2.
///

class BaseListView extends StatefulWidget {
  @override
  _BaseListViewState createState() => _BaseListViewState();
}

class _BaseListViewState extends State<BaseListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView '),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    List<Widget> list = new List();
    for (int i = 0; i < 3; i++) {
      list.add(Card(
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Text('$i'),
        ),
      ));
    }
    return ListView(
      itemExtent: 80,
      shrinkWrap: true,
      children: list,
    );
  }
}
