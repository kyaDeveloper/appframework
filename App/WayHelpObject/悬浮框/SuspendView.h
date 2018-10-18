//
//  SuspendView.h
//  App
//
//  Created by longcai on 2018/9/10.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SuspendService)(void);

@interface SuspendView : UIView
//单页悬浮框
- (instancetype)initWithFrame:(CGRect)frame mainImageName:(NSString*)name bgcolor:(UIColor *)bgcolor;

// 长按雷达辐射效果
- (instancetype)initWithFrame:(CGRect)frame mainImageName:(NSString*)name bgcolor:(UIColor *)bgcolor animationColor:animationColor AndSubview:(UIView *)VView;

// 显示（默认）
- (void)showSuspendView;

// 隐藏
- (void)dissmissSuspendView;

@property (nonatomic,copy)SuspendService callService;

@end
