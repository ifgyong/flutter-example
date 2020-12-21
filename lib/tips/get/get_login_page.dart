import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class GetLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GetLoginPageState();
  }

  static String get routeName => "GetLoginPage";
}

/// 登陆根据编辑的手机号和密码动态刷新按钮状态
/// 点击 展示动画
/// 结束弹窗
class _GetLoginPageState extends State<GetLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Center(
        child: GetBuilder<GetLoginController>(
          builder: (v) {
            return _body();
          },
          init: c,
        ),
      ),
    );
  }

  final c = Get.put(GetLoginController());

  Widget _body() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          TextField(
            controller: c.editMobile,
            onChanged: (v) {
              c.changePwd();
            },
            decoration: InputDecoration(hintText: '账号', labelText: '账号'),
          ),
          TextField(
            controller: c.editPwd,
            onChanged: (v) {
              c.changePwd();
            },
            decoration: InputDecoration(hintText: '密码', hintMaxLines: 1, labelText: '密码'),
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 30,
            child: Container(
              child: ObxValue(
                  (v) => OutlineButton(
                        child: ObxValue(
                            (v2) => v2.value == true
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    '登陆',
                                    style: TextStyle(
                                        color: v.value == true ? Colors.black : Colors.grey),
                                  ),
                            c.commit),
                        onPressed: v.value == true
                            ? () {
                                c.login();
                              }
                            : null,
                      ),
                  c.canLogin.obs),
            ),
          )
        ],
      ),
      margin: EdgeInsets.only(left: 20, right: 20),
    );
  }

  @override
  void initState() {
    c.msg.listen((data) {
      // Get.snackbar('title', data, snackStyle: SnackStyle.FLOATING);
      printInfo(info: data);
      Fluttertoast.showToast(
        msg: data,
        toastLength: Toast.LENGTH_SHORT,
      );
    });
    printInfo(info: '_GetLoginPageState initState');
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<GetLoginController>();
    super.dispose();
  }
}

class GetLoginController extends GetxController {
  var editMobile = TextEditingController();
  var editPwd = TextEditingController();
  var msg = "".obs;
  var canLogin = false.obs;
  var commit = false.obs;

  void changeName() {
    canLogin.value = canCommit();
  }

  void changePwd() {
    canLogin.value = canCommit();
    // canLogin.subject.add(canCommit());
  }

  bool canCommit() {
    return editMobile.text.length > 0 && editPwd.text.length > 0;
  }

  void login() async {
    Get.focusScope.unfocus();
    commit.value = true;
    await Future.delayed(Duration(seconds: 1));

    if (editPwd.value.text == "123456" && editMobile.text.trim() == '110') {
      msg.subject.add('登陆成功');
    } else {
      msg.subject.add('账号或者密码错误');
    }

    commit.value = false;
  }
}
