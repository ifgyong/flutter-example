import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BaseSwitchState();
  }
}

class BaseSwitchState extends State<BaseSwitch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('弹框'),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: _body(),
      ),
    );
  }

  bool _state1 = false, _state2 = true, _s3 = true, _s4 = false;
  Widget _body() {
    Widget w = Column(
      children: <Widget>[
        Container(
          height: 30,
          child: Text('CupertinoSwitchState:$_state1'),
        ),
        CupertinoSwitch(
          value: _state1,
          onChanged: (v) {
            setState(() {
              _state1 = v;
            });
          },
          trackColor: Colors.orange,
          activeColor: Colors.greenAccent,
        ),
        Container(
          height: 30,
          child: Text('SwitchStates:$_state2'),
        ),
        Switch(
          value: _state2,
          onChanged: (v) {
            setState(() {
              _state2 = v;
            });
          },
        ),
        Container(
          height: 30,
          child: Text('Checkbox'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Checkbox(
              value: _s3,
              onChanged: (v) {
                setState(() {
                  _s3 = v;
                });
              },
            ),
            Checkbox(
              value: _s4,
              onChanged: (v) {
                setState(() {
                  _s4 = v;
                });
              },
            )
          ],
        )
      ],
    );
    return w;
  }
}
