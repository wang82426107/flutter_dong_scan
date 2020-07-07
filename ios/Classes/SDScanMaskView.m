//
//  SDScanMaskView.m
//  SDScanDemo
//
//  Created by 王巍栋 on 2020/6/29.
//  Copyright © 2020 骚栋. All rights reserved.
//

#import "SDScanMaskView.h"
#import "SDScanHeader.h"
#import "UIView+Extension.h"
#import "UIColor+HexStringColor.h"

@interface SDScanMaskView ()

@property(nonatomic,strong)SDScanConfig *config;

@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,strong)UIButton *exitButton;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *scanLineImageView;
@property(nonatomic,strong)UIImageView *topLeftImageView;
@property(nonatomic,strong)UIImageView *topRightImageView;
@property(nonatomic,strong)UIImageView *bottomLeftImageView;
@property(nonatomic,strong)UIImageView *bottomRightImageView;
@property(nonatomic,strong)UILabel *hintLabel;

@property(nonatomic,strong)UIBezierPath *bezier;
@property(nonatomic,strong)CAShapeLayer *shapeLayer;

@end

@implementation SDScanMaskView

- (instancetype)initWithFrame:(CGRect)frame config:(SDScanConfig *)config {
    
    if (self = [super initWithFrame:frame]) {
        self.config = config;
        [self addSubview:self.maskView];
        [self addSubview:self.exitButton];
        [self addSubview:self.titleLabel];
        [self addSubview:self.topLeftImageView];
        [self addSubview:self.topRightImageView];
        [self addSubview:self.bottomLeftImageView];
        [self addSubview:self.bottomRightImageView];
        [self addSubview:self.scanLineImageView];
        [self addSubview:self.hintLabel];
        [self startScanLineAnimationAction];
    }
    return self;
}

#pragma mark - 懒加载

- (UIView *)maskView {
    
    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = _config.maskColor;
        _maskView.layer.mask = self.shapeLayer;
    }
    return _maskView;
}

- (UIBezierPath *)bezier {
    
    if (_bezier == nil) {
        _bezier = [UIBezierPath bezierPathWithRect:self.bounds];
        [_bezier appendPath:[[UIBezierPath bezierPathWithRect:CGRectMake(self.centerX - _config.maskRatio * self.width/2.0, self.centerY - _config.maskRatio * self.width/2.0, _config.maskRatio * self.width, _config.maskRatio * self.width)] bezierPathByReversingPath]];
    }
    return _bezier;
}

- (CAShapeLayer *)shapeLayer {
    
    if (_shapeLayer == nil) {
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.path = self.bezier.CGPath;
    }
    return _shapeLayer;
}

- (UIButton *)exitButton {
    
    if (_exitButton == nil) {
        _exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, StatusHeight, NavigationBarHeight, NavigationBarHeight)];
        [_exitButton addTarget:self action:@selector(exitButtonAction) forControlEvents:UIControlEventTouchUpInside];
        if (_config.returnImageType == ReturnImageTypeExit) {
            [_exitButton setImage:[UIImage imageNamed:@"sd_scan_exit_icon"] forState:UIControlStateNormal];
        } else {
            [_exitButton setImage:[UIImage imageNamed:@"sd_scan_cancle_icon"] forState:UIControlStateNormal];
        }
    }
    return _exitButton;
}

- (UILabel *)titleLabel {
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.exitButton.right, self.exitButton.top, KmainWidth - self.exitButton.width * 2, NavigationBarHeight)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = _config.titleString;
    }
    return _titleLabel;
}

