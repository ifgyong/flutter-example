import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/2.
///
class BaseSingleChildScrollView extends StatefulWidget {
  @override
  _BaseSingleChildScrollViewState createState() =>
      _BaseSingleChildScrollViewState();
}

class _BaseSingleChildScrollViewState extends State<BaseSingleChildScrollView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SingleChildScrollView'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    List<Widget> list = new List();
    for (int i = 0; i < 30; i++) {
      list.add(Card(
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Text('$i'),
        ),
      ));
    }
    return CupertinoScrollbar(
      child: SingleChildScrollView(
        reverse: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: list,
        ),
      ),
    );
  }
}
