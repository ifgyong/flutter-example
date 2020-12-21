import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class GetStoreRoute extends StatefulWidget {
  GetStoreRoute({Key key}) : super(key: key);

  @override
  _GetStoreState createState() => _GetStoreState();
}

class _GetStoreState extends State<GetStoreRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('存储'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: [
          OutlineButton(
            child: Text('添加'),
            onPressed: _add,
          ),
        ],
      ),
    );
  }

  void _add() async {
    box.write('key', 'value');
  }

  final box = GetStorage();

  @override
  void initState() {
    GetStorage.init();

    box.listenKey('key', (v) {
      print('key:$v');
    });
    super.initState();
  }
}
