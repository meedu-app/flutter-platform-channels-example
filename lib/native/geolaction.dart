import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';

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
  final _event = EventChannel("app.meedu/geolocation-listener");
  StreamSubscription _subscription;
  RxString _location = "".obs;
  RxString get location => _location;

  void init() {
    _subscription = _event.receiveBroadcastStream().listen((event) {
      _location.value = "${event['lat']},${event['lng']}";
    });
  }

  dispose() {
    _subscription?.cancel();
  }

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

  Future<void> start() async {
    await _channel.invokeMethod("start");
  }

  Future<void> stop() async {
    await _channel.invokeMethod("stop");
  }

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
