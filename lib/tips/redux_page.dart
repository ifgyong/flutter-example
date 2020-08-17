import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

///
/// Created by fgyong on 2020/8/12.
///

class BaseReduxPateRoute extends StatelessWidget {
  Store<int> store;
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  static String get routeName => 'BaseReduxPateRoute';

  Widget _body() => BaseReduxPage();
}

class BaseReduxPage extends StatefulWidget {
  BaseReduxPage({Key key}) : super(key: key);

  @override
  _BaseBaseReduxPageState createState() => _BaseBaseReduxPageState();
}

class _MiddleWare<_Model> extends MiddlewareClass<_Model> {
  @override
  call(Store<_Model> store, action, next) {
    if (action == Actions.DecrementValue) {}
    print(action);
    next(action);
  }
}

class _BaseBaseReduxPageState extends State<BaseReduxPage> {
  String _build = '';
  Store<_Model> store;
  mw(Store<_Model> store, action, NextDispatcher next) {
    print('1:${new DateTime.now()}: $action');
    next(action);
  }

  mw2(Store<_Model> store, action, NextDispatcher next) {
    print('2:${new DateTime.now()}: $action');
    next(action);
  }

  StreamController _streamController;
  _Model _model = _Model();
  @override
  void initState() {
    store = Store(counterReducer, initialState: _Model(), middleware: [
      mw,
      mw2,
    ]);
    store.onChange.listen((event) {
      print('init $event');
    });
    _streamController = StreamController.broadcast()
      ..stream.listen((event) {
        print('init${event}');
      });
    _streamController.add(counterReducer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _build += 'p1 build \n';
    return StoreProvider(
      store: store,
      child: Scaffold(
          appBar: AppBar(
            title: Text('ReduxModel'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  child: Text('change'),
                  onPressed: () {
                    _model = counterReducer(_model, Actions.DecrementValue);
                  },
                ),
//                StreamBuilder<_Model>(
//                  stream: _streamController.stream,
//                  builder: (context, snapshot) {
//                    return Text(snapshot.data.value.toString());
//                  },
//                ),
                Text(_build),
                StoreConnector<_Model, String>(
                  converter: (store) => store.state.value.toString(),
                  builder: (context, count) {
                    _build += 's1';
                    return Text('value:$count');
                  },
                ),
                StoreConnector<_Model, String>(
                  converter: (store) => store.state.count.toString(),
                  builder: (context, count) {
                    _build += 's2';
                    return Text('count:$count');
                  },
                ),
                StoreConnector<_Model, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(Actions.IncrementValue);
                  },
                  builder: (context, callback) {
                    return OutlineButton(
                      child: Text('+1 value'),
                      onPressed: callback,
                    );
                  },
                ),
                StoreConnector<_Model, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(Actions.DecrementValue);
                  },
                  builder: (context, callback) {
                    return OutlineButton(
                      child: Text('-1 value'),
                      onPressed: callback,
                    );
                  },
                ),
                StoreConnector<_Model, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(Actions.IncrementCount);
                  },
                  builder: (context, callback) {
                    return OutlineButton(
                      child: Text('+count'),
                      onPressed: callback,
                    );
                  },
                ),
                StoreConnector<_Model, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(Actions.DecrementCount);
                  },
                  builder: (context, callback) {
                    return OutlineButton(
                      child: Text('-count'),
                      onPressed: callback,
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlineButton(
                      child: Icon(Icons.refresh),
                      onPressed: () {
                        if (mounted) setState(() {});
                      },
                    ),
                    OutlineButton(
                      child: Icon(Icons.clear),
                      onPressed: () {
                        if (mounted)
                          setState(() {
                            _build = '';
                          });
                      },
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

enum Actions { IncrementValue, IncrementCount, DecrementCount, DecrementValue }

class _Model {
  int value, count;
  _Model({this.value, this.count}) {
    value ??= 0;
    count ??= 0;
  }
}

_Model counterReducer(_Model state, dynamic action) {
//  print(0);
  if (action == Actions.IncrementValue) {
    state.value += 1;
    return state;
  } else if (action == Actions.DecrementCount) {
    state.count -= 1;
    return state;
  } else if (action == Actions.IncrementCount) {
    state.count += 1;
  } else if (action == Actions.DecrementValue) {
    state.value -= 1;
  }
  return state;
}
