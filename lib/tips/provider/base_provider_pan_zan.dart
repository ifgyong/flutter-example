import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///
/// Created by fgyong on 2020/8/21.
///

class BasePinZanProviderRoute extends StatelessWidget {
  static String get routeName => '/BasePinZanProviderRoute';
  static MaterialPageRoute get route =>
      MaterialPageRoute(builder: (_) => BasePinZanProviderRoute());
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_RedNumberModel>(
      create: (_) => _RedNumberModel(count: 0, number: 0),
      builder: (context, child) {
        return BasePinZanProvider();
      },
      child: BasePinZanProvider(),
    );
  }
}

class BasePinZanProvider extends StatefulWidget {
  BasePinZanProvider({Key key}) : super(key: key);

  @override
  _BasePinZanProviderState createState() => _BasePinZanProviderState();
}

class _BasePinZanProviderState extends State<BasePinZanProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('点赞Provider'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    print('page');
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child:
                        Text('1公众号『fgyong的开发日记』公众号『fgyong的开发日记』公众号『fgyong的开发日记』'
                            '公众号『fgyong的开发日记』公众号『fgyong的开发日记』1'),
                  )
                ],
              ),
              Text('\n\n\n当小余0 则返回上一页，大于5push下一页'),
              Selector<_RedNumberModel, int>(
                builder: (ctx, value, child) {
                  print('number');

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('$value'),
                      IconButton(
                        icon: Icon(Icons.expand_less),
                        onPressed: () {
                          context.read<_RedNumberModel>().add(1);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.expand_more),
                        onPressed: () {
                          context.read<_RedNumberModel>().add(-1);
                        },
                      )
                    ],
                  );
                },
                selector: (BuildContext contex, _RedNumberModel model) {
                  return model.number;
                },
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              Text('count的值只是展示 不做跳转条件'),
              Selector<_RedNumberModel, int>(
                builder: (ctx, value, child) {
                  print('count');

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('$value'),
                      IconButton(
                        icon: Icon(Icons.expand_less),
                        onPressed: () {
                          context.read<_RedNumberModel>().addCount(1);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.expand_more),
                        onPressed: () {
                          context.read<_RedNumberModel>().addCount(-1);
                        },
                      )
                    ],
                  );
                },
                selector: (BuildContext contex, _RedNumberModel model) {
                  return model.count;
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    context.read<_RedNumberModel>().addListener(listener);
    super.initState();
  }

  void listener() {
    final value = context.read<_RedNumberModel>();
    if (value.number > 5) {
      Navigator.of(context).push(BasePinZanProviderRoute.route);
    } else if (value.number < 0) {
      Navigator.of(context).maybePop();
    }
  }
}

class _RedNumberModel extends ChangeNotifier {
  int number;
  int count;

  _RedNumberModel({this.number, this.count});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _RedNumberModel &&
          runtimeType == other.runtimeType &&
          count == other.count;

  @override
  int get hashCode => count.hashCode;

  void add(int value) {
    number += value;
    notifyListeners();
  }

  void addCount(int value) {
    count += value;
    notifyListeners();
  }
}
