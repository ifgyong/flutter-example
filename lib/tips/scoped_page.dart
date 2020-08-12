import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// Created by fgyong on 2020/8/12.
///

class BaseScopedPateRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<_BaseModel>(
      model: _BaseModel(),
      child: ScopedModel<_BaseModel2>(
        model: _BaseModel2(),
        child: _body(),
      ),
    );
  }

  static String get routeName => 'BaseScopedPate';

  Widget _body() => BaseScopedPate();
}

class BaseScopedPate extends StatefulWidget {
  BaseScopedPate({Key key}) : super(key: key);

  @override
  _BaseScopedPateState createState() => _BaseScopedPateState();
}

class _BaseScopedPateState extends State<BaseScopedPate> {
  String _build = '';
  @override
  Widget build(BuildContext context) {
    _build += 'p1 build \n';
    return Scaffold(
        appBar: AppBar(
          title: Text('ScopedModel'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_build),
              ScopedModelDescendant<_BaseModel>(
                builder: (context, child, model) {
                  _build += 'b1 ';

                  return Center(
                    child: Text('${model.count}'),
                  );
                },
                child: Text('外部小部件'),
              ),
              ScopedModelDescendant<_BaseModel2>(
                builder: (context, child, model) {
                  _build += 'b2 ';

                  return Center(
                    child: Text('${model.count}'),
                  );
                },
                child: Text('外部小部件'),
              ),
              OutlineButton(
                child: Icon(Icons.add),
                onPressed: () {
                  ScopedModel.of<_BaseModel>(context).add(1);
                },
              ),
              OutlineButton(
                child: Text('－'),
                onPressed: () {
                  ScopedModel.of<_BaseModel2>(context).add(-1);
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
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class _BaseModel extends Model {
  int _count = 0;
  void add(int a) {
    _count += a;
    notifyListeners();
  }

  int get count => _count;
}

class _BaseModel2 extends Model {
  int _count = 0;
  void add(int a) {
    _count += a;
    notifyListeners();
  }

  int get count => _count;
}
