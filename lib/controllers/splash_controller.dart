import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:platform_channels_demo/native/geolaction.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    this._init();
  }

  Future<void> _init() async {
    await Future.delayed(Duration(seconds: 2));
    final PermissionStatus status =
        await Geolocation.instance.checkPermission();

    if (status == PermissionStatus.granted) {
      // go to home
      Get.offNamed('home');
    } else {
      // go to request
      Get.offNamed('request');
    }
  }
}
