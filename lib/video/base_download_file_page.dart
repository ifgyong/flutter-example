import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest01/util.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class BaseDownFilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BaseDownFilePageState();
  }

  static String get routeName => '/BaseDownFilePage';
}

class _BaseDownFilePageState extends State<BaseDownFilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BaseDownFilePage'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TextButton(
                onPressed: () {
                  setState(() {
                    downLoadFile(2);
                  });
                },
                child: Text('下载')),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: 100,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                value: value,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Text('$ret'),
          ),
        ],
      ),
    );
  }

  double value = 0;
  String ret;

  void downLoadFile(int ix) async {
    index = ix;
    value = 0;
    var p = await path();
    var last = p.path + '/$index.mp4';
    // Directory(last).create();
    File(last)..create();
    // Uri.file(last);
    // p.createTemp()
    print('path:$last');
    // final st = await Permission.storage.request();
    // Permission.mediaLibrary.request();
    // print('权限 $st');

    var response = await Dio().download(
      'http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8',
      '$last',
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
          setState(() {
            value = received / total;
          });
        }
      },
    );

    ///#EXTM3U
    // #EXT-X-VERSION:3
    // #EXT-X-MEDIA-SEQUENCE:253646
    // #EXT-X-TARGETDURATION:10
    // #EXTINF:10.000,
    // cctv1hd-1626437551000.ts
    // #EXTINF:10.000,
    // cctv1hd-1626437561000.ts
    // #EXTINF:10.000,
    // cctv1hd-1626437571000.ts
    // #EXTINF:10.000,
    // cctv1hd-1626437581000.ts
    // #EXTINF:10.000,
    // cctv1hd-1626437591000.ts
    // #EXTINF:10.000,
    // cctv1hd-1626437601000.ts

    /// https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8
    /// http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8
    response = await Dio()
        .get('https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8');
    Util.v('$response');
    setState(() {
      ret = response.data;
    });
  }

  Future<Directory> path() async {
    final p = await getTemporaryDirectory();
    return p;
  }

  int index;
  String get url {
    index += 1;

    /// https://blog.csdn.net/suwu150/article/details/90345041 m3u8资源列表
    var list = [
      'https://vd3.bdstatic.com/mda-mc2t866ix18tmrbw/sc/cae_h264_clips/1614770378/mda-mc2t866ix18tmrbw.mp4',
      // 'https://vd2.bdstatic.com/mda-mdpdktv9j7dc629c/1080p/cae_h264/1619258626/mda-mdpdktv9j7dc629c.mp4',
      'http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8',
      'http://ivi.bupt.edu.cn/hls/cctv2.m3u8',
      'http://ivi.bupt.edu.cn/hls/cctv3hd.m3u8',
      'http://ivi.bupt.edu.cn/hls/cctv4.m3u8',
      'http://ivi.bupt.edu.cn/hls/cctv5phd.m3u8',
    ];
    return list[index % (list.length)];
  }

  @override
  void initState() {
    index = 0;
    super.initState();
  }
}
