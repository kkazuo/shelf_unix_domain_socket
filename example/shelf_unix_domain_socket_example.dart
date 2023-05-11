// Copyright (c) 2022 Koga Kazuo
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_unix_domain_socket/shelf_unix_domain_socket.dart';

void main() async {
  final handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);

  final server = await File('/tmp/server.sock').bindHttpServer();
  print('listen: ${server.address}');
  shelf_io.serveRequests(server, handler);
}

Response _echoRequest(Request request) =>
    Response.ok('Request for "${request.url}"');
