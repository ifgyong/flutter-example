import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseRotationBoxPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BaseSliderPageState();
  }

  static String get routeName => '/BaseRotationBoxPage';
}

class _BaseSliderPageState extends State<BaseRotationBoxPage> {
  @override
  void initState() {
    super.initState();
  }

  int value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BaseSliderPageState'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('点击蓝色文字 看见旋转效果 \n RotatedBox会影响布局，而transform不会影响布局，只会影响绘制。'),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: RotatedBox(
                    quarterTurns: value,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text('点我旋转'),
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      value += 1;
                      value %= 4;
                      print(value);
                    });
                  },
                ),
                Text('datadatadatadata'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
