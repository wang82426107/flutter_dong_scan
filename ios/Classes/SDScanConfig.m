//
//  SDScanConfig.m
//  SDScanDemo
//
//  Created by 王巍栋 on 2020/7/1.
//  Copyright © 2020 骚栋. All rights reserved.
//

#import "SDScanConfig.h"
#import "UIColor+HexStringColor.h"

@implementation SDScanConfig

- (instancetype)init {
    
    if (self = [super init]) {
        _maskRatio = 0.68;
        _maskColor = [UIColor hexStringToColor:@"000000" alpha:0.3];
        _returnImageType = ReturnImageTypeExit;
        _titeColor = nil;
        _titleString = @"扫一扫";
        _hintString = @"将二维码放入框内，即可自动扫描";
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
