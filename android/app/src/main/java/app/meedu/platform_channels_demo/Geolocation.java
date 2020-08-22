package app.meedu.platform_channels_demo;

import android.Manifest;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationManager;
import android.os.Build;
import android.os.Looper;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.google.android.gms.location.LocationServices;

import java.util.HashMap;

import io.flutter.Log;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class Geolocation implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    private Activity activity;

    private MethodChannel.Result flutterResult;
    final int REQUEST_CODE = 1204;

    private FusedLocationProviderClient fusedLocationClient;
    private EventChannel.EventSink events;


    Geolocation(Activity activity, FlutterEngine flutterEngine) {
        this.activity = activity;
        this.fusedLocationClient = LocationServices.getFusedLocationProviderClient(this.activity);
        BinaryMessenger messenger = flutterEngine.getDartExecutor().getBinaryMessenger();
        MethodChannel channel = new MethodChannel(messenger, "app.meedu/geolocation");
        EventChannel eventChannel = new EventChannel(messenger, "app.meedu/geolocation-listener");
        eventChannel.setStreamHandler(this);
        channel.setMethodCallHandler(this);
        ShimPluginRegistry registry = new ShimPluginRegistry(flutterEngine);
        PluginRegistry.Registrar registrar = registry.registrarFor("app.meedu/geolocation");
        registrar.addRequestPermissionsResultListener((requestCode, permissions, grantResults) -> {
            Log.i("LALA", "REQUEST_CODE " + requestCode);
            if (requestCode == REQUEST_CODE) {
                if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    this.flutterResult.success("granted");
                } else {
                    this.flutterResult.success("denied");
                }
                this.flutterResult = null;
            }
            return false;
        });
    }


    private LocationCallback locationCallback = new LocationCallback() {
        @Override
        public void onLocationResult(LocationResult locationResult) {
            if (locationResult != null) {
                Location location = locationResult.getLastLocation();
                if (events != null) {
                    HashMap<String, Double> data = new HashMap<>();
                    data.put("lat", location.getLatitude());
                    data.put("lng", location.getLongitude());
                    events.success(data);
                }
            }
        }
    };

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "check":
                this.check(result);
                break;
            case "request":
                this.request(result);
                break;

            case "start":
                this.start();
                result.success(null);
                break;
            case "stop":
                this.stop();
                result.success(null);
                break;
            default:
                result.notImplemented();
        }
    }


    private void check(MethodChannel.Result result) {
        int status = ContextCompat.checkSelfPermission(this.activity, Manifest.permission.ACCESS_FINE_LOCATION);
        if (status == PackageManager.PERMISSION_GRANTED) {
            result.success("granted");
        } else {
            result.success("denied");
        }
    }


    private void request(MethodChannel.Result result) {
        if (this.flutterResult != null) {
            result.error("PENDING_TASK", "You have a pending task", null);
            return;
        }

        this.flutterResult = result;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            this.activity.requestPermissions(new String[]{
                    Manifest.permission.ACCESS_FINE_LOCATION
            }, REQUEST_CODE);
        } else {
            this.flutterResult.success("granted");
            this.flutterResult = null;
        }

    }


    @SuppressLint("MissingPermission")
    private void start() {
        //
        LocationRequest locationRequest = LocationRequest.create();
        locationRequest.setInterval(10000);
        locationRequest.setFastestInterval(1000);
        locationRequest.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
        fusedLocationClient.requestLocationUpdates(locationRequest,
                locationCallback,
                Looper.getMainLooper());
    }

    public void stop() {
        fusedLocationClient.removeLocationUpdates(locationCallback);
    }


    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        this.events = events;
    }

    @Override
    public void onCancel(Object arguments) {

    }
}
