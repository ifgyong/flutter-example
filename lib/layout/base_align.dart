import 'package:flutter/material.dart';

class BaseAlign extends StatefulWidget {
  BaseAlign({Key key}) : super(key: key);

  @override
  _BaseAlignState createState() => _BaseAlignState();
}

class _BaseAlignState extends State<BaseAlign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('相对位置'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 200,
            height: 200,
            color: Colors.blue[50],
            child: Align(
                child: FlutterLogo(
              size: 30,
            )),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text('center2'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              widthFactor: 1,
              heightFactor: 1,
              child: Text('center2'),
            ),
          )
        ],
      ),
    );
  }
}
