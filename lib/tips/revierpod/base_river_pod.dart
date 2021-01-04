import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/all.dart';

class BaseRiverPodRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BaseRiverPodRouteState();
  }

  static String get routeName => '/BaseRiverPodRoute';
}

class _BaseRiverPodRouteState extends State<BaseRiverPodRoute> {
  @override
  Widget build(BuildContext context) {
    final p = Provider((v) {
      return 123;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('riverpod'),
      ),
      body: Center(
        child: Column(
          children: [
            FlatButton(
              child: Text('数字加减'),
              onPressed: add,
            )
          ],
        ),
      ),
    );
  }

  void add() {
    Get.to(_PlusWidget());
  }
}

class _PlusWidget extends HookWidget {
  final helloWorldProvider = StateProvider((_) => 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('plus')),
      body: Center(
        child: Consumer(builder: (context, watch, _) {
          final counter = watch(helloWorldProvider);

          /// 或者使用value 来读取state
          /// Provider((_) => 0)
          // final int value = useProvider(helloWorldProvider.select((value) => value.state%2==0));

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('加减数字《StateProvider》'),
              SizedBox(
                height: 10,
              ),
              Text(counter.state.toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.grey,
                    margin: EdgeInsets.all(10),
                    child: FlatButton(
                      child: Text('点我+1'),
                      onPressed: () {
                        counter.state++;
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    margin: EdgeInsets.all(10),
                    child: FlatButton(
                      child: Text('点我－1'),
                      onPressed: () {
                        counter.state--;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text('不可变Widget《Provider》'),
              _PlusNoChangeWidget(),
            ],
          );
        }),
      ),
    );
  }
}

class _PlusNoChangeWidget extends HookWidget {
  final helloWorldProvider = Provider((_) => '我不可变，用于读取配置');

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final counter = watch(helloWorldProvider);

      /// 或者使用value 来读取state
      /// Provider((_) => 0)
      /// final int value = useProvider(helloWorldProvider).state;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(counter.toString()),
        ],
      );
    });
  }
}
