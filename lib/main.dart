import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:platform_channels_demo/native/geolaction.dart';
import 'package:platform_channels_demo/pages/home_page.dart';
import 'package:platform_channels_demo/pages/request_page.dart';
import 'package:platform_channels_demo/pages/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      onInit: () {
        Geolocation.instance.init();
      },
      onDispose: () {
        print(" Geolocation.instance.dispose();");
        Geolocation.instance.dispose();
      },
      routes: {
        'home': (_) => HomePage(),
        'request': (_) => RequestPage(),
      },
    );
  }
}
