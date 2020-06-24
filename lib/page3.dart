import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    '234'.p();
    123.p();
    this.p();

    Person p = Person();
    p
      ..age = 10
      ..age.p();
    p.p();
    ExtenPersion(p).p();
    return Scaffold(
      appBar: AppBar(
        title: Text('second'),
      ),
      body: Hero(
        tag: 'null',
        child: Container(
          height: 10,
          color: Colors.red,
          width: 20,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

extension E on String {
  void p() {
    print(this);
  }
}

extension Cateint on int {
  void p() {
    this.toString().p();
  }
}

extension ExtensionState on Page3 {
  void p() {
    this.toString().p();
  }
}

class Person {
  int age;
  void p() {
    age.p();
  }
}

extension ExtenPersion on Person {
  void p() {
    age += 1;
    age.toString()..p();
  }
}
