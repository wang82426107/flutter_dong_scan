# SDScan

#### 前言
***

flutter_dong_scan是一个可以定做UI的二维码扫描库.

参考库如下所示。安卓部分是基于 zxing-android-embedded 这个库，iOS是参考 ZFScan 改造的。

[Android部分：zxing-android-embedded](https://github.com/journeyapps/zxing-android-embedded)

[iOS部分：ZFScan](https://github.com/Zirkfied/ZFScan)


<br>

#### 简单上手
***

首先我们在 **pubspec.yaml** 文件中导入下面内容。然后再执行 **flutter pub get** 命令。

```

dependencies:
  flutter_dong_scan: ^1.0.1

```

同时,我们需要把项目中build.gradle的minSdkVersion设置为19.

```
android {
    ...
    defaultConfig {
        minSdkVersion 19
        ...
    }
}
```

然后我们需要在Android的 **AndroidManifest.xml** 和 iOS 的 **info.plist** 添加权限请求， 具体如下所示。

这里要说明一下iOS部分添加权限需要注意的问题，如果你的App想要上线AppStore,我建议你把 “该Demo想使用您的相机” 这句话改为更加详细的阐述，不然挨拒那是必然的。**UIViewControllerBasedStatusBarAppearance** 这个属性为什么要设置，这里我需要说明下，我为UI的统一把状态栏前景色改为白色，所以需要设置这个属性，可以不设置跟随整体主色走。

###### Android 部分

```
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.FLASHLIGHT" />
    <uses-permission android:name="android.permission.CAMERA" />

    <application>
        .....
    </application>

</manifest>
```

###### iOS部分

```

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>NSCameraUsageDescription</key>
	<string>该Demo想使用您的相机</string>
	<key>UIViewControllerBasedStatusBarAppearance</key>
	<false/>

    ......

</dict>
</plist>

```

上面配置完成之后，我们导入SDScan,如下所示。

```

import 'package:flutter_dong_scan/scan.dart';

```

然后我们就可以如下进行调用了。

```
      ScanConfig scanConfig = ScanConfig();
      SDScan scan = SDScan().setScanEventListener((dynamic codeString){
          print("扫描结果:" + codeString);
      });
      scan.startScan(config: scanConfig);
```