import 'package:flutter/material.dart';
import 'package:platform_channels_demo/native/my_firsrt_platform_channel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: () {
            MyFirstPlatformChannel _ = MyFirstPlatformChannel();
            _.version();
          },
          child: Text("GET VERSION"),
        ),
      ),
    );
  }
}
