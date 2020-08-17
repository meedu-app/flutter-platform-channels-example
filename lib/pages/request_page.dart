import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:platform_channels_demo/controllers/request_controller.dart';

class RequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestController>(
      init: RequestController(),
      builder: (_) => Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Text(""),
              CupertinoButton(
                child: Text("ALLOW"),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
