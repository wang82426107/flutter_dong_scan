//
//  SDScanViewController.h
//  SDScanDemo
//
//  Created by 王巍栋 on 2020/6/29.
//  Copyright © 2020 骚栋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDScanConfig.h"

@interface SDScanViewController : UIViewController

// SDScanViewController 是扫描的主控制器,返回扫描二维码

- (instancetype)initWithConfig:(SDScanConfig *)scanConfig;

@end

