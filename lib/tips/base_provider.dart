import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///
/// Created by fgyong on 2020/7/30.
///

class BaseProviderRoute extends StatelessWidget {
  BaseProviderRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProvider();
  }
}

class BaseProvider extends StatefulWidget {
  BaseProvider({Key key}) : super(key: key);

  @override
  _BaseProviderState createState() {
    return _BaseProviderState();
  }
}

class _BaseProviderState extends State<BaseProvider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('标题'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ChangeNotifierProvider<ProviderModel>(
              create: (_) => ProviderModel(10),
              lazy: true,
              builder: (ctx, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('次数：' + ctx.watch<ProviderModel>().count.toString()),
                    OutlineButton(
                      onPressed: () {
                        ctx.read<ProviderModel>().plus();
                      },
                      child: Icon(Icons.add),
                    )
                  ],
                );
              },
            ),
            ChangeNotifierProvider<ProviderModel2>(
              create: (_) => ProviderModel2(2),
              child: _PageSecondRoute(),
            ),
            ChangeNotifierProvider<ProviderModel3>(
              create: (_) => ProviderModel3(10),
              child: _PageSecondRoute3(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ProviderModel>().plus(
              add: context.read<ProviderModel3>().count +
                  context.read<ProviderModel2>().count);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _PageSecondRoute extends StatelessWidget {
  _PageSecondRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('次数：' +
            context.select<ProviderModel2, String>((value) {
              return value.count.toString();
            })),
        OutlineButton(
          onPressed: () {
            context.read<ProviderModel2>().plus();
          },
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}

class _PageSecondRoute3 extends StatelessWidget {
  _PageSecondRoute3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('次数：' +
            context.select<ProviderModel3, String>((value) {
              return value.count.toString();
            })),
        OutlineButton(
          onPressed: () {
            context.read<ProviderModel3>().plus();
          },
          child: Icon(Icons.add),
        )
      ],
    );
  }
}

class ProviderModel3 extends ChangeNotifier {
  ProviderModel3(int idx) {
    _count = idx;
  }
  int _count;
  set count(int count) {
    _count = count;
    notifyListeners();
  }

  get count => _count;

  void plus() {
    this.count = _count + 1;
    notifyListeners();
  }
}

class ProviderModel2 extends ChangeNotifier {
  ProviderModel2(int idx) {
    _count = idx;
  }
  int _count;
  set count(int count) {
    _count = count;
    notifyListeners();
  }

  get count => _count;

  void plus({int add = 0}) {
    this.count = _count + add;
    notifyListeners();
  }
}

class ProviderModel extends ChangeNotifier {
  ProviderModel(int idx) {
    _count = idx;
  }
  int _count;
  set count(int count) {
    _count = count;
    notifyListeners();
  }

  get count => _count;

  void plus({int add = 0}) {
    this.count = _count + add;
  }
}
