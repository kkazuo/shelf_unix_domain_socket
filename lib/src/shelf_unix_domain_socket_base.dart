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
