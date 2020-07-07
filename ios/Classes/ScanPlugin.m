#import "ScanPlugin.h"
#import "SDScanViewController.h"
#import <objc/runtime.h>

@interface ScanPlugin ()

@property(nonatomic,copy)FlutterEventSink eventSink;
@property(nonatomic,strong)FlutterEventChannel *eventChannel;

@end

@implementation ScanPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  
    FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"scan"
            binaryMessenger:[registrar messenger]];
    
    ScanPlugin* instance = [[ScanPlugin alloc] init];
    
    [registrar addMethodCallDelegate:instance channel:channel];
    
    instance.eventChannel = [FlutterEventChannel eventChannelWithName:@"scan_event" binaryMessenger:[registrar messenger]];
    [instance.eventChannel setStreamHandler:instance];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {

    if ([@"startScan" isEqualToString:call.method]) {
        NSDictionary *argsDictionary = call.arguments;
        SDScanConfig *config = [[SDScanConfig alloc] init];
        config.resultBlock = ^(NSString *barCodeString) {
            if (self.eventSink != nil) {
                self.eventSink(barCodeString);
            }
        };
        [config setValuesForKeysWithDictionary:argsDictionary];
        SDScanViewController *scanViewController = [[SDScanViewController alloc] initWithConfig:config];
        scanViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:scanViewController animated:YES completion:nil];
        UIViewController *controller = [UIViewController new];
        controller.view.backgroundColor = [UIColor whiteColor];
        result(@"请求成功");
    } else {
        result(FlutterMethodNotImplemented);
    }
}

#pragma mark - 数据流交换层面

- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    
    self.eventSink = events;
    return nil;
}

- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    
    self.eventSink = nil;
    return nil;
}

@end
