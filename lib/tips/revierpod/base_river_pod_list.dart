import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RiverPodListRoute extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('list'),
      ),
      body: Center(
        child: Text('center'),
      ),
    );
  }
}
