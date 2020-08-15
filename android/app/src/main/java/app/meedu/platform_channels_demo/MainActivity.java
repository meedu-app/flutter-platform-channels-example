package app.meedu.platform_channels_demo;

import android.os.Build;

import androidx.annotation.NonNull;

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
