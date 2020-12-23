import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetIncrementPage extends StatefulWidget {
  GetIncrementPage({Key key}) : super(key: key);

  @override
  _GetIncrementPageState createState() => _GetIncrementPageState();
}

class _GetIncrementPageState extends State<GetIncrementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('get'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          var n = c.count.value.count.toString();
          printInfo(info: '刷新了页面 get_数字变动了 $n');
          return Text('当前值：$n');
        }),
        OutlineButton(
          child: Text('get 数字加'),
          onPressed: c.increment,
        ),
        OutlineButton(
          child: Text('get 数字减'),
          onPressed: c.down,
        ),

        Obx(() {
          printInfo(info: '刷新了页面 get_obx_log1');

          return Text('logObx:' + c.log.toString());
        }),
        Obx(() {
          printInfo(info: '刷新了页面 get_obx_log2');

          return Text(c.log2.toString());
        }),
        OutlineButton(
          child: Text('get log 变化'),
          onPressed: c.change,
        ),

        // ObxValue((var value) => Text('${value.toString()}'), c),
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<Controller2>();
    super.dispose();
  }

  final Controller2 c = Get.put(Controller2());
}

class Test extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Test();
}

class _Test extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('$value'),
    );
  }

  var value;

  StreamController<String> subject;
  StreamSubscription streamSubscription;
  @override
  void initState() {
    subject = StreamController.broadcast();
    streamSubscription = subject.stream.listen((event) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    subject.close();
    streamSubscription.cancel();
    super.dispose();
  }

  var nu = 0;
  add() {
    nu++;
    value = 'event$nu';
    subject.add(value);
    ''.obs.value = '123';
  }
}

///
/// Created by fgyong on 2020/10/22.
///

class Controller2 extends GetxController {
  var count = NumberCount().obs;
  var count2 = 0.obs;

  final log = ''.obs;
  final log2 = ''.obs;

  increment() {
    count.value.increment();
    count.refresh();
  }

  down() {
    count.value.down();
    count.refresh();
  }

  @override
  void onClose() {
    printInfo(info: 'Controller close');
    super.onClose();
  }

  void change() {
    log.value += ' ${log.value.length}';
  }
}

class NumberCount {
  var count = 0.obs;
  increment() {
    count++;
  }

  down() {
    count--;
  }
}
