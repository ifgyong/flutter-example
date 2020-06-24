import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertest01/counter.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second'),
      ),
      body: Hero(
        tag: 'null',
        child: Container(
          height: 100,
          color: Colors.lightBlueAccent,
          width: 200,
          child: FlatButton(
              onPressed: () {
                context.read<Counter>().changeValue(2);
//                Navigator.of(context)
//                    .push(MaterialPageRoute(builder: (ctx) => SecondPage()));
              },
              child: Text('2')),
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          Navigator.of(context).pop();
//        },
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
