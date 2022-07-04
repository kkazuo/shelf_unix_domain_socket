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

import 'package:posix/posix.dart' as posix;

extension ShelfUnixDomainSocketExt on File {
  Future<HttpServer> bindHttpServer({String mode = '0666'}) async {
    final address = InternetAddress(path, type: InternetAddressType.unix);

    HttpServer server;
    try {
      server = await HttpServer.bind(address, 0);
    } on SocketException {
      if (await parent.exists()) {
        posix.unlink(path);
        server = await HttpServer.bind(address, 0);
      } else {
        await parent.create(recursive: true);
        server = await HttpServer.bind(address, 0);
      }
    }

    posix.chmod(path, mode);

    return server;
  }
}
