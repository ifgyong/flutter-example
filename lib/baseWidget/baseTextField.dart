import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseField extends StatefulWidget {
  _BaseFieldState createState() => _BaseFieldState();
}

class _BaseFieldState extends State<BaseField> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('输入框和表单'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        Text('TextField'),
        _field,
        Text(_editingController.value.text),
        SizedBox(
          height: 30,
        ),
        Text('CupertinoTextField'),
        _cupertinoTextField,
        SizedBox(
          height: 30,
        ),
        Text('Form 校验结果：${_done.toString()}'),
        _form,
      ],
    );
  }

  TextField _field;
  FocusNode _focusNode;
  FocusNode _focusNode2;

  CupertinoTextField _cupertinoTextField;
  TextEditingController _editingController;
  TextEditingController _editingController2;
  TextEditingController _editingController3;

  Form _form;
  GlobalKey<FormState> _globalKey = new GlobalKey();
  bool _done = false;
  @override
  void initState() {
    _focusNode = new FocusNode();
    _editingController = new TextEditingController()
      ..addListener(() {
        print("${_editingController.value.text}");
      });
    _field = TextField(
      focusNode: _focusNode,
      onChanged: (v) {
        setState(() {});
      },
      onSubmitted: (v) {
        _focusNode.unfocus();
      },
      controller: _editingController,
      obscureText: false, //是否是密码
      decoration: InputDecoration(hintText: '手机号', labelText: '手机号'),
      keyboardType: TextInputType.number,
    );
    _editingController2 = new TextEditingController();
    _focusNode2 = new FocusNode();
    _cupertinoTextField = CupertinoTextField(
      focusNode: _focusNode2,
      controller: _editingController2,
      placeholder: '密码',
      prefix: Icon(Icons.lock),
      textInputAction: TextInputAction.go,
      obscureText: true,
    );
    _editingController3 = new TextEditingController();
    _form = Form(
      key: _globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
                hintText: 'Enter your email', icon: Icon(Icons.mail)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
              controller: _editingController3,
              decoration: InputDecoration(
                  labelText: "密码", hintText: "您的登录密码", icon: Icon(Icons.lock)),
              obscureText: true,
              //校验密码
              validator: (v) {
                return v.trim().length > 5 ? null : "密码不能少于6位";
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_globalKey.currentState.validate()) {
                  // Process data.
                  print('校验通过');
                }
                setState(() {
                  _done = _globalKey.currentState.validate();
                });
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );

    super.initState();
  }

  void _unFocus() {
    _focusNode.focusInDirection(TraversalDirection.down);
  }
}
