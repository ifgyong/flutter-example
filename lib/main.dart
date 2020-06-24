import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/counter.dart';
import 'package:fluttertest01/page3.dart';
import 'package:fluttertest01/secondPage.dart';
import 'package:fluttertest01/test.dart';
import 'package:provider/provider.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].
void main() {
  runTest();
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => CounterValue()),
//        Provider(create: (_) => CounterValue()),
      ],
      child: MyApp(),
    ),
  );
}

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
//class Counter with ChangeNotifier {
//  int _count = 0;
//  int get count => _count;
//
//  void increment() {
//    _count++;
//    notifyListeners();
//  }
//
//  /// Makes `Counter` readable inside the devtools by listing all of its properties
////  @override
////  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
////    super.debugFillProperties(properties);
////    properties.add(IntProperty('count', count));
////  }
//}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return myAppState();
  }
}

// ignore: camel_case_types
class myAppState extends State<MyApp> {
  var _index = 0;
  List<Widget> list = [MyHomePage(), SecondPage(), Page3()];
  @override
  Widget build(BuildContext context) {
    Scaffold s = Scaffold(
      appBar: AppBar(
        title: Text('value:' + context.watch<CounterValue>().value.toString()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.build), title: Text('add')),
          BottomNavigationBarItem(icon: Icon(Icons.build), title: Text('add')),
          BottomNavigationBarItem(icon: Icon(Icons.build), title: Text('add'))
        ],
        onTap: (index) {
//          setState(() {
//            _index = index;
//          });
          setState(() {
            context.read<Counter>().index = index;
          });
        },
      ),
      body: list[context.watch<Counter>().index],
    );
    return MaterialApp(
      home: s,
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  var _count = 0;
//  GlobalKey globalKey = GlobalKey<MyHomePage>();
  @override
  Widget build(BuildContext context) {
    Scaffold s = Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('value:' + context.watch<CounterValue>().value.toString()),
            Text('value2:${_count.toString()}'),
            Divider(
              height: 1,
              color: Colors.black26,
              indent: 1,
              endIndent: 1,
              thickness: 1,
            ),
            FlatButton(
                onPressed: () {
                  context.read<Counter>().changeValue(0);
                },
                child: Text('0')),
            FlatButton(
                onPressed: () {
                  context.read<Counter>().changeValue(1);
                },
                child: Text('1')),
            FlatButton(
                onPressed: () {
//                  context.read<Counter>().changeValue(2);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => SecondPage()));
                },
                child: Text('2')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _count += 1;
          context.read<Counter>().add();
//          context.read<CounterValue>().add();
//          NotificationValue(name: '我是测试').dispatch();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
    return s;
  }
}
