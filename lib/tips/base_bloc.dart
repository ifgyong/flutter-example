import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest01/baseWidget/baseState.dart';
import 'package:fluttertest01/test.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertest01/tips/bloc/login_bloc/login_bloc_page.dart';
import '../tips/bloc/base_login_cubit.dart';

///
/// Created by fgyong on 2020/8/11.
///

class BaseBLoCPageRoute extends StatefulWidget {
  BaseBLoCPageRoute({Key key}) : super(key: key);

  @override
  _BaseBLoCPageRouteState createState() => _BaseBLoCPageRouteState();
  static String get routeName => 'BaseBLoCRoute';
}

class _BaseBLoCPageRouteState extends State<BaseBLoCPageRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: OutlineButton(
            child: Text('简单数字加减例子'),
            onPressed: () {
              push(BaseBLocRoute2());
            },
          ),
        ),
        SliverToBoxAdapter(
          child: OutlineButton(
            child: Text('login Cubit'),
            onPressed: () {
              push(BaseLoginPageRoute());
            },
          ),
        ),
        SliverToBoxAdapter(
          child: OutlineButton(
            child: Text('login BLoC'),
            onPressed: () {
              push(LoginBlocRoute());
            },
          ),
        )
      ],
    );
  }

  void push(Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
  }
}

class BaseBLocRoute2 extends StatefulWidget {
  /// 局部刷新 数字加减例子页面
  BaseBLocRoute2({Key key}) : super(key: key);

  @override
  _BaseBLocRoute2State createState() => _BaseBLocRoute2State();
}

class _BaseBLocRoute2State extends State<BaseBLocRoute2> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CounterCubit(),
        ),
        BlocProvider(
          create: (_) => CounterCubit2(),
        ),
      ],
      child: BaseBLoCRoute(),
    );
  }
}

class BaseBLoCRoute extends StatefulWidget {
  BaseBLoCRoute({Key key}) : super(key: key);

  @override
  _BaseBLoCRouteState createState() => _BaseBLoCRouteState();
}

class _BaseBLoCRouteState extends State<BaseBLoCRoute> {
  @override
  Widget build(BuildContext context) {
    print('page build +1');
    return Scaffold(
      appBar: AppBar(
        title: Text('局部刷新数字加减'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: BlocBuilder<CounterCubit, Model>(
              builder: (_, count) {
                print('CounterCubit1 ');
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      child: Text(
                        'count: ${count.count}',
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    OutlineButton(
                      child: Icon(Icons.arrow_drop_up),
                      onPressed: () {
                        context.bloc<CounterCubit>().addCount(1);
                      },
                    ),
                    OutlineButton(
                      child: Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        context.bloc<CounterCubit>().addCount(-1);
                      },
                    )
                  ],
                );
              },
              buildWhen: (m1, m2) => m1.count != m2.count,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<CounterCubit, Model>(
              builder: (_, count) {
                print('CounterCubit age build ');
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      child: Text(
                        'age:${count.age}',
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    OutlineButton(
                      child: Icon(Icons.arrow_drop_up),
                      onPressed: () {
                        context.bloc<CounterCubit>().addAge(1);
                      },
                    ),
                    OutlineButton(
                      child: Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        context.bloc<CounterCubit>().addAge(-1);
                      },
                    )
                  ],
                );
              },
              buildWhen: (m1, m2) => m1.age != m2.age,
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<CounterCubit2, Model>(
              builder: (_, count) {
                print('CounterCubit2 ');
                return Column(
                  children: <Widget>[
                    Text('CounterCubit2: ${count.age}'),
                    OutlineButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        context.bloc<CounterCubit2>().addAge(1);
                      },
                    )
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: BlocConsumer<CounterCubit, Model>(builder: (ctx, state) {
              return Column(
                children: <Widget>[
                  Text(
                      'age:${context.bloc<CounterCubit>().state.age} count:${context.bloc<CounterCubit>().state.count}'),
                  OutlineButton(
                    child: Text('age+1'),
                    onPressed: () {
                      context.bloc<CounterCubit>().addAge(1);
                    },
                  ),
                  OutlineButton(
                    child: Text('age-1'),
                    onPressed: () {
                      context.bloc<CounterCubit>().addAge(-1);
                    },
                  ),
                  OutlineButton(
                    child: Text('count+1'),
                    onPressed: () {
                      context.bloc<CounterCubit>().addCount(1);
                    },
                  ),
                  OutlineButton(
                    child: Text('count-1'),
                    onPressed: () {
                      context.bloc<CounterCubit>().addCount(-1);
                    },
                  )
                ],
              );
            }, listener: (ctx, state) {
              if (state.age + state.count == 10) Navigator.maybePop(context);
            }),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    Bloc.observer = SimpleBlocObserver();
    super.initState();
  }
}

class CounterCubit extends Cubit<Model> {
  CounterCubit() : super(Model(count: 0, name: '老王'));

  void increment() {
    print('CounterCubit +1');
    emit(state.addCount(1));
  }

  void decrement() {
    print('CounterCubit -1');
    emit(state.clone());
  }

  void addAge(int v) {
    emit(state.addAge(v));
  }

  void addCount(int v) {
    emit(state.addCount(v));
  }
}

// ignore: must_be_immutable
class Model extends Equatable {
  int count;
  int age;
  String name;
  Model({this.count = 0, this.name, this.age = 0});

  @override
  List<Object> get props => [count, name, age];
  Model addCount(int value) {
    return clone()..count = count + value;
  }

  Model addAge(int value) {
    return clone()..age = age + value;
  }

  Model clone() {
    return Model(count: count, name: name, age: age);
  }

  @override
  bool operator ==(Object other) {
    if (other is Model)
      return this.count == other.count &&
          age == other.age &&
          name == other.name;
    return false;
  }

  @override
  int get hashCode => super.hashCode;
}

class CounterCubit2 extends Cubit<Model> {
  CounterCubit2() : super(Model());

  Model addAge(int v) {
    emit(state.addAge(v));
  }
}

/// 观察者来观察 事件的变化 可以使用默认的 [BlocObserver]
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print(change);
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(cubit, error, stackTrace);
  }
}
