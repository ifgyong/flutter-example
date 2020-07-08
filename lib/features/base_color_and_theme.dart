import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/8.
///

class BaseColorAndTheme extends StatefulWidget {
  @override
  _BaseColorAndThemeState createState() => _BaseColorAndThemeState();
}

class _BaseColorAndThemeState extends State<BaseColorAndTheme> {
  Color _color;
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Theme(
      child: Scaffold(
        appBar: AppBar(
          title: Text('颜色和主题'),
        ),
        body: _body(),
      ),
      data: ThemeData(
          primarySwatch: _color,
          iconTheme: IconThemeData(color: _color),
          textTheme: TextTheme(button: TextStyle(backgroundColor: _color))),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[
          FlatButton(
            child: Text('切换颜色'),
            color: Theme.of(context).buttonColor,
            onPressed: () {
              setState(() {
//                _iconColor = Colors.orange;
                _color = _color == Colors.orange ? Colors.green : Colors.orange;
              });
//              Navigator.of(context)
//                  .push(MaterialPageRoute(builder: (ctx) => _BaseRoutePage()));
            },
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.add,
                size: 50,
              ),
              Text('颜色跟随主题')
            ],
          ),
          Theme(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.add,
                  size: 50,
                ),
                Text('颜色固定')
              ],
            ),
            data: ThemeData(
              iconTheme: IconThemeData(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _color = Colors.teal;

    super.initState();
  }
}
