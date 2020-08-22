import 'package:flutter/services.dart';

enum PermissionStatus {
  unknown,
  granted,
  denied,
  restricted,
}

class Geolocation {
  Geolocation._internal();
  static Geolocation _instance = Geolocation._internal();
  static Geolocation get instance => _instance;
  PermissionStatus _status = PermissionStatus.unknown;

  final _channel = MethodChannel("app.meedu/geolocation");

  Future<PermissionStatus> checkPermission() async {
    final String result = await this._channel.invokeMethod<String>('check');
    return this._getStatus(result);
  }

  Future<PermissionStatus> requestPermission() async {
    final String result = await _channel.invokeMethod<String>("request", {
      "openAppSettings": this._status == PermissionStatus.denied,
    });
    return this._getStatus(result);
  }

  start() async {}

  stop() {}

  PermissionStatus _getStatus(String result) {
    switch (result) {
      case "granted":
        this._status = PermissionStatus.granted;
        break;
      case "denied":
        this._status = PermissionStatus.denied;
        break;
      case "restricted":
        this._status = PermissionStatus.restricted;
        break;
      default:
        this._status = PermissionStatus.unknown;
    }
    return this._status;
  }
}
