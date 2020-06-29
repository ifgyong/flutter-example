import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseFlex extends StatefulWidget {
  /// FractionallySizedBox 按照父容器的大小的 比例展示子组件
  ///
  BaseFlexState createState() => BaseFlexState();
}

class BaseFlexState extends State<BaseFlex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('弹性布局'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 0.4,
          child: Container(
            color: Colors.red,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.5,
              child: Container(
                color: Colors.greenAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*"page-copyright"
* "page-copyright": {
                  "description": "modified at 2020-06-28 10:11:00",
                  "signature": "兜兜转转还是你",
                  "wisdom": "Designer, Frontend Developer & overall web enthusiast",
                  "format": "YYYY-MM-dd hh:mm:ss",
                  "copyright": "Copyright &#169; fgyong",
                  "timeColor": "#666",
                  "copyrightColor": "#666",
                  "utcOffset": "8",
                  "style": "normal",
                  "noPowered": false,
                }
* */
