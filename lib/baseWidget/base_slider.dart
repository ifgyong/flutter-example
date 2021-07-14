import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseSliderRangPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BaseSliderPageState();
  }

  static String get routeName => '/BaseSliderRangPage';
}

class _BaseSliderPageState extends State<BaseSliderRangPage> {
  double value;
  RangeValues rangeValues;
  @override
  void initState() {
    super.initState();
    value = 0.5;
    rangeValues = RangeValues(1, 10);
  }

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
            Text('拖动下方slider查看效果'),
            SizedBox(
              height: 50,
            ),
            Slider(
              value: value,
              onChanged: (v) {
                setState(() {
                  value = v;
                });
              },
              label: '$value',
              divisions: 100,
              activeColor: Colors.redAccent,
            ),
            RangeSlider(
              values: rangeValues,
              max: 100,
              min: 0,
              onChanged: (v) {
                setState(() {
                  rangeValues = v;
                });
              },
              labels: RangeLabels('${rangeValues.start}', '${rangeValues.end}'),
              divisions: 100,
              activeColor: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
