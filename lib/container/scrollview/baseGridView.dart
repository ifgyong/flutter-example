import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/container/scrollview/baseListView.dart';

///
/// Created by fgyong on 2020/7/3.
///

class BaseGridView extends StatefulWidget {
  @override
  _BaseGridViewState createState() => _BaseGridViewState();
}

class _BaseGridViewState extends State<BaseGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
//    List<Widget> list = new List();
//    for (int i = 0; i < 10; i++) {
//      list.add(Container(
//          height: 80,
//          color: Colors.primaries[i % Colors.primaries.length],
//          alignment: Alignment.center,
//          child: TestContainer(
//            title: DateTime.now().toString(),
//          )));
//    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//          crossAxisCount: 4,
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 4 + 10.0,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2),
      itemBuilder: _buildCell,
      itemCount: _list.length,
      semanticChildCount: 13,
    );
  }

  List<Widget> _list;

  Widget _buildCell(BuildContext context, int index) {
    if (index < _list.length - 1) {
      return Container(
          height: 80, alignment: Alignment.center, child: _list[index]);
    } else if (_list.length < 100) {
      _getData();
      return Container(
        alignment: Alignment.center,
        child: RefreshProgressIndicator(),
      );
    } else {
      return Container(
          height: 80, alignment: Alignment.center, child: _list[index]);
    }
  }

  @override
  void initState() {
    _list = new List();
    _getData();
    super.initState();
  }

  void _getData() async {
    await Future.delayed(Duration(milliseconds: 1500));
    _list.addAll([
      Icon(Icons.directions),
      Icon(Icons.title),
      Icon(Icons.refresh),
      Icon(Icons.dehaze),
      Icon(Icons.ac_unit),
    ]);
    setState(() {});
  }
}