- (UIImageView *)scanLineImageView {
    
    if (_scanLineImageView == nil) {
        UIImage *scanLineImage = [[UIImage imageNamed:@"sd_scan_line_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _scanLineImageView = [[UIImageView alloc] initWithImage:scanLineImage];
        _scanLineImageView.frame = CGRectMake(self.centerX - _config.maskRatio * scanLineImage.size.width/2.0, self.centerY - _config.maskRatio * self.width/2.0, scanLineImage.size.width, scanLineImage.size.height);
        _scanLineImageView.tintColor = [UIColor hexStringToColor:_config.titeColor];
    }
    return _scanLineImageView;
}

- (UIImageView *)topLeftImageView {
    
    if (_topLeftImageView == nil) {
        UIImage *topLeftImage = [[UIImage imageNamed:@"sd_scan_top_left_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _topLeftImageView = [[UIImageView alloc] initWithImage:topLeftImage];
        _topLeftImageView.frame = CGRectMake(self.centerX - _config.maskRatio * self.width/2.0, self.centerY - _config.maskRatio * self.width/2.0, topLeftImage.size.width, topLeftImage.size.height);
        _topLeftImageView.tintColor = [UIColor hexStringToColor:_config.titeColor];
    }
    return _topLeftImageView;
}

- (UIImageView *)topRightImageView {
    
    if (_topRightImageView == nil) {
        UIImage *topRightImage = [[UIImage imageNamed:@"sd_scan_top_right_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _topRightImageView = [[UIImageView alloc] initWithImage:topRightImage];
        _topRightImageView.frame = CGRectMake(self.centerX + _config.maskRatio * self.width/2.0 - topRightImage.size.width, self.centerY - _config.maskRatio * self.width/2.0, topRightImage.size.width, topRightImage.size.height);
        _topRightImageView.tintColor = [UIColor hexStringToColor:_config.titeColor];
    }
    return _topRightImageView;
}

- (UIImageView *)bottomLeftImageView {
    
    if (_bottomLeftImageView == nil) {
        UIImage *bottomLeftImage = [[UIImage imageNamed:@"sd_scan_bottom_left_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _bottomLeftImageView = [[UIImageView alloc] initWithImage:bottomLeftImage];
        _bottomLeftImageView.frame = CGRectMake(self.centerX - _config.maskRatio * self.width/2.0, self.centerY + _config.maskRatio * self.width/2.0 - bottomLeftImage.size.height, bottomLeftImage.size.width, bottomLeftImage.size.height);
        _bottomLeftImageView.tintColor = [UIColor hexStringToColor:_config.titeColor];
    }
    return _bottomLeftImageView;
}

- (UIImageView *)bottomRightImageView {
    
    if (_bottomRightImageView == nil) {
        UIImage *bottomRightImage = [[UIImage imageNamed:@"sd_scan_bottom_right_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _bottomRightImageView = [[UIImageView alloc] initWithImage:bottomRightImage];
        _bottomRightImageView.frame = CGRectMake(self.centerX + _config.maskRatio * self.width/2.0 - bottomRightImage.size.width, self.centerY + _config.maskRatio * self.width/2.0 - bottomRightImage.size.height, bottomRightImage.size.width, bottomRightImage.size.height);
        _bottomRightImageView.tintColor = [UIColor hexStringToColor:_config.titeColor];
    }
    return _bottomRightImageView;
}

- (UILabel *)hintLabel {
    
    if (_hintLabel == nil) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bottomLeftImageView.bottom + 15.0, KmainWidth, NavigationBarHeight)];
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        _hintLabel.font = [UIFont systemFontOfSize:12];
        _hintLabel.textColor = [UIColor whiteColor];
        _hintLabel.text = _config.hintString;
        CGSize hintSize = [_hintLabel sizeThatFits:CGSizeMake(KmainWidth * _config.maskRatio, 0)];
        _hintLabel.frame = CGRectMake((KmainWidth - hintSize.width)/2.0, self.bottomLeftImageView.bottom + 15.0, hintSize.width, hintSize.height);
    }
    return _hintLabel;
}

#pragma mark - 相关事件

- (void)setConfig:(SDScanConfig *)config {
    
    _config = config;
    self.titleLabel.text = config.titleString;
    self.hintLabel.text = config.hintString;
}

- (void)exitButtonAction {
    
    if (self.exitBlock != nil) {
        self.exitBlock();
    }
}

- (void)startScanLineAnimationAction {
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 3;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount = MAXFLOAT;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.centerX, self.centerY - _config.maskRatio * self.width/2.0)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.centerX, self.centerY + _config.maskRatio * self.width/2.0)];
    [self.scanLineImageView.layer addAnimation:animation forKey:nil];
}

@end
