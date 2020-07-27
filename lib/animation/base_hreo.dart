import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/21.
///

class BaseHreo extends StatefulWidget {
  final String heroKey;
  BaseHreo({Key key, this.heroKey}) : super(key: key);

  @override
  _BaseHreoState createState() => _BaseHreoState();
}

class _BaseHreoState extends State<BaseHreo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero 动画'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[
          Hero(
            child: Container(
              width: 100,
              height: 100,
              child: Image.asset('img/2.png'),
            ),
            tag: 'key',
          ),
          OutlineButton(
            child: Text('push'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => _BaseHreo(
                            heroKey: 'key',
                          )));
            },
          )
        ],
      ),
    );
  }
}

class _BaseHreo extends StatelessWidget {
  final String heroKey;
  _BaseHreo({Key key, this.heroKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hero 动画'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Hero(
        child: ClipRRect(
          child: Container(
            width: 300,
            height: 300,
            child: Image.asset(
              'img/2.png',
              fit: BoxFit.fill,
            ),
          ),
          borderRadius: BorderRadius.all(Radius.circular(150)),
        ),
        tag: heroKey ?? 'key',
      ),
    );
  }
}
