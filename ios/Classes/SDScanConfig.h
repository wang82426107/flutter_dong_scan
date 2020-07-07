//
//  SDScanConfig.h
//  SDScanDemo
//
//  Created by 王巍栋 on 2020/7/1.
//  Copyright © 2020 骚栋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ReturnImageTypeExit,
    ReturnImageTypeCancle,
} ReturnImageType;

typedef void(^ScanResultBlock)(NSString *barCodeString);

@interface SDScanConfig : NSObject

// SDScanConfig 是扫描配置项

/// 扫描完成的回调
@property(nonatomic,copy)ScanResultBlock resultBlock;

/// 半透明遮罩颜色 默认为0.3透明度#000000
@property(nonatomic,strong)UIColor *maskColor;

/// 遮罩框相对比例.默认为0.68
@property(nonatomic,assign)CGFloat maskRatio;

/// 返回按钮的类型,默认为ReturnImageTypeExit
@property(nonatomic,assign)ReturnImageType returnImageType;

/// 整体主色,会影响四个边角的颜色
@property(nonatomic,copy)NSString *titeColor;

/// 标题文字,默认为扫一扫
@property(nonatomic,strong)NSString *titleString;

/// 底部提示文字,默认为将二维码放入框内，即可自动扫描
@property(nonatomic,strong)NSString *hintString;

@end
