import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest01/baseWidget/baseState.dart';
import 'package:fluttertest01/test.dart';
import 'package:equatable/equatable.dart';

///
/// Created by fgyong on 2020/8/11.
///

class BaseBLocRoute2 extends StatefulWidget {
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

/// 操作事件 用来区分不同的动作
//enum CounterEvent {
//  increment,
//  decrement,
//}
//
//class CounterBloc extends Bloc<CounterEvent, int> {
//  CounterBloc(int initialState) : super(0);
//
//  @override
//  Stream<int> mapEventToState(CounterEvent event) async* {
//    switch (event) {
//      case CounterEvent.decrement:
//        print('-1');
//        yield state - 1;
//        break;
//      case CounterEvent.increment:
//        print('+1');
//        yield state + 1;
//    }
//  }
//}

class _BaseBLoCRouteState extends State<BaseBLoCRoute> {
  @override
  Widget build(BuildContext context) {
    print('_BaseBLoCRouteState build +1');
    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
//          BlocProvider.of<CounterCubit>(context).increment();
          BlocProvider.of<CounterCubit2>(context).request();
        },
      ),
    );
  }

  Widget _body() {
    return Center(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: BlocBuilder<CounterCubit, int>(
              builder: (_, count) {
                print('_body BlocBuilder CounterCubit ');
                return Column(
                  children: <Widget>[
                    Text('$count'),
                    OutlineButton(
                      child: Icon(Icons.details),
                      onPressed: () {
                        context.bloc<CounterCubit>().decrement();
                      },
                    )
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<CounterCubit2, Model>(
              builder: (_, count) {
                print('_body2 BlocBuilder2 CounterCubit2 model ');
                return Column(
                  children: <Widget>[
                    Text('$count'),
                    OutlineButton(
                      child: Icon(Icons.details),
                      onPressed: () {
                        context.bloc<CounterCubit2>().request();
                      },
                    )
                  ],
                );
              },
            ),
          )
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

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    print('CounterCubit +1');

    emit(state + 1);
  }

  void decrement() {
    print('CounterCubit -1');
    emit(state - 1);
  }
}

// ignore: must_be_immutable
class Model extends Equatable {
  int count;
  String name;
  List<String> list;
  Model({this.count, this.name, this.list});

  @override
  List<Object> get props => [count, name, list];
}

class CounterCubit2 extends Cubit<Model> {
  CounterCubit2() : super(Model());

  void increment() {
    print('CounterCubit2 CounterCubit +1');
//    emit(state.count + 1);
  }

  void request() {
    state.list ??= ['1'];
    var list = state.list;
    list.add('next');

    emit(state);
  }

  void decrement() {
    print('CounterCubit -1');
//    emit(state - 1);
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
