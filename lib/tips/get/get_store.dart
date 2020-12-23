import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStoreRoute extends StatefulWidget {
  GetStoreRoute({Key key}) : super(key: key);

  @override
  _GetStoreState createState() => _GetStoreState();
}

class _GetStoreState extends State<GetStoreRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetStorage存储'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: [
          Text('GetStorage 添加和读取 ：'),
          Padding(
            child: TextField(
              controller: c.editK,
              decoration: InputDecoration(hintText: 'key', labelText: 'key'),
            ),
            padding: EdgeInsets.all(20),
          ),
          Padding(
            child: TextField(
              controller: c.editC,
              decoration: InputDecoration(hintText: 'value', labelText: 'value'),
            ),
            padding: EdgeInsets.all(20),
          ),
          Row(
            children: [
              OutlineButton(
                child: Text('添加'),
                onPressed: c.add,
              ),
              OutlineButton(
                child: Text('清空'),
                onPressed: c.clearData,
              ),
              OutlineButton(
                child: Text('保存'),
                onPressed: c.save,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
          SizedBox(
            height: 10,
          ),
          Text('添加操作日志：'),
          ObxValue((v) {
            return Text('${v.value}');
          }, c.log),
          Text('读取到的：keyAndValue：'),
          SizedBox(
            child: ObxValue((keyAndValue) {
              return Text('$keyAndValue');
            }, c.keyAndValue),
            // alignment: Alignment.center,
            width: 100,
            height: 200,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    printInfo(info: '${widget.runtimeType}initState');
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<GetStoreController>();
    super.dispose();
  }

  final c = Get.put<GetStoreController>(GetStoreController());
}

class GetStoreController extends GetxController {
  final log = ''.obs;
  final editC = TextEditingController();
  final editK = TextEditingController();
  final box = GetStorage();
  final boxObx = GetStorage();
  final keyAndValue = ''.obs;

  void add() async {
    if (editK.text.isNotEmpty) {
      box.write('${editK.text}', '${editC.text}');
    }
  }

  @override
  void onInit() {
    GetStorage.init();

    printInfo(info: 'GetStoreController init');

    /// 监听固定的 key
    box.listenKey('key', (v) {
      log.value = log.value + 'key->$v \n';
    });

    /// 监听变动
    /// 可以每次变动去监测所有数据
    box.listen(() {
      var changeStr = box.changes.toString();

      var value = '';

      box.getKeys<Iterable<String>>().forEach((element) {
        var currentKeyAndValue = 'key:$element' +
            "  value:" +
            boxObx.read(element).toString() +
            ''
                '\n';
        value += value + currentKeyAndValue;
        printInfo(info: currentKeyAndValue);
      });
      keyAndValue.value = value;

      log.value = log.value + '$changeStr \n';
    });
    super.onInit();
  }

  void clearData() {
    log.value = '';
    box.erase();
  }

  void save() {
    box.save();
  }
}
