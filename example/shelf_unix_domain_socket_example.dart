import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_unix_domain_socket/shelf_unix_domain_socket.dart';

void main() async {
  var handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);

  var server = await File('/tmp/server.sock').bindHttpServer();
  print('listen: ${server.address}');
  shelf_io.serveRequests(server, handler);
}

Response _echoRequest(Request request) =>
    Response.ok('Request for "${request.url}"');
