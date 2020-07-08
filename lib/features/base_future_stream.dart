import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/8.
///

class BaseFutureStream extends StatefulWidget {
  @override
  _BaseFutureStreamState createState() => _BaseFutureStreamState();
}

class _BaseFutureStreamState extends State<BaseFutureStream> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('异步更新 Future Stream'),
      ),
      body: _bd(),
    );
  }

  Widget _bd2() {
    return FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('error:${snapshot.error}'),
            );
          } else {
            return Center(
              child: Text('data:${snapshot.data}'),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<String> _getData() async {
    return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  }

  Widget _bd() {
    return Center(
      child: StreamBuilder<int>(
        stream: _counter(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('error:${snapshot.error}'),
              );
            } else {
              return Center(
                child: Text('data:${snapshot.data}'),
              );
            }
          } else {
            return Center(
              child: Text(
                  'state:${snapshot.connectionState},count:${snapshot.data}'),
            );
          }
        },
      ),
    );
  }

  Stream<int> _counter() {
    return Stream.periodic(Duration(milliseconds: 500), (i) {
      return i;
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
