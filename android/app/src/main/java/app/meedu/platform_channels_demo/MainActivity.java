package app.meedu.platform_channels_demo;

import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.HashMap;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        BinaryMessenger messenger = flutterEngine.getDartExecutor().getBinaryMessenger();
        MethodChannel methodChannel = new MethodChannel(messenger, "app.meedu/my_first_platform_channel");
        methodChannel.setMethodCallHandler((MethodCall call, MethodChannel.Result result) -> {
            if (call.method.equals("version")) {
//                int number = (int) call.arguments;
//                Log.i("FLUTTER:::",""+number);
//                ArrayList<Integer> numbers = (ArrayList<Integer>) call.arguments;
//                for (int item : numbers) {
//                    Log.i("FLUTTER::: item",""+item);
//                }
                String name = call.argument("name");
                String lastname = call.argument("lastname");
                int age = call.argument("age");
                Log.i("FLUTTER::: name", name);
                Log.i("FLUTTER::: lastname", lastname);
                Log.i("FLUTTER::: age", age + "");

                String version = getAndroidVersion();
                result.success(version);
            } else {
                result.notImplemented();
            }
        });
    }


    String getAndroidVersion() {
        int sdkVersion = Build.VERSION.SDK_INT;
        String release = Build.VERSION.RELEASE;
        return "Android version: " + sdkVersion + " (" + release + ")";
    }
}
