import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/baseWidget/baseText.dart';
import 'package:fluttertest01/comment/config.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHome(title: 'Flutter Demo Home Page'),
      routes: {
        '/text': (ctx) => BaseWidgetTextPage(),
      },
    );
  }
}

class MyHome extends StatefulWidget {
  final String title;
  MyHome({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('home'),
        ),
        body: SafeArea(
          child: _body(),
        ),
      ),
      routes: {'/text': (ctx) => BaseWidgetTextPage()},
    );
  }

  Widget _body() {
    return CupertinoScrollbar(
      child: CustomScrollView(
        slivers: <Widget>[
          _title('基础组件', subTile: '文本、样式、按钮、图片、Icon、单选和复选框、输入框、进度指示器', list: [
            _child('文本 text 、style', '/text'),
            _child('文本 text 、style', '/text')
          ]),
          _title('布局',
              subTile:
                  '线性：Row、Column、弹性：Flex、流水布局：Wrap、Flow、层叠：Stack、Positioned'),
          _title('容器',
              subTile: 'padding、margin、尺寸、装饰、变换、脚手架、tabBar。底部导航、APPBar'),
          _title('滚动',
              subTile: '滚SingleScrollView、List、GridView、CustomScrollView'),
          _title('功能能组件', subTile: '导航返回拦截、数据共享、跨组件状态共享、颜色和主题、对话框、异步更新UI'),
          _title('时间处理和通知', subTile: '原始指针和时间、手势、全局总线、通知'),
          _title('动画', subTile: '路由动画、Hero动画、交织动画、过度组件(AnimatedSwitcher)'),
          _title(
            '自定义组件',
          ),
          _title('文件操作与网络请求',
              subTile: 'Http HttpClient Dio Http分块下载、WebSocket、Json转Model'),
        ],
      ),
    );
    return Container(
      child: Text('home'),
    );
  }

  Widget _title(String text, {List<Widget> list, String subTile = ''}) {
    list ??= [];
    if (list.length == 0) {
      list.add(Container(
        height: 0.1,
        color: Colors.black38,
      ));
    }
    return SliverToBoxAdapter(
      child: ExpansionTile(
        subtitle: Container(
          margin: EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 10),
          child: Text(
            subTile,
            style: ThemeYo.subTileTextStyle,
          ),
        ),
        title: Container(
          margin: EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 10),
          child: Text(
            text,
            style: ThemeYo.textStyle,
          ),
        ),
        children: list,
      ),
    );
  }

  Widget _child(String title, String route) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: FlatButton(
              child: Text(
                title,
                style: ThemeYo.itemTextStyle,
              ),
              onPressed: () {
                Navigator.pushNamed(this.context, route);
              },
            ),
          )
        ],
      ),
      height: 25,
    );
  }
}
