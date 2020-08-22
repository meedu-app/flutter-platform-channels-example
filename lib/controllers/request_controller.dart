import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:platform_channels_demo/native/geolaction.dart';

class RequestController extends GetxController {
  Future<void> request() async {
    final PermissionStatus status =
        await Geolocation.instance.requestPermission();
    if (status == PermissionStatus.granted) {
      Get.offNamed('home');
    }
  }
}
