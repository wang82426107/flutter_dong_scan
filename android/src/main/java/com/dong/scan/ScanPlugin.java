package com.dong.scan;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;
import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import android.app.Activity;
import android.content.IntentFilter;

import com.google.zxing.integration.android.IntentIntegrator;
import com.journeyapps.barcodescanner.BarcodeResult;
import com.journeyapps.barcodescanner.CaptureActivity;

import java.util.HashMap;
import java.util.Map;

/**
 * ScanPlugin
 */
public class ScanPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, SDResultCallBack {

//  private static PluginRegistry.Registrar registrar;

    private static FlutterPluginBinding flutterPluginBinding;

    private static Activity activity;

    private static final int REQUEST_CODE_SCAN = 0x0000;

    private EventChannel.EventSink eventSink = null;

    private  EventChannel.StreamHandler streamHandler = new EventChannel.StreamHandler() {
        @Override
        public void onListen(Object arguments, EventChannel.EventSink events) {
            eventSink = events;
        }

        @Override
        public void onCancel(Object arguments) {
            eventSink = null;
        }
    };


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "scan");
        channel.setMethodCallHandler(this);//修改此处为this
        if (flutterPluginBinding.getApplicationContext() != null) {
            ScanPlugin.flutterPluginBinding = flutterPluginBinding;
        }
        EventChannel eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(),"scan_event");
        eventChannel.setStreamHandler(streamHandler);
    }

    @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {

    }

    public static void registerWith(Registrar registrar) {

        final MethodChannel channel = new MethodChannel(registrar.messenger(), "scan");
        channel.setMethodCallHandler(new ScanPlugin());
    }

    public static final String action = "dong.scan.result.action";

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("startScan")) {
            ScanConfig config = new ScanConfig();
            config.maskColor = call.argument("maskColor");
            config.maskRatio = call.argument("maskRatio");
            config.returnStyle = call.argument("returnStyle");
            config.titeColor = call.argument("titeColor");
            config.title = call.argument("title");
            config.hintString = call.argument("hintString");
            ResultDataManager.getInstance().callBack = this;

            new SDIntentIntegrator(ScanPlugin.activity)
                    .setScanConfig(config)
                    .setCaptureActivity(SDScanAvtivity.class)
                    .setPrompt(config.hintString)// 设置提示语
                    .setCameraId(0)// 选择摄像头,可使用前置或者后置
                    .setBeepEnabled(false)// 是否开启声音,扫完码之后会"哔"的一声
                    .setBarcodeImageEnabled(false)// 扫完码之后生成二维码的图片
                    .initiateScan();// 开始扫描
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void returnResultCallBackAction(BarcodeResult rawResult) {
        if (eventSink != null) {
             eventSink.success(rawResult.toString());
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }
}


class ResultDataManager {

    private static ResultDataManager instance;//恶汉模式，直接先实例化

    public BarcodeResult barcodeResult;

    public SDResultCallBack callBack;

    private ResultDataManager() {

    }

    public void setBarcodeResult(BarcodeResult barcodeResult) {
        this.barcodeResult = barcodeResult;
        if (callBack != null) {
            callBack.returnResultCallBackAction(barcodeResult);
        }
    }

    public static synchronized ResultDataManager getInstance(){//同步控制,避免多线程的状况多创建了实例对象
        if (instance == null){
            instance = new ResultDataManager();//在需要的时候在创建
        }
        return instance;
    }
}

interface SDResultCallBack {

    public void returnResultCallBackAction(BarcodeResult rawResult);
}
