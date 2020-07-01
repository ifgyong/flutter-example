import 'package:flutter/material.dart';

class BaseFlowAndWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('流式布局'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: _body(),
            color: Colors.black12,
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: _bd2(),
            color: Colors.black12,
          )
        ],
      ),
    );
  }

  Widget _body() {
    return Wrap(
      runAlignment: WrapAlignment.start,
      alignment: WrapAlignment.center,
      spacing: 20.0,
      runSpacing: 30,
      direction: Axis.horizontal,
      children: <Widget>[
        _item('Are you ok ？', 'A'),
        _item('I am ok ', 'B'),
        _item('马什么？', 'C'),
        _item('什么梅？', 'D'),
        _item('马东什么？', 'E'),
      ],
    );
  }

  Widget _item(String title, String subavator) {
    return Chip(
      avatar: new CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(subavator),
      ),
      label: Text(title),
    );
    return OutlineButton.icon(
        onPressed: null, icon: Icon(Icons.mail), label: Text(title));
  }

  Widget _bd2() {
    return Flow.unwrapped(
      delegate: BaseFlowDelegate(margin: EdgeInsets.all(20)),
      children: _list(),
    );
  }

  List<Widget> _list() {
    return <Widget>[
      _item('Are you ok ？', 'A'),
      _item('I am ok ', 'B'),
      _item('马什么？', 'C'),
      _item('什么梅？', 'D'),
      _item('马东什么？', 'E'),
    ];
  }
}

class BaseFlowDelegate extends FlowDelegate {
  EdgeInsets margin;
  BaseFlowDelegate({this.margin = EdgeInsets.zero});
  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w <= context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  getSize(BoxConstraints constraints) {
    //指定Flow的大小
    return Size(double.infinity, 300);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
