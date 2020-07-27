import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/24.
///

class BaseKeepStateAlive extends StatefulWidget {
  final bool keepAlive;
  BaseKeepStateAlive({Key key, this.keepAlive = false}) : super(key: key);

  @override
  _BaseKeepStateAliveState createState() => _BaseKeepStateAliveState();
}

class _BaseKeepStateAliveState extends State<BaseKeepStateAlive>
    with AutomaticKeepAliveClientMixin {
  int _index = 0;
  List<Widget> _pages;
  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    _pages = [
      BaseKeepStateAlive2(
        keepAlive: true,
      ),
      BaseKeepStateAlive2(
        keepAlive: false,
        title: '状态不保持',
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('状态保持'),
//      ),
      body: PageView.builder(
        itemBuilder: (ctx, index) {
          return _pages[index];
        },
        controller: _pageController,
//        physics: NeverScrollableScrollPhysics(),

        /// 滑动切换页面
        pageSnapping: true,
        itemCount: _pages.length,
        onPageChanged: (index) {
          setState(() {
            _index = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300),
                curve: Curves.linearToEaseOut);
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.print), title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.print), title: Text('第二页'))
        ],
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300),
                curve: Curves.linearToEaseOut);
          });
        },
      ),
    );
  }

  bool _wantAlive = false;
  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              OutlineButton(
                child: Text('保持活性'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BaseKeepStateAlive2(
                            keepAlive: true,
                          )));
                },
              ),
              OutlineButton(
                child: Text('不保持活性'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BaseKeepStateAlive2(
                            keepAlive: false,
                          )));
                },
              )
            ],
          ),
//          OutlineButton(
//            child: Text('push新页面'),
//            onPressed: () {
//              Navigator.of(context)
//                  .push(MaterialPageRoute(builder: (_) => _PageSecond()));
//            },
//          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => _wantAlive;
}

class BaseKeepStateAlive2 extends StatefulWidget {
  final bool keepAlive;
  final String title;
  BaseKeepStateAlive2({Key key, this.keepAlive = false, this.title})
      : super(key: key);

  @override
  _BaseKeepStateAliveState2 createState() => _BaseKeepStateAliveState2();
}

class _BaseKeepStateAliveState2 extends State<BaseKeepStateAlive2>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('状态保持'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        heroTag: widget.title,
        onPressed: () {
          setState(() {
            _count += 1;
          });
        },
      ),
    );
  }

  int _count = 0;
  Widget _body() {
    _count += 1;
    print('build');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.title == null ? '状态保持A' : widget.title),
          Text('${_count}'),
          OutlineButton(
            child: Text('push新页面'),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => _PageSecond()));
            },
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}

class _PageSecond extends StatefulWidget {
  _PageSecond({Key key}) : super(key: key);

  @override
  __PageSecondState createState() => __PageSecondState();
}

class __PageSecondState extends State<_PageSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: OutlineButton(
        child: Text('返回查看'),
        onPressed: () {
          Navigator.of(context).maybePop();
        },
      ),
    );
  }
}
