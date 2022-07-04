<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Extension library for Shelf to supports unix domain socket.

## Features

You can listen your handler on a unix domain socket.

## Getting started

```shell
dart pub add shelf_unix_domain_socket
```

## Usage

```dart
var server = await File('/tmp/server.sock').bindHttpServer();
shelf_io.serveRequests(server, handler);
```

## Additional information

You can use only on Linux/macOS.
