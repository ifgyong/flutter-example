import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TapBox extends StatefulWidget {
  TapBoxState createState() => TapBoxState();
}

class TapBoxState extends State<TapBox> {
  bool _selected = false, _selected2 = false, _selected3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('管理状态'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
              child: Text('自己管理状态'),
            ),
            Container(
              color: _selected ? Colors.red : Colors.black12,
              child: TapBox1(),
            ),
            SizedBox(
              height: 30,
              child: Text('父组件管理状态'),
            ),
            Container(
              color: _selected2 ? Colors.red : Colors.black12,
              child: TapBox2(
                onchange: (v) {
                  setState(() {
                    _selected2 = v;
                  });
                },
                selected: _selected2,
              ),
            ),
            SizedBox(
              height: 30,
              child: Text('混合管理状态'),
            ),
            Container(
              color: _selected3 ? Colors.red : Colors.black12,
              child: TapBox3(
                onchange: (v) {
                  setState(() {
                    _selected3 = v;
                  });
                },
                selected: _selected3,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _tap() {
    setState(() {
      _selected = !_selected;
    });
  }
}

class TapBox1 extends StatefulWidget {
  TapBox1({Key key}) : super(key: key);
  TapBoxState1 createState() => TapBoxState1();
}

typedef onChange = Function(bool);

class TapBoxState1 extends State<TapBox1> {
  bool _selected;
  @override
  void initState() {
    _selected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _selected == true ? Colors.red : Colors.black12,
      child: FlatButton(
        child: Text(_selected == true ? 'Active' : 'Inactive'),
        onPressed: _tap,
      ),
    );
  }

  void _tap() {
    setState(() {
      _selected = !_selected;
    });
  }
}

class TapBox2 extends StatefulWidget {
  final bool selected;
  final onChange onchange;
  TapBox2({Key key, this.selected, this.onchange}) : super(key: key);
  TapBoxState2 createState() => TapBoxState2();
}

class TapBoxState2 extends State<TapBox2> {
  bool _selected;
  @override
  void initState() {
    _selected = widget.selected == true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.selected == true ? Colors.red : Colors.black12,
      child: FlatButton(
        child: Text(widget.selected == true ? 'Active' : 'Inactive'),
        onPressed: _tap,
      ),
    );
  }

  void _tap() {
    if (widget.onchange != null) {
      _selected = !_selected;
      widget.onchange(_selected);
    }
  }
}

class TapBox3 extends StatefulWidget {
  final bool selected;
  final onChange onchange;
  TapBox3({Key key, this.selected, this.onchange}) : super(key: key);
  TapBoxState3 createState() => TapBoxState3();
}

class TapBoxState3 extends State<TapBox3> {
  bool _touching = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Container(
          height: 50,
          width: 120,
          alignment: Alignment.center,
          child: Text(widget.selected == true ? 'Active' : 'Inactive'),
          decoration: new BoxDecoration(
              color: widget.selected == true ? Colors.red : Colors.black12,
              border: _touching
                  ? Border.all(
                      color:
                          widget.selected == false ? Colors.red : Colors.blue,
                      width: 4)
                  : null),
        ),
        onTap: _tap,
        onTapDown: (TapDownDetails details) {
          _touchStart();
        },
        onTapUp: (detail) {
          _touchend();
        },
      ),
    );
  }

  void _tap() {
    if (widget.onchange != null) {
      widget.onchange(!widget.selected);
    }
  }

  void _touchStart() {
    setState(() {
      _touching = true;
    });
  }

  void _touchend() {
    setState(() {
      _touching = false;
    });
  }
}
