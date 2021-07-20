import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class BaseIJKVideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }

  static String get routeName => '/BaseIJKVideoPage';
}

class _HomePageState extends State<BaseIJKVideoPage> {
  IjkMediaController controller = IjkMediaController();

  @override
  void initState() {
    controller = IjkMediaController();
    index = 0;
    controller.ijkStatusStream.asBroadcastStream(onListen: (ijk) {
      print('ijkStatusStream: ${ijk.toString()}');
    });
    controller.textureIdStream.asBroadcastStream(onListen: (index) {
      print('textureIdStream: $index');
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IJK video'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.store),
            onPressed: () {},
          ),
        ],
      ),
      body: buildIjkPlayer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.next_plan_outlined),
        onPressed: () async {
          await controller.setNetworkDataSource(url, autoPlay: true);
          print("set data source success");
          // controller.playOrPause();
        },
      ),
    );
  }

  int index = 0;
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

  Widget buildIjkPlayer() {
    return Center(
      child: Container(
        height: 400, // 这里随意
        child: IjkPlayer(
          mediaController: controller,
        ),
      ),
    );
  }
}
