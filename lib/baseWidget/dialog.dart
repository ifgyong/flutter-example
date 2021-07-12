import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BaseDialogState();
  }
}

class BaseDialogState extends State<BaseDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('弹框'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    Widget w = Column(
      children: <Widget>[
        OutlineButton(
          child: Text('showCupertinoModalPopup'),
          onPressed: _showActionSheet,
        ),
        OutlineButton(
          child: Text('showCupertinoDialog'),
          onPressed: _showCupertinoDialog,
        ),
        OutlineButton(
          child: Text('showAboutDialog'),
          onPressed: _showAboutDialog,
        ),
        OutlineButton(
          child: Text('showGeneralDialog'),
          onPressed: _showGeneralDialog,
        ),
        OutlineButton(
          child: Text('showDialog'),
          onPressed: _showDialog,
        ), //_showBottomSheet
        OutlineButton(
          child: Text('showDatePicker'),
          onPressed: _showDatePicker,
        ),
        //_showTimePicker
        OutlineButton(
          child: Text('showTimePicker'),
          onPressed: _showTimePicker,
        ),
      ],
    );
    return w;
  }

  void _showActionSheet() {
    showCupertinoModalPopup(
        context: context,
        builder: (ctx) {
          return CupertinoActionSheet(
            title: Text('温馨提示'),
            message: Text('我是支付选项，任意选择一个进行支付哦'),
            actions: <Widget>[
              CupertinoActionSheetAction(onPressed: _pop, child: Text('微信')),
              CupertinoActionSheetAction(onPressed: _pop, child: Text('支付宝')),
              CupertinoActionSheetAction(
                onPressed: _pop,
                child: Text('取消'),
                isDestructiveAction: true,
              ),
            ],
          );
        });
  }

  void _showCupertinoDialog() {
    showCupertinoDialog(
        context: context,
        builder: (ctx) {
          return CupertinoActionSheet(
            title: Text('温馨提示'),
            message: Text('我是showCupertinoDialog'),
            actions: <Widget>[
              CupertinoActionSheetAction(onPressed: _pop, child: Text('微信')),
              CupertinoActionSheetAction(onPressed: _pop, child: Text('支付宝')),
              CupertinoActionSheetAction(
                onPressed: _pop,
                child: Text('取消'),
                isDestructiveAction: true,
              ),
            ],
          );
        });
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationVersion: '1.0.0',
      applicationIcon: Icon(Icons.scatter_plot),
      applicationName: 'Jack ma',
    );
  }

  void _showGeneralDialog() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'cancel',
        transitionDuration: Duration(milliseconds: 1000),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Material(
            child: Scaffold(
              body: Center(
                child: CupertinoActionSheet(
                  title: Text('温馨提示'),
                  message: Text('我是showGeneralDialog，任意选择一个进行支付哦'),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                        onPressed: _pop, child: Text('微信')),
                    CupertinoActionSheetAction(
                        onPressed: _pop, child: Text('支付宝')),
                    CupertinoActionSheetAction(
                      onPressed: _pop,
                      child: Text('取消'),
                      isDestructiveAction: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showDialog() {
    showDialog(context: context, builder: (_) => bd());
  }

  void _showDatePicker() {
    showDatePicker(
        context: this.context,
        initialDate: DateTime.now(), //初始时间
        firstDate: DateTime.now(), //开始时间
        lastDate: DateTime.now().add(Duration(days: 10)), //最后时间是当前时间加上10天
        initialDatePickerMode: DatePickerMode.year, //最开始展示年份
        initialEntryMode: DatePickerEntryMode.input, //开始是输入时间还是日历
        selectableDayPredicate: (time) {
          print(time.toString());
          return true;
        });
  }

  void _showTimePicker() {
    showTimePicker(
        context: this.context, initialTime: TimeOfDay(hour: 1, minute: 10));
  }

  void _pop() {
    Navigator.maybePop(context);
  }

  Widget bd() {
    return CupertinoActionSheet(
      title: Text('温馨提示'),
      message: Text('我是支付选项，任意选择一个进行支付哦'),
      actions: <Widget>[
        CupertinoActionSheetAction(onPressed: _pop, child: Text('微信')),
        CupertinoActionSheetAction(onPressed: _pop, child: Text('支付宝')),
        CupertinoActionSheetAction(
          onPressed: _pop,
          child: Text('取消'),
          isDestructiveAction: true,
        ),
      ],
    );
  }
}
