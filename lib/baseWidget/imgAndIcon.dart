import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseImgAndIcon extends StatefulWidget {
  BaseImgAndIconState createState() => BaseImgAndIconState();
}

class BaseImgAndIconState extends State<BaseImgAndIcon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片和Icon'),
      ),
      body: Center(
        child: _body(),
      ),
    );
  }

  void _clear() {
    PaintingBinding.instance.imageCache.clear();
  }

  Widget _body() {
    return Container(
      child: CupertinoScrollbar(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                height: 30,
                child: Text('Image from disk'),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: 100,
                child: Image.asset('img/1.jpeg'),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 30,
                child: Text('Image from remote'),
              ),
            ),
            SliverToBoxAdapter(
              child: Image(
                image: NetworkImage(
                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593336370404&di=c03084a66d06c1af8995088158e907c3&imgtype=0&src=http%3A%2F%2Fdmimg.5054399.com%2Fallimg%2Fpkm%2Fpk%2F13.jpg"),
                width: 100.0,
                height: 200,
                color: Colors.greenAccent,
                colorBlendMode: BlendMode.colorBurn,
                repeat: ImageRepeat.repeat,
              ),
            ),
            // https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593338791382&di=4dfae11210313f734093208ae6ae6f1a&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F9%2F518c658448267.jpg
            SliverToBoxAdapter(
              child: Image(
                image: NetworkImage(
                    "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2053400745,529716701&fm=26&gp=0.jpg"),
                width: 100.0,
                height: 200,
//                color: Colors.red,
//                colorBlendMode: BlendMode.colorBurn,
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent loadingProgress,
                ) {
                  if (loadingProgress == null) {
                    _clear();
                    Future.delayed(Duration(seconds: 2)).then((value) {
                      return child;
                    });
                    return child;
                  }

                  return Container(
                    height: 300,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    color: Colors.red,
                    child: Image.asset(
                      'img/1.jpeg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text('fill')
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                    child: Image.asset(
                      'img/1.jpeg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Text('fitWidth')
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                    child: Image.asset(
                      'img/1.jpeg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Text('fitHeight')
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                    child: Image.asset(
                      'img/1.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text('cover')
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                    child: Image.asset(
                      'img/1.jpeg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text('contain')
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                    child: Image.asset(
                      'img/1.jpeg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Text('scaleDown')
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                    child: Image.asset(
                      'img/1.jpeg',
                      fit: BoxFit.none,
                    ),
                  ),
                  Text('none')
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Text('\uE915 \uE002 \uE900',
                  style: TextStyle(
                      fontFamily: "MaterialIcons",
                      fontSize: 24.0,
                      color: Colors.green)),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.greenAccent,
                  ),
                  Icon(
                    Icons.collections,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.extension,
                    color: Colors.orange,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      margin: EdgeInsets.all(20),
    );
  }
}
