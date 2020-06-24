import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/counter.dart';
import 'package:provider/provider.dart';

void main() {
  Widget app = MyApp();
  app = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CounterValue2()),
      ChangeNotifierProvider(create: (_) => CounterValue()),
//        Provider(create: (_) => CounterValue()),
    ],
    child: MyApp(),
  );
  runApp(app);
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<StatefulWidget> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    for (int i = 0; i < 20; i++) {
      _list.add(Colors.primaries[i % Colors.primaries.length]);
    }
    _controller = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: Duration(milliseconds: 1000));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build once');
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: SafeArea(
          child: Container(
            child: CupertinoScrollbar(
              child: _body3(),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                _counter.value += 1;
                _addItem();
              },
            ),
            FloatingActionButton(
              child: Icon(Icons.trending_down),
              onPressed: () {
                setState(() {
                  _changeWidget = Container(
                    key: ObjectKey('123456789'),
                    child: Text('change value'),
                    color: Colors.black,
                  );
                });
//                _list.removeAt(0);
//                _animatedListKey.currentState.removeItem(0,
//                    (context, animation) {
//                  return _removeItem(context, animation, 0);
//                });
              },
            ),
            FloatingActionButton(
              child: AnimatedIcon(
                icon: _controller.isCompleted
                    ? AnimatedIcons.close_menu
                    : AnimatedIcons.menu_close,
                progress: _controller,
              ),
              onPressed: () {
                if (_controller.isCompleted == false) {
                  _controller.reset();
                  _controller.forward();
                } else {
                  _controller.reverse();
                }

                setState(() {
                  _changeWidget = Container(
                    width: 300,
                    height: 100,
                    key: ObjectKey('12345'),
                    child: Text('change value'),
                    color: Colors.red,
                  );
                });
              },
            )
          ],
        ),
      ),
    );
  }

  List<Color> _list = [];
  final _animatedListKey = GlobalKey<AnimatedListState>();
  void _addItem() {
    _list.add(Colors.primaries[0]);
    _animatedListKey.currentState.insertItem(0, duration: Duration(seconds: 4));
  }

  Widget _body() {
    Widget w = AnimatedList(
      key: _animatedListKey,
      initialItemCount: _list.length,
      itemBuilder: (ctx, index, animation) {
        return _buildCell2(index);
      },
    );
    return w;
  }

  Widget _changeWidget;
  Widget _body3() {
    List<Widget> children = [];
    for (int i = 0; i < _list.length; i++) {
      Widget w = Container(
        key: ObjectKey(i),
        child: Text('${_list[i]}'),
        color: _list[i],
      );
      children.add(w);
    }
    _changeWidget ??= Container(
      key: ObjectKey('123456'),
      child: Text('change value'),
      color: Colors.greenAccent,
    );
    Widget last = AnimatedSwitcher(
      key: ObjectKey('16789023'),
      child: _changeWidget,
      duration: Duration(milliseconds: 4000),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          child: child,
          opacity: animation,
        );
      },
    );
    children.add(last);

    Widget w = ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        setState(() {
          Color cl1 = _list[oldIndex];
          _list[oldIndex] = _list[newIndex];

          _list[newIndex] = cl1;
        });
      },
      children: children,
    );
    return last;
  }

  Widget _removeItem(
      BuildContext context, Animation<double> animation, int index) {
    return AlignTransition(
      alignment: animation
          .drive(Tween(begin: Alignment.bottomLeft, end: Alignment.topRight)),
      child: Container(
        height: 100,
        color: _list[index],
        alignment: Alignment.center,
        child: Text('${_list[index]}'),
      ),
    );
  }

  Widget _buildCell2(int index) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      color: _list[index],
      child: Text('索引$index.${_list[index]}'),
    );
    return Row(
      children: <Widget>[
        Flexible(
          flex: index % 3 + 1,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                height: 100,
                alignment: Alignment.center,
                color: Colors.primaries[index % Colors.primaries.length],
                child: Text('索引.${_list[index]}'),
              ),
            ),
          ),
        ),
        Flexible(
          flex: index % 2 + 1,
          child: Container(
            height: 100,
            alignment: Alignment.center,
            color: Colors.primaries[index + 4 % Colors.primaries.length],
            child: Text('索引.${_list[index]}'),
          ),
        )
      ],
    );
  }

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  Widget _body2() {
    Widget w = ValueListenableBuilder<int>(
        valueListenable: _counter,
        builder: (ctx, vlaue, _) {
          return Text('times:$vlaue');
        });
    return Wrap(
      children: <Widget>[
        Draggable<Color>(
          data: Colors.red,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
          feedback: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
          onDragCompleted: () {
            print('onDragCompleted');
          },
          onDragStarted: () {
            print('onDragStarted');
          },
          onDragEnd: (DraggableDetails de) {},
          onDraggableCanceled: (Velocity v, Offset set) {},
        ),
        SizedBox(
          width: 100,
          height: 100,
        ),
        DragTarget<Color>(
          builder: (BuildContext context, List<Color> candidateData,
              List<dynamic> rejectedData) {
            print('onWillAccept $candidateData $rejectedData');
            if (candidateData.length > 0) {
              return Container(
                width: 120,
                height: 120,
                color: candidateData[0],
              );
            } else {
              return Container(
                width: 100,
                height: 100,
                color: Colors.black,
              );
            }
          },
          onAccept: (cl) {
            print('onAcc $cl');
          },
          onWillAccept: (cl) {
            print('onWillAccept $cl');

            return true;
          },
        ),
        w,
      ],
    );
  }
//
//  Widget _buildCell(BuildContext context, int index) {
//    Widget image = FadeInImage.assetNetwork(
//        placeholder: 'd.png',
////        fit: BoxFit.fill,
////        alignment: Alignment.center,
//        image:
//            'http://attach.bbs.miui.com/forum/201402/10/142553yulul4yl34ylomtt.jpg');
////    Widget fitter = FittedBox(
////      child: image,
////      fit: BoxFit.fitHeight,
////      alignment: Alignment.center,
////    );
//    String k = _list[index];
//    return GestureDetector(
//      child: Dismissible(
//        child: image,
//        direction: DismissDirection.endToStart,
//        secondaryBackground: Container(
//          color: Colors.red,
//          alignment: Alignment.centerRight,
//          child: FlatButton(
//            child: Text('text secondary$k'),
//          ),
//        ),
//        background: Container(
//          alignment: Alignment.centerLeft,
//          child: FlatButton(
//            child: Text('text background $k'),
//          ),
//        ),
//        onDismissed: (dis) {
//          setState(() {
//            _list.removeAt(index);
//          });
//        },
//        key: Key('${_list[index]}'),
//      ),
//      onTap: () {
//        setState(() {});
//      },
//    );
//  }
}
