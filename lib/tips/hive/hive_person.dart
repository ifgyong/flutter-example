import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/10/10.
///

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

@HiveType(typeId: 1)
@HiveType()
class Person extends HiveObject {
  @HiveField(0)
  String name;

  Person(this.name);
}

class PersonAdapter extends TypeAdapter<Person> {
  @override
  Person read(BinaryReader reader) {
    return Person(reader.read());
  }

  @override
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, Person obj) {
    writer.write(obj.name);
    // writer.write(obj.age);
    // writer.write(obj.friends);
  }
}
