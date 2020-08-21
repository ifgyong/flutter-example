import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/8/21.
///

class BaseKeyPage extends StatefulWidget {
  BaseKeyPage({Key key}) : super(key: key);

  @override
  _BaseKeyPageState createState() => _BaseKeyPageState();
  static String get routeName => '/BaseKeyPage';
}

class _BaseKeyPageState extends State<BaseKeyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('key'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            count += 1;
          });
        },
      ),
    );
  }

  Student _student;
  int count = 0;
  Widget _body() {
    _student = Student('老王');
    return Column(
      children: <Widget>[
        Text('ValueKey 包含的值相等就判定为相等'),
        TextField(
          key: ValueKey(Student('老王1')),
        ),
        TextField(
          key: ValueKey(Student('老王2')),
        ),
        Text(
          'objetKey 必须引用相同地址才判断为相等\n'
          '每次new 就生成不同地址的对象',
          textAlign: TextAlign.center,
        ),
        TextField(
          key: ObjectKey(Student('老王')),
        ),
        TextField(
          key: ObjectKey(Student('老王')),
        ),
        TextField(
          key: UniqueKey(),
        ),
        TextField(
          key: UniqueKey(),
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 1000),
          child: Container(
            key: UniqueKey(),
            height: 100,
            width: 100,
            color: Colors.primaries[count % Colors.primaries.length],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _Container(_key),
        OutlineButton(
          child: Text('global key 刷新'),
          onPressed: () {
            _key.currentState.setState(() {});
          },
        )
      ],
    );
  }

  GlobalKey _key = GlobalKey();
}

class _Container extends StatefulWidget {
  _Container(Key key) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return __ContainerState();
  }
}

class __ContainerState extends State<_Container> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    count += 1;
    return Container(
      height: 100,
      width: 100,
      color: Colors.primaries[count % Colors.primaries.length],
    );
  }
}

class Student {
  final String name;

  Student(this.name);

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Student &&
          runtimeType == other.runtimeType &&
          name == other.name;
}
