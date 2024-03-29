import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/tips/provider/base_provider_pan_zan.dart';
import 'package:fluttertest01/tips/provider/base_stream_pge.dart';
import 'package:provider/provider.dart';

///
/// Created by fgyong on 2020/7/30.
///
class BaseProviderRouteProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseProviderRouteList();
  }

  static String get routeName => '/BaseProviderRouteProvider';
}

class BaseProviderRouteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BaseProviderRouteProvider'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Builder(builder: (context) {
      return CustomScrollView(
        slivers: <Widget>[
          item('数字加减', () {
            Navigator.of(context).push(BaseProviderRoute.pageRoute);
          }),
          item('定时器', () {
            Navigator.push(context, BaseProviderStreamRoute.pageRoute);
          }),
          item('数字加减监听跳转新页面', () {
            Navigator.push(context, BasePinZanProviderRoute.route);
          })
        ],
      );
    });
  }

  Widget item(String name, GestureTapCallback callback) {
    return SliverToBoxAdapter(
      child: OutlineButton(
        child: Text('$name'),
        onPressed: callback,
      ),
    );
  }
}

class BaseProviderRoute extends StatelessWidget {
  BaseProviderRoute({Key key}) : super(key: key);

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (_) => BaseProviderRoute());
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderModel>(
          create: (_) => ProviderModel(),
          lazy: false,
        ),
        ChangeNotifierProvider<ProviderModel2>(
          create: (_) => ProviderModel2(),
          lazy: false,
        ),
      ],
      child: BaseProvider(),
    );
    return ChangeNotifierProvider(
      create: (_) => ProviderModel(),
      lazy: true,
      builder: (ctx, child) {
        return BaseProvider();
      },
    );
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

  String _string = '';

  @override
  Widget build(BuildContext context) {
    print('page 1');
    _string += 'page ';
    ProviderModel _model =
        context.select<ProviderModel, ProviderModel>((value) => value);
    ProviderModel2 _model2 =
        context.select<ProviderModel2, ProviderModel2>((value) => value);

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider 全局与局部刷新'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
                '${_model._count} ${_model._count2} ${_model._count3} m2:${_model2.value}'),
            Text('全局刷新<Consumer>'),
            Consumer<ProviderModel>(
              builder:
                  (BuildContext context, ProviderModel value, Widget child) {
                print('Consumer 0 刷新');
                _string += 'c0 ';
                return _Row(
                  value: value._count.toString(),
                  callback: () {
                    context.read<ProviderModel>().plus();
                  },
                );
              },
              child: _Row(
                value: '0',
                callback: () {
                  context.read<ProviderModel>().plus();
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text('局部刷新<Selector>'),
            Selector<ProviderModel, int>(
              builder: (ctx, value, child) {
                print('Selector 1 刷新');
                _string += 's1 ';
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Selector<Model,int>次数：' + value.toString()),
                    OutlineButton(
                      onPressed: () {
                        context.read<ProviderModel>().plus2();
                      },
                      child: Icon(Icons.add),
                    )
                  ],
                );
              },
              selector: (ctx, model) => model._count2,
              shouldRebuild: (m1, m2) {
                print('s1：$m1 $m2 ${m1 != m2 ? '不相等，本次刷新' : '数据相等，本次不刷新'}');
                return m1 != m2;
              },
            ),
            SizedBox(
              height: 40,
            ),
            Text('局部刷新<Selector>'),
            Selector<ProviderModel, int>(
              selector: (context, model) => model._count3,
              shouldRebuild: (m1, m2) {
                print('s2：$m1 $m2 ${m1 != m2 ? '不相等，本次刷新' : '数据相等，本次不刷新'}');
                return m1 != m2;
              },
              builder: (ctx, value, child) {
                print('selector 2 刷新');
                _string += 's2 ';
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Selector<Model,int>次数：' + value.toString()),
                    OutlineButton(
                      onPressed: () {
                        ctx.read<ProviderModel>().plus3();
                      },
                      child: Icon(Icons.add),
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
            Text('刷新次数和顺序：↓'),
            Text(_string),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  child: Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      _string += '\n';
                    });
                  },
                ),
                OutlineButton(
                  child: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _string = '';
                    });
                  },
                ),
              ],
            ),
            Text('model2 局部刷新'),
            Selector<ProviderModel2, int>(
              selector: (context, model) => model.value,
              builder: (ctx, value, child) {
                print('model2 s1 刷新');
                _string += 'm2s1 ';
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Selector<Model2,int>次数：' + value.toString()),
                    OutlineButton(
                      onPressed: () {
                        ctx.read<ProviderModel2>().add(2);
                      },
                      child: Icon(Icons.add),
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
//            StreamProvider(create: null)
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
//class FutureModel extends ChangeNotifier {
//  static Future<FutureModel> doHttp(BuildContext context) async {
//    await Future.delayed(Duration(seconds: 2));
//
//    return FutureModel(
//      value: 2,
//    );
//  }
//
//  int value = 0;
//  FutureModel({this.value}) {
//    notifyListeners();
//  }
//}

class ProviderModel2 extends ChangeNotifier {
  int _value = 0;
  ProviderModel2();
  set setValue(int v) {
    _value = v;
    notifyListeners();
  }

  get value => _value;
  void add(int v) {
    _value += v;
    notifyListeners();
  }
}

class ProviderModel extends ChangeNotifier {
  ProviderModel({int value, int valu2, int value3}) {
    _count = value ?? 0;
    _count2 = valu2 ?? 0;
    _count3 = value3 ?? 0;
  }

  int _count = 0, _count2 = 0, _count3 = 0;
  String _log = '';
  set count(int count) {
    _count = count;
    notifyListeners();
  }

  get count => _count;

  /// 查看刷新日志
  get log => _log;
  set logStr(String str) {
    _log = str;
    notifyListeners();
  }

  void addLog(String str) {
    _log += str;
    notifyListeners();
  }

  void plus() {
    this.count = _count + 1;
    notifyListeners();
  }

  void plus2() {
    this._count2 += 1;
    notifyListeners();
  }

  void plus3() {
    _count3 += 1;
    notifyListeners();
  }
}

class _Row extends StatelessWidget {
  final String value;
  final GestureTapCallback callback;
  _Row({this.value, this.callback});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Consumer(Model)次数：$value'),
        OutlineButton(
          onPressed: this.callback,
          child: Icon(Icons.add),
        )
      ],
    );
  }
}
