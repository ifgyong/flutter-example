import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BaseSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BaseSwitchState();
  }
}

class BaseSwitchState extends State<BaseSwitch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('弹框'),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: _body(),
      ),
    );
  }

  bool _state1 = false, _state2 = true, _s3 = true, _s4 = false;
  bool _checkList1 = false, _checkList2 = false;
  RadioC _radio1 = RadioC.unselected, _radio2 = RadioC.unselected;
  Widget _body() {
    Widget w = Column(
      children: <Widget>[
        Container(
          height: 30,
          child: Text('CupertinoSwitchState:$_state1'),
        ),
        CupertinoSwitch(
          value: _state1,
          onChanged: (v) {
            setState(() {
              _state1 = v;
            });
          },
          trackColor: Colors.orange,
          activeColor: Colors.greenAccent,
        ),
        Container(
          height: 30,
          child: Text('SwitchStates:$_state2'),
        ),
        Switch(
          value: _state2,
          onChanged: (v) {
            setState(() {
              _state2 = v;
            });
          },
        ),
        Container(
          height: 30,
          child: Text('Checkbox'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Checkbox(
              value: _s3,
              onChanged: (v) {
                setState(() {
                  _s3 = v;
                });
              },
            ),
            Checkbox(
              value: _s4,
              onChanged: (v) {
                setState(() {
                  _s4 = v;
                });
              },
            )
          ],
        ),
        CheckboxListTile(
          onChanged: (v) {
            setState(() {
              _checkList1 = v;
            });
          },
          title: Text('checkListTitle box is  leading'),
          value: _checkList1,
          controlAffinity: ListTileControlAffinity.leading,
          secondary: Icon(Icons.message),
          activeColor: Colors.orange,
          checkColor: Colors.blue,
          subtitle: Text('我是subtitle'),
          dense: true,
        ),
        CheckboxListTile(
          onChanged: (v) {
            setState(() {
              _checkList2 = v;
            });
          },
          title: Text('checkListTitle  box is trailing'),
          value: _checkList2,
          secondary: Icon(Icons.message),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        RadioListTile<RadioC>(
          title: Text('radiotitle'),
          subtitle: Text('subtitle'),
          secondary: Icon(Icons.list),
          value: RadioC.selected,
          groupValue: _radio1,
          activeColor: Colors.red,
          onChanged: (v) {
            print('$v');
            setState(() {
              _radio1 = v;
            });
          },
        ),
        RadioListTile<RadioC>(
          title: Text('radiotitle'),
          subtitle: Text('subtitle'),
          secondary: Icon(Icons.list),
          value: RadioC.unselected,
          groupValue: _radio2,
          activeColor: Colors.red,
          onChanged: (v) {
            print('$v');
            setState(() {
              _radio2 = v;
            });
          },
        ),
        LabeledRadio(
          label: 'This is the first label text',
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          value: true,
          groupValue: _isRadioSelected,
          onChanged: (bool newValue) {
            setState(() {
              _isRadioSelected = newValue;
            });
          },
        ),
        LabeledRadio(
          label: 'This is the second label text',
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          value: false,
          groupValue: _isRadioSelected,
          onChanged: (bool newValue) {
            setState(() {
              _isRadioSelected = newValue;
            });
          },
        ),
        LinkedLabelRadio(
          label: 'First tappable label text',
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          value: true,
          groupValue: _isRadioSelected2,
          onChanged: (bool newValue) {
            setState(() {
              _isRadioSelected2 = newValue;
            });
          },
        ),
        LinkedLabelRadio(
          label: 'Second tappable label text',
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          value: false,
          groupValue: _isRadioSelected2,
          onChanged: (bool newValue) {
            setState(() {
              _isRadioSelected2 = newValue;
            });
          },
        ),
      ],
    );
    return w;
  }
}

enum RadioC {
  selected,
  unselected,
  unknow,
}

class LinkedLabelRadio extends StatelessWidget {
  const LinkedLabelRadio({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              }),
          RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(
                color: Colors.blueAccent,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Label has been tapped.');
                },
            ),
          ),
        ],
      ),
    );
  }
}

bool _isRadioSelected = false;
bool _isRadioSelected2 = false;

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) onChanged(value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
