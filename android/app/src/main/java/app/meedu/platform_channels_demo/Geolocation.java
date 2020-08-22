package app.meedu.platform_channels_demo;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class Geolocation implements MethodChannel.MethodCallHandler {

    private Context context;

    Geolocation(Context context, BinaryMessenger messenger) {
        this.context = context;
        MethodChannel channel = new MethodChannel(messenger, "app.meedu/geolocation");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "check":
                this.check(result);
                break;
            default:
                result.notImplemented();
        }
    }


    private void check(MethodChannel.Result result) {
        int status = ContextCompat.checkSelfPermission(this.context, Manifest.permission.ACCESS_FINE_LOCATION);
        if (status == PackageManager.PERMISSION_GRANTED) {
            result.success("granted");
        } else {
            result.success("denied");
        }
    }
}
