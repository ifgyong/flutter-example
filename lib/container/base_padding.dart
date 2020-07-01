import 'package:flutter/material.dart';

class BasePadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Padding'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.black12,
            child: Padding(
              /// 设置上下左右各10像素 颜色是父级颜色

              padding: EdgeInsets.all(10),
              child: Container(
                color: Colors.red,
                child: Text('设置上下左右各10像素 颜色是父级颜色'),
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            child: Padding(
              /// 设置上下20像素 颜色是父级颜色

              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                color: Colors.blue,
                child: Text('设置上下20像素 颜色是父级颜色'),
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            child: Padding(
              /// 设置上下左右各30像素 颜色是父级颜色
              padding:
                  EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 30),
              child: Container(
                color: Colors.orange,
                child: Text('设置上下左右各30像素 颜色是父级颜色'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
