// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Server to basic_writer_client.dart.
// Receives JSON encoded data in a POST request and writes it to
// the file specified in the URI.

// import 'package:mysql1/mysql1.dart';

// String _host = InternetAddress.loopbackIPv4.host;

// Future main() async {
//   var server = await HttpServer.bind(_host, 4049);
//   HttpServer.listenOn(server);
//   print('Listening on http://${server.address.address}:${server.port}/');
//   await for (var req in server) {
//     handle(req);
//   }
// }

// void handle(HttpRequest req) async {
//   final response = req.response;
//   if (uris.containsKey(req.uri.path)) {
//     uris[req.uri.path](req);
//   }
//   await response.close();
// }
//
// void getList(HttpRequest req) async {
//   final response = req.response;
//   // req.method == 'POST' &&
//   // contentType?.mimeType == 'application/json'
//
//   try {
//     var data = req.uri.queryParametersAll;
//     // data['ex'] = req.requestedUri.query;
//
//     // final content = await utf8.decoder.bind(req).join(); /*2*/
//     // final conn = await MySqlConnection.connect(ConnectionSettings(
//     //     host: '127.0.0.1',
//     //     port: 3306,
//     //     user: 'root',
//     //     db: 'testDB',
//     //     password: '12345678'));
//
//     // final ret = await conn.query('select * from user');
//     req.response
//       ..statusCode = HttpStatus.ok
//       ..write('Wrote data for ${data} ${req.requestedUri.path} .');
//   } catch (e) {
//     response
//       ..statusCode = HttpStatus.internalServerError
//       ..write('Exception during file I/O: $e.')
//       ..close();
//   }
// }
//
// typedef f = Function(HttpRequest req);
// Map<String, f> uris = {'/get': getList};
