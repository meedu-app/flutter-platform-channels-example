import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_channels_demo/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) => Scaffold(
        body: Center(
          child: FlatButton(
            onPressed: () {},
            child: Text("START TRACKING"),
          ),
        ),
      ),
    );
  }
}
