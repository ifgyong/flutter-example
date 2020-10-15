import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/tips/hive/hive_person.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiver/mirrors.dart';
import 'dart:core';

///
/// Created by fgyong on 2020/10/10.
///
class BaseHive extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BaseHive();
  }

  static String get routeName => '/BaseHive';
}

class _BaseHive extends State<BaseHive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hive'),
      ),
      body: Center(
        child: Column(
          children: [
            OutlineButton(
              child: Text('add'),
              onPressed: add,
            ),
            OutlineButton(
              child: Text('查询'),
              onPressed: _query,
            ),
            OutlineButton(
              child: Text('清空'),
              onPressed: _clear,
            ),
          ],
        ),
      ),
    );
  }

  void _clear() async {
    // if (Hive.isBoxOpen('testBox') == false) {
    //   await Hive.openBox('testBox', path: (await getTemporaryDirectory()).path);
    // }
    // var box = await Hive.box('testBox');
    // await box.deleteFromDisk();
    // Symbol lib = new Symbol('Person_lib');
    // Symbol className = Symbol('Person');
  }

  // void testSymbol(Symbol lib, Symbol className) {}

  void add() async {
    if (Hive.isAdapterRegistered(PersonAdapter().typeId) == false) {
      Hive.registerAdapter(PersonAdapter());
    }
    if (Hive.isBoxOpen('testBox') == false) {
      await Hive.openBox('testBox', path: (await getTemporaryDirectory()).path);
    }
    var box = await Hive.box('testBox');

    box.put('name', 'David');
    box.add(Person('laowng'));

    box.add(Person('老李'));

    print('Name: ${box.get('name')}');
    await box.close();
    // printLog();
  }

  void _query() async {
    if (Hive.isBoxOpen('testBox') == false) {
      await Hive.close();
      await Hive.openBox<Person>('testBox',
          path: (await getTemporaryDirectory()).path);
    }

    var box = Hive.box<Person>('testBox');

    box.values.forEach((element) {
      print('${element.toString()}');
    });
  }

  void printLog() async {
    var box = await Hive.openBox('testBox',
        path: (await getTemporaryDirectory()).path);
    print('${box.path}');
    box.values.forEach((element) {
      print('${element.toString()}');
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
