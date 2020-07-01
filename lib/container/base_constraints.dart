import 'package:flutter/material.dart';

class BaseConstraints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('尺寸限制类容器'),
      ),
      body: _widget(),
    );
  }

  Widget _redBox() {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 50, minWidth: 50),
      child: Container(
        color: Colors.red,
      ),
    );
  }

  Widget _widget() {
    return Container(
      color: Colors.black12,
      constraints: BoxConstraints(
          minHeight: 100, minWidth: 100, maxWidth: 200, maxHeight: 200),
      child: UnconstrainedBox(
        child: _redBox(),
      ),
    );
  }

  Widget _bd() {
    return Column(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
              minWidth: 50, minHeight: 50, maxHeight: 200, maxWidth: 100),
          color: Colors.red,
          child: Container(
            constraints: BoxConstraints(
                minWidth: 30, minHeight: 30, maxHeight: 50, maxWidth: 100),
//              width: 30,
//              height: 30,
            color: Colors.blue,
          ),
        ),
        _redBox(),
        SizedBox(
          height: 10,
        ),
//          SizedBox(width: 100.0, height: 100.0, child: _redBox()),
        Container(
          width: 200,
          height: 200,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 100,
              minWidth: 100,
            ),
//            color: Colors.black12,
            child: _redBox(),
          ),
        ),
      ],
    );
  }
}
