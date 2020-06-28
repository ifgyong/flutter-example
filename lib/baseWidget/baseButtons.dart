import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('按钮'),
      ),
      body: Center(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.only(
        top: 50,
      ),
      child: Column(
        children: <Widget>[
          Text('FlatButton'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('nomal'),
                onPressed: () {
                  print('FlatButton');
                },
              ),
              FlatButton(
                child: Text('active'),
                focusNode: new FocusNode()..requestFocus(),
                onPressed: () {
                  print('FlatButton');
                },
              ),
            ],
          ),
          Text('RaisedButton'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('normal'),
                onPressed: () {
                  print('RaisedButton');
                },
              ),
              SizedBox(
                width: 30,
              ),
              RaisedButton(
                child: Text('active'),
                onPressed: () {
                  print('RaisedButton');
                },
              )
            ],
          ),
          Text('IconButton'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  print('IconButton');
                },
              ),
              SizedBox(
                width: 30,
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  print('IconButton');
                },
              ),
            ],
          ),
//          Text('FloatingActionButton'),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              FloatingActionButton(
//                child: Icon(Icons.add),
//                onPressed: () {},
//              ),
//              SizedBox(
//                width: 30,
//              ),
//              FloatingActionButton(
//                child: Icon(Icons.add),
//                onPressed: () {},
//              ),
//            ],
//          ),
          Container(
            child: Text('BackButton  CloseButton'),
            margin: EdgeInsets.only(top: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BackButton(
                onPressed: () {},
              ),
              SizedBox(
                width: 30,
              ),
              CloseButton(
                onPressed: () {},
              ),
            ],
          ),
          Container(
            child: Text('OutlineButton'),
            margin: EdgeInsets.only(top: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                child: Text('OutlineButton'),
                onPressed: () {},
              ),
              SizedBox(
                width: 10,
              ),
              OutlineButton.icon(
                icon: Icon(Icons.add),
                label: Text('label'),
                onPressed: () {},
              ),
              SizedBox(
                width: 10,
              ),
              OutlineButton.icon(
                icon: Icon(Icons.add),
                label: Text('active'),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          _diyIconButton(),
        ],
      ),
    );
  }

  Widget _diyIconButton() {
    return OutlineButton.icon(
        onPressed: () {},
        icon: Icon(Icons.add),
        label: Text('diy style'),
        color: Colors.black12,
        textColor: Colors.blue,
        disabledBorderColor: Colors.black,
        highlightedBorderColor: Colors.greenAccent,
        splashColor: Colors.red);
  }
}
