import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_dong_scan/scan.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              ScanConfig scanConfig = ScanConfig();
              SDScan scan = SDScan().setScanEventListener((dynamic codeString){
                print("扫描结果:" + codeString);
              });
              scan.startScan(config: scanConfig);
            },
            child: Text("点击跳转"),
          ),
        ),
      ),
    );
  }
}
