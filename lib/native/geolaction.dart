import 'package:flutter/services.dart';

enum PermissionStatus {
  unknown,
  granted,
  denied,
  restricted,
}

class Geolocation {
  final _channel = MethodChannel("app.meedu/geolocation");

  checkPermission() async {}

  requestPermission() async {}

  start() async {}

  stop() {}
}
