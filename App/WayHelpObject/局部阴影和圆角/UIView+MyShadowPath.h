//
//  UIView+LXShadowPath.h
//  LXViewShadowPath
//
//  Created by chenergou on 2017/11/23.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum :NSInteger{
    ShadowPathLeft,
    ShadowPathRight,
    ShadowPathTop,
    ShadowPathBottom,
    ShadowPathNoTop,
    ShadowPathAllSide
} MyShadowPathSide;
@interface UIView (MyShadowPath)

/*
 * shadowColor 阴影颜色
 * shadowOpacity 阴影透明度，默认0
 * shadowRadius  阴影半径，默认3
 * shadowPathSide 设置哪一侧的阴影，
 * shadowPathWidth 阴影的宽度，
 */
-(void)SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(MyShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;

@end
