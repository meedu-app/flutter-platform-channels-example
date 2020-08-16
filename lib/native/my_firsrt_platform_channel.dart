import 'package:flutter/services.dart';

class MyFirstPlatformChannel {
  final MethodChannel _methodChannel = MethodChannel(
    "app.meedu/my_first_platform_channel",
  );

  Future<void> version() async {
    try {
      // final result = await _methodChannel.invokeMethod(
      //   "version",
      //   [0, 1, 2, 3, 4, 5, 6, 7],
      // );
      final result = await _methodChannel.invokeMethod(
        "version",
        {
          "name": "Darwin",
          "lastname": "Morocho",
          "age": 27,
        },
      );
      print("🤪 $result");
    } catch (e) {
      print({"😡 error $e"});
    }
  }
}
