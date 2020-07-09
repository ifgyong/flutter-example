import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/9.
///

class BaseGesuredetetor extends StatefulWidget {
  @override
  _BaseGesuredetetorState createState() => _BaseGesuredetetorState();
}

class _BaseGesuredetetorState extends State<BaseGesuredetetor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手势识别'),
      ),
      body: _body3(),
    );
  }

  String _string;
  double _left = 0, _top = 0;
  Offset _offset = Offset(0, 0);
  double _width = 300, _height = 300;
  Widget _body() {
    return Stack(
      children: <Widget>[
        GestureDetector(
          child: Container(
            width: _width,
            height: _height,
            margin: EdgeInsets.only(
                left: _left > 0 ? _left : 0, top: _top < 0 ? 0 : _top),
            child: Text(_string == null ? '点击我识别手势' : _string),
            color: Colors.orange,
          ),
          onScaleUpdate: (ScaleUpdateDetails detail) {
            setState(() {
              _width = 200 * detail.scale.clamp(0.5, 2);
              _height = _width;
            });
          },
        ),
      ],
    );
  }

  bool _selected = false;
  Widget _body2() {
    return Center(
      child: Text.rich(
        TextSpan(text: '你好,', children: [
          TextSpan(
              text: 'Flutter',
              recognizer: _gestureRecognizer(),
              style: TextStyle(
                  color: _selected ? Colors.blue : Colors.orange,
                  fontSize: _selected ? 30 : 20))
        ]),
      ),
    );
  }

  GestureRecognizer _gestureRecognizer() {
    return TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          _selected = !_selected;
        });
      };
  }

  String _moveDetail = '';
  Widget _body3() {
    return Stack(
      children: <Widget>[
        GestureDetector(
          child: Container(
            width: _width,
            height: _height,
            margin: EdgeInsets.only(
                left: _left > 0 ? _left : 0, top: _top < 0 ? 0 : _top),
            child: Text(
                (_string == null ? '点击我识别手势' : _string) + _moveDetail ?? ''),
            color: Colors.orange,
          ),
          onTap: () {
            setState(() {
              _string += '点击手势';
            });
          },
          onTapUp: (TapUpDetails detail) {
            setState(() {
              _string += 'up:' + detail.toString();
            });
          },
          onHorizontalDragUpdate: (DragUpdateDetails detail) {
            setState(() {
              _moveDetail = detail.toString();
            });
          },
        ),
      ],
    );
  }
}
