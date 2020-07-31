import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_record_and_player/fluttersimplerecordandplayer.dart';
import 'package:path_provider/path_provider.dart';

///
/// Created by fgyong on 2020/7/30.
///

class BaseRecordRoute extends StatefulWidget {
  BaseRecordRoute({Key key}) : super(key: key);

  @override
  _BaseRecordRouteState createState() => _BaseRecordRouteState();
}

class _BaseRecordRouteState extends State<BaseRecordRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('录音测试'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[
          Text('录音需在真机上测试'),
          OutlineButton(
            child: Text('录音开始'),
            onPressed: _start,
          ),
          OutlineButton(
            child: Text('录音结束'),
            onPressed: _end,
          ),
          OutlineButton(
            child: Text('录音播放'),
            onPressed: _play,
          ),
          OutlineButton(
            child: Text('播放停止'),
            onPressed: () {
              _andPlayer.stopPlay();
            },
          ),
          Text('文件地址:$_path'),
        ],
      ),
    );
  }

  String _path = '';
  void _start() async {
    var p = await getTemporaryDirectory();
    _path = '${p.path}/mp3/${DateTime.now()}.mp3';
    _andPlayer.startRecord(null, (error) {
      print(error);
    });
  }

  void _end() {
    _andPlayer.stopRecord;
    _path = _andPlayer.recordListPath.last.toString();
    setState(() {});
    print(_andPlayer.recordListPath.last.toString());
  }

  void _play() {
    _andPlayer.play(_andPlayer.recordListPath.last, isLocal: true);
  }

  SimpleSoundRecordAndPlayer _andPlayer;
  @override
  void initState() {
    _andPlayer = SimpleSoundRecordAndPlayer();
    super.initState();
  }
}
