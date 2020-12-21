import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//
// class GetListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final Controller c = Get.put<GetListController>(GetListController());
//
//     return GetListPageRoute();
//   }
// }

class GetListController extends GetxController {
  var data = List<String>().obs;
  var count = 0.obs;
  var isLoadingMore = false.obs;
  void fetch() async {
    isLoadingMore.value = true;
    // Get.dialog(SizedBox(height: 50, child: Center(child: CircularProgressIndicator())));
    Future.delayed(Duration(seconds: 1)).then((value) {
      data.add('老李来了${data.length}');
      isLoadingMore.value = false;
      // Get.back();
    });
    // var l = data.length;

    // if (data.canUpdate) {
    //   data.add('老李来了$l');
    // } else {
    //   printInfo(info: '更新数据失败');
    // }
  }

  @override
  void onInit() {
    printInfo(info: 'getlistinit');
    super.onInit();
  }

  @override
  void onClose() {
    printInfo(info: 'getlist onClose');

    super.onClose();
  }

  void clearData() => data.clear();

  void add() {
    count += 1;
  }
}

class GetListPageRoute extends StatefulWidget {
  static final String routeName = "getListPage";

  @override
  State<StatefulWidget> createState() {
    return GetListPageRouteState();
  }
}

class GetListPageRouteState extends State<GetListPageRoute> {
  final GetListController c = Get.put(GetListController());

  @override
  Widget build(BuildContext context) {
    printInfo(info: 'build');
    return Scaffold(
      appBar: AppBar(
        title: Text('get list page '),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ObxValue((data) {
              return _center();
            }, c.data),
            top: 70,
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlineButton(
                  onPressed: () {
                    c.fetch();
                  },
                  child: Text('下载数据'),
                ),
                OutlineButton(
                  onPressed: () {
                    c.clearData();
                  },
                  child: Text('清空数据'),
                ),
                OutlineButton(
                  onPressed: () {
                    c.add();
                  },
                  child: Obx(() => Text('+ ${c.count} ${c.isLoadingMore.value}')),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cellBuild(BuildContext context, int index) {
    if (c.data.length == index) {
      printInfo(info: 'c.loading ${c.isLoadingMore}');
      return SizedBox(
        height: 50,
        child: Center(
          child: ObxValue((value) {
            return value.value
                ? CircularProgressIndicator()
                : OutlineButton(
                    child: Text('点击加载更多'),
                    onPressed: () {
                      c.fetch();
                    },
                  );
          }, c.isLoadingMore),
        ),
      );
    }
    return ListTile(
      title: Text(c.data[index]),
    );
  }

  Widget _center() => Center(
        child: ListView.builder(
          itemBuilder: _cellBuild,
          itemCount: c.data.length + 1,
        ),
      );
  @override
  void dispose() {
    /// 从当前和页面删除 数据
    /// 下次进来 需要重新请求数据
    Get.delete<GetListController>();
    super.dispose();
  }
}
