import 'dart:io';

import 'package:shelf_unix_domain_socket/shelf_unix_domain_socket.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final file = File('/tmp/test.socket');

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () async {
      final server = await file.bindHttpServer();
      expect(server != null, isTrue);
    });
  });
}
