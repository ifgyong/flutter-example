import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class BaseVisibilityDetector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BaseVisibilityDetectorState();
  static String get routeName => '/BaseVisibilityDetector';
}

class _BaseVisibilityDetectorState extends State<BaseVisibilityDetector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BaseVisibilityDetector'),
      ),
      body: CustomScrollView(
        slivers: [
          _item('0'),
          _item('1'),
          _item('2'),
          _item('3'),
          _item('4'),
          _item('5'),
          _item('6'),
          _item2('6'),
          _item('7'),
          _item('8'),
          _item('9'),
          _item('10'),
        ],
      ),
    );
  }

  SliverToBoxAdapter _item(String index) {
    return SliverToBoxAdapter(
      child: VisibilityDetector(
        key: ValueKey('key_$index'),
        child: Container(
          height: 100,
          child: Text('key_$index'),
        ),
        onVisibilityChanged: (show) {
          print('$index ${show.visibleFraction * 100}');
        },
      ),
    );
  }

  SliverToBoxAdapter _item2(String index) {
    return SliverToBoxAdapter(
      child: VisibilityDetector(
        key: ValueKey('key2_$index'),
        child: SizedBox(
          height: 100,
          child: TextField(),
        ),
        onVisibilityChanged: (show) {
          print('$index ${show.visibleFraction * 100}');
        },
      ),
    );
  }
}
