//
//  AppDelegate.h
//  App
//
//  Created by longcai on 2018/9/30.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"
/*
 AppDelegate轻量化处理
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainTabBarController *mainTabBar;

@end

