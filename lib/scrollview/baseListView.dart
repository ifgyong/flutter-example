import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/2.
///

class BaseListView extends StatefulWidget {
  @override
  _BaseListViewState createState() => _BaseListViewState();
}

class _BaseListViewState extends State<BaseListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView '),
      ),
      body: _body4(),
    );
  }

  Widget _body() {
    List<Widget> list = new List();
    for (int i = 0; i < 5; i++) {
      list.add(Card(
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Text('$i'),
        ),
      ));
    }
    return ListView(
      itemExtent: 5,
      shrinkWrap: false,
      addAutomaticKeepAlives: true,
      children: list,
      addSemanticIndexes: true,
      cacheExtent: 50,
    );
  }

  Widget _body2() {
    return ListView.builder(
      itemExtent: 80,
      itemBuilder: _buildCell,
    );
  }

  Widget _body3() {
    return ListView.separated(
      itemBuilder: _buildCell,
      separatorBuilder: _buildSeparatedCell,
      itemCount: list.length,
    );
  }

  Widget _body4() {
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.orange])),
          child: Text('我是头部信息，可以自定义的'),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: _buildCell,
            separatorBuilder: _buildSeparatedCell,
            itemCount: list.length,
          ),
        )
      ],
    );
  }

  Widget _buildCell(ctx, int index) {
    if (index < list.length - 1) {
      return Container(
        height: 80,
        alignment: Alignment.center,
        child: TestContainer(
          title: list[index],
        ),
      );
    } else if (list.length >= 5) {
      return Container(
        alignment: Alignment.center,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Icon(Icons.done), Text('没有更多数据了')],
        ),
      );
    } else {
      _getMoreData(); //加载数据
      return Container(
        alignment: Alignment.center,
        child: RefreshProgressIndicator(),
      );
    }
  }

  Widget _buildSeparatedCell(ctx, int index) {
    return Divider(
      height: 2,
      thickness: 0.5,
      indent: 10,
      endIndent: 10,
      color: index % 2 == 0 ? Colors.blue : Colors.orange,
    );
  }

  List<String> list;
  @override
  void initState() {
    list = new List();
    _getMoreData();
    super.initState();
  }

  void _getMoreData() async {
    await Future.delayed(Duration(milliseconds: 2000));
    for (int i = 0; i < 5; i++) {
      list.add(DateTime.now().toString());
    }
    setState(() {});
  }
}

class TestContainer extends StatefulWidget {
  final String title;
  TestContainer({Key key, this.title}) : super(key: key);
  @override
  _TestContainerState createState() => _TestContainerState();
}

class _TestContainerState extends State<TestContainer> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Container(
      child: Text(widget.title ?? '123'),
    );
  }

  @override
  void dispose() {
    print(widget.title + ' dispose');
    super.dispose();
  }
}
