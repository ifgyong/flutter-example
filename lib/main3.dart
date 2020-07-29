import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by fgyong on 2020/7/29.
///
main() async {
  var ourFirstReceivePort = new ReceivePort();

  await Isolate.spawn(echo, ourFirstReceivePort.sendPort);

  var echoPort = await ourFirstReceivePort.first;

  // if you try to use our first receive port, you’ll get this error:
  // “Bad state: Stream has already been listened to.”
  // so it seems like you always need a new port to communicate with
  // an isolate (actor).
  var ourSecondReceivePort = ReceivePort();
  echoPort.send(['message 1', ourSecondReceivePort.sendPort]);
  var msg = await ourSecondReceivePort.first;
  print('main received "$msg"');

  // instead of 'await', use 'then' as a different way of receiving
  // a reply from 'echo' (handle it asynchronously, rather than
  // waiting for the reply)
  var port3 = ReceivePort();
  echoPort.send(['message 2', port3.sendPort]);
  port3.first.then((msg) {
    print('main received "$msg"');
  });

  // use 'then' one more time
  var port4 = ReceivePort();
  echoPort.send(['port 4', port4.sendPort]);
  port4.first.then((msg) {
    print('main received "$msg"');
  });

  print('end of main');
}

echo(SendPort sendPort) async {
  var ourReceivePort = ReceivePort();

  sendPort.send(ourReceivePort.sendPort);

  await for (var msg in ourReceivePort) {
    var data = msg[0]; // the 1st element we receive should be their message
    print('echo received "$data"');
    SendPort replyToPort = msg[1]; // the 2nd element should be their port

    Future.delayed(const Duration(milliseconds: 100), () {
      replyToPort.send('echo said: ' + data);
    });

    if (data == "bye") ourReceivePort.close();
  }
}
