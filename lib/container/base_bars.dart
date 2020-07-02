import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/2.
///

class BaseBars extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<BaseBars>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;

  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        //导航栏
        title: Text("脚手架 tabbar 底部导航"),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[Text('今天'), Text('明天'), Text('后天')],
        ),
      ),
      drawer: new Drawer(
        child: _drawer(),
      ),
      //抽屉
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.home)),
            //中间位置空出
            IconButton(icon: Icon(Icons.scatter_plot)), SizedBox(),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(Icons.add),
          onPressed: _onAdd),
      resizeToAvoidBottomInset: true, //谈起键盘则页面上移
      primary: true, //是否展示在顶部东航栏高度，true占用高度，否则只是在状态栏
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Text('今天来了'),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Text('明天来了'),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Text('后天来了'),
          ),
        ],
      ),
//      extendBody: true,
//      extendBodyBehindAppBar: true,
      drawerEdgeDragWidth: 20, //手势多动偏移量 默认20px
      drawerDragStartBehavior: DragStartBehavior.start,
      drawerEnableOpenDragGesture: true, //手势拖动打开抽屉
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      // 底部导航
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(
            icon: Icon(Icons.business), title: Text('Business')),
        BottomNavigationBarItem(
            icon: Icon(Icons.school), title: Text('School')),
      ],
      currentIndex: _selectedIndex,
      fixedColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }

  int _count = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {
    setState(() {
      _count++;
    });
  }

  Widget _bd2() {
    return OutlineButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.close,
          size: 25,
        ),
        label: Text('pop '));
  }

  Widget _drawer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('点击我返回，左滑返回，点击遮罩返回'),
        _bd2(),
      ],
    );
  }
}
