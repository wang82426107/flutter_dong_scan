import 'dart:async';

import 'package:flutter/services.dart';


typedef ScanEventListener = dynamic Function(dynamic codeString);

class SDScan {


  StreamSubscription<dynamic> _eventSubscription;

  static const MethodChannel _channel = const MethodChannel('scan');

  ScanEventListener scanEventListener;

  SDScan() {
    initEvent();
  }

  SDScan setScanEventListener(ScanEventListener scanEventListener) {
    this.scanEventListener = scanEventListener;
    initEvent();
    return this;
  }

  void initEvent() {
    _eventSubscription = _eventChannelFor().receiveBroadcastStream().listen(scanEventListener,onError: scanErrorListener);
  }

  EventChannel _eventChannelFor() {
    return EventChannel('scan_event');
  }

  void scanErrorListener(Object object) {}

  Future<String> startScan({ScanConfig config}) async {
    ScanConfig scanConfig;
    if (config != null) {
      scanConfig = config;
    }
    final String codeString = await _channel.invokeMethod('startScan', <String, dynamic>{
      "maskColorAlpha": scanConfig.maskColorAlpha,
      "maskRatio": scanConfig.maskRatio,
      "returnStyle": scanConfig.returnStyle,
      "titeColor": scanConfig.titeColor,
      "title": scanConfig.title,
      "hintString": scanConfig.hintString,
    });
    return codeString;
  }
}

class ScanConfig {
  /*遮罩的透明度,默认为0.3'*/
  final double maskColorAlpha;

  /*遮罩框相对比例.默认为宽度的0.68 */
  final double maskRatio;

  /*返回按钮的样式,ReturnStyleExit(值为0) ReturnStyleCancle(值为1)*/
  final int returnStyle;

  /*四个角的主色,默认为'#4bde2b'*/
  final String titeColor;

  /*标题文字,默认为扫一扫*/
  final String title;

  /*底部提示文字,默认为将二维码放入框内，即可自动扫描*/
  final String hintString;

  ScanConfig({
    this.maskColorAlpha = 0.3,
    this.maskRatio = 0.68,
    this.returnStyle = 0,
    this.titeColor = '#4bde2b',
    this.title = '扫一扫',
    this.hintString = '将二维码放入框内，即可自动扫描',
  });
}
