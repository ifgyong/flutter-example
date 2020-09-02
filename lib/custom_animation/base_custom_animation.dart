import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/8/31.
///

class BaseCustomListAnimationPage extends StatelessWidget {
  static String get routeName => '/BaseCustomListAnimationPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return NestedScrollView(
        headerSliverBuilder: _listView,
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('$index'),
            );
          },
          itemCount: 10,
        ));
  }

  List<Widget> _listView(BuildContext context, bool innerBoxIsScrolled) {
    return [
      SliverAppBar(
        title: Text('123'),
        floating: false,
      )
    ];
  }
}
