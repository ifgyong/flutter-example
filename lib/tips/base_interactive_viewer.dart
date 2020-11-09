import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/11/9.
///

class BaseInteractiveViewer extends StatefulWidget {
  BaseInteractiveViewer({Key key}) : super(key: key);

  @override
  _BaseInteractiveViewerState createState() => _BaseInteractiveViewerState();

  static String get routeName => "interactiveViewer";
}

class _BaseInteractiveViewerState extends State<BaseInteractiveViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('interactiveViewer'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: InteractiveViewer(
        boundaryMargin: EdgeInsets.all(20.0),
        minScale: 0.1,
        maxScale: 1.6,
        child: Container(
          child: Image.asset('img/2.png'),
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: [Colors.orange, Colors.red],
          //     stops: [0.0, 1.0],
          //   ),
          // ),
        ),
      ),
    );
  }
}
