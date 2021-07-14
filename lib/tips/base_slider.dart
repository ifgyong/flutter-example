import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BaseSliderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BaseSliderPageState();
  static String get routeName => '/BaseSliderPage';
}

class _BaseSliderPageState extends State<BaseSliderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BaseSliderPage'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _buildItem(),
        _buildItem(),
        _buildItem(),
        _buildItem(),
        _buildItem(),
      ],
    );
  }

  Widget _buildItem() {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.indigoAccent,
            child: Text('3'),
            foregroundColor: Colors.white,
          ),
          title: Text('Tile n°3'),
          subtitle: Text('SlidableDrawerDelegate'),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => _showSnackBar('Archive'),
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => _showSnackBar('Share'),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => _showSnackBar('More'),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _showSnackBar('Delete'),
        ),
      ],
    );
  }

  void _showSnackBar(String str) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str)));
  }

  @override
  void initState() {
    super.initState();
  }
}
