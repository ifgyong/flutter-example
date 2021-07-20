import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/util.dart';

///
/// Created by fgyong on 7/19/21.
///

class BaseSwitchListTitlePage extends StatefulWidget {
  const BaseSwitchListTitlePage({Key key}) : super(key: key);

  @override
  _BaseSwitchListTitlePageState createState() =>
      _BaseSwitchListTitlePageState();
  static String get routeName => '/BaseSwitchListTitlePage';
}

T tryCatch<T>({
  T Function() bodyFunc,
  T Function() errorSummaryFunc,
  T Function() noSuchMethodFunc,
  T Function() rangeErrorFunc,
  T Function() outOfMemoryErrorFunc,
  T Function() typeErrorFunc,
  T Function() stateErrorFunc,
  T Function() otherFunc,
  void Function() finallyFunc,
}) {
  try {
    if (bodyFunc != null) return bodyFunc();
  } on ErrorSummary catch (e) {
    Util.v('$e', tag: 'ErrorSummary');
    if (errorSummaryFunc != null) return errorSummaryFunc();
  } on NoSuchMethodError catch (e) {
    Util.v('$e', tag: 'NoSuchMethodError');
    if (noSuchMethodFunc != null) return noSuchMethodFunc();
  } on RangeError catch (e) {
    Util.v('$e', tag: 'RangeError');
    if (rangeErrorFunc != null) return rangeErrorFunc();
  } on OutOfMemoryError catch (e) {
    Util.v('$e', tag: 'OutOfMemoryError');
    if (outOfMemoryErrorFunc != null) return outOfMemoryErrorFunc();
  } on TypeError catch (e) {
    Util.v('$e', tag: 'TypeError');
    if (typeErrorFunc != null) return typeErrorFunc();
  } on StateError catch (e) {
    Util.v('$e', tag: 'StateError');
    if (stateErrorFunc != null) return stateErrorFunc();
  } catch (e) {
    Util.v('$e', tag: 'Error:${e.runtimeType}');
    if (otherFunc != null) return otherFunc();
  } finally {
    Util.v('finally');
    if (finallyFunc != null) finallyFunc();
  }
}

class _BaseSwitchListTitlePageState extends State<BaseSwitchListTitlePage> {
  bool _isOpen = true;
  bool _isOpen2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('切换开关'),
      ),
      body: Container(
        child: Column(
          children: [
            SwitchListTile(
              value: _isOpen,
              onChanged: (s) {
                setState(() {
                  _isOpen = s;
                  tryCatch<void>(
                    bodyFunc: () {},
                    noSuchMethodFunc: () {
                      Util.v('noSuchMethodFunc');
                    },
                  );
                });
              },
              title: Text('开关上边'),
              subtitle: Text('二级开关下边'),
              secondary: Icon(Icons.forward),
            ),
            SwitchListTile(
              value: _isOpen2,
              onChanged: (s) {
                tryCatch(bodyFunc: () {
                  setState(() {
                    _isOpen2 = s;
                  });
                });
              },
              title: Text('开关'),
              subtitle: Text('二级开关'),
              secondary: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
