import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/baseWidget/baseButtons.dart';
import 'package:fluttertest01/baseWidget/baseIndicator.dart';
import 'package:fluttertest01/baseWidget/baseState.dart';
import 'package:fluttertest01/baseWidget/baseSwitch.dart';
import 'package:fluttertest01/baseWidget/baseText.dart';
import 'package:fluttertest01/baseWidget/baseTextField.dart';
import 'package:fluttertest01/baseWidget/dialog.dart';
import 'package:fluttertest01/baseWidget/imgAndIcon.dart';
import 'package:fluttertest01/comment/config.dart';
import 'package:fluttertest01/container/base_bars.dart';
import 'package:fluttertest01/container/base_container.dart';
import 'package:fluttertest01/container/base_decorateBox.dart';
import 'package:fluttertest01/container/base_clip.dart';
import 'package:fluttertest01/container/base_constraints.dart';
import 'package:fluttertest01/container/base_padding.dart';
import 'package:fluttertest01/container/base_transform.dart';
import 'package:fluttertest01/container/scrollview/baseCustomScrollview.dart';
import 'package:fluttertest01/container/scrollview/baseGridView.dart';
import 'package:fluttertest01/container/scrollview/baseListView.dart';
import 'package:fluttertest01/container/scrollview/baseListenScrollViewOffset.dart';
import 'package:fluttertest01/container/scrollview/baseSingleChildScrollView.dart';
import 'package:fluttertest01/layout/baseFlex.dart';
import 'package:fluttertest01/layout/base_align.dart';
import 'package:fluttertest01/layout/base_flow_and_wrap.dart';
import 'package:fluttertest01/layout/base_row_and_column.dart';
import 'package:fluttertest01/layout/base_stack.dart';
import 'package:fluttertest01/scroll/scrollview.dart';

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
          dividerTheme: DividerThemeData(
              color: Colors.black12,
              thickness: 0.5,
              endIndent: 25,
              indent: 35,
              space: 1)
//          fontFamily: 'Merriweather'
          ),
      home: MyHome(
        title: 'Flutter Demo Home Page',
      ),
      routes: {
        '/text': (ctx) => BaseWidgetTextPage(),
        '/btn': (ctx) => BaseButtons(),
        '/img': (ctx) => BaseImgAndIcon(),
        '/flex': (ctx) => BaseFlex(),
        '/sheet': (ctx) => BaseDialog(),
        '/sw': (ctx) => BaseSwitch(),
        '/field': (ctx) => BaseField(),
        '/in': (ctx) => BaseIndicator(),
        '/st': (ctx) => TapBox(),
        '/wheel': (ctx) => BaseScrollViewWheel(),
        '/align': (ctx) => BaseAlign(),
        '/stack': (ctx) => BaseStack(),
        '/row': (ctx) => BaseRowAndColumn(),
        '/pad': (ctx) => BasePadding(),
        '/flow': (ctx) => BaseFlowAndWrap(),
        '/box': (c) => BaseConstraints(),
        '/clip': (c) => BaseClip(),
        '/dbox': (c) => BaseDecoratedBox(),
        '/transform': (_) => BaseTransform(),
        '/contain': (_) => BaseContainer(),
        '/bars': (_) => BaseBars(),
        '/scrollview': (_) => BaseSingleChildScrollView(),
        '/list': (_) => BaseListView(),
        '/grid': (_) => BaseGridView(),
        '/cscrollview': (_) => BaseCustomScrollView(),
        '/listenoffset': (_) => BaseListenScrollView(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    Widget w = CupertinoScrollbar(
      child: CustomScrollView(
        slivers: <Widget>[
          _title('基础组件', subTile: '文本、样式、按钮、图片、Icon、单选和复选框、输入框、进度指示器', list: [
            _child(
              '文本 text 、style',
              '/text',
            ),
            _child('按钮', '/btn'),
            _child('图片和Icon', '/img'),
            _child('单选和复选', '/sw'),
            _child('输入框表单', '/field'),
            _child('进度指示器', '/in'),
            _child('弹窗', '/sheet'),
            _child('状态管理', '/st')
          ]),
          _title('布局',
              subTile:
                  '线性：Row、Column、弹性：Flex、流水布局：Wrap、Flow、层叠：Stack、Positioned',
              list: [
                _child('绝对位置stack、Positioned', '/stack'),
                _child('相对位置', '/align'),
                _child('弹性布局 Row Column', '/row'),
                _child('弹性布局 Flex', '/flex'),
                _child('流式布局 wrap flow', '/flow'),
              ]),
          _title('容器',
              subTile: 'padding、margin、尺寸、装饰、变换、脚手架、tabBar。底部导航、APPBar',
              list: [
                _child('padding', '/pad'),
                _child('container 容器', '/contain'),
                _child('尺寸限制容器', '/box'),
                _child('装饰类容器', '/dbox'),
                _child('变换transform', '/transform'),
                _child('裁剪容器', '/clip'),
                _child('导航 脚手架 Tabbar', '/bars'),
              ]),
          _title('滑动组件',
              subTile: 'SingleScrollView、List、GridView、CustomScrollView',
              list: [
                _child('SingleScrollView', '/scrollview'),
                _child('listView', '/list'),
                _child('gridView', '/grid'),
                _child('customScrollview', '/cscrollview'),
                _child('监听滚动', '/listenoffset'),
                _child('车轮list', '/wheel'),
              ]),
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
    return w;
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
      child: Card(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
      ),
    );
  }

  Widget _child(String title, String route, {bool isFirst = false}) {
    List<Widget> list = new List();

    list.add(const Divider());

    list.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: FlatButton(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: <Widget>[
                  Text(
                    title,
                    style: ThemeYo.itemTextStyle,
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black12,
                    size: 14,
                  )
                ],
              ),
              alignment: Alignment.centerLeft,
            ),
            onPressed: () {
              Navigator.pushNamed(this.context, route);
            },
          ),
        ),
      ],
    ));
    return Container(
      child: Column(
        children: list,
      ),
//      height: 25,
    );
  }
}
