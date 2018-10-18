//
//  systemMacros.h
//  App
//
//  Created by longcai on 2018/8/31.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#ifndef systemMacros_h
#define systemMacros_h

//判断是不是真机
#if TARGET_OS_IPHONE
//iPhone Device
#endif

//判断是不是模拟器
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//是否在ARC环境下
#if __has_feature(objc_arc)
//compiling with ARC
#else
//compiling without ARC
#endif

//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

//判断是否为iPhone 5(S)(E)
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f &&[[UIScreen mainScreen] bounds].size.height == 568.0f

//判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f &&[[UIScreen mainScreen] bounds].size.height == 667.0f

//判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

//判断 iOS 或更高的系统版本
#define IOS_VERSION_6_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0)? (YES):(NO))
#define IOS_VERSION_7_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)? (YES):(NO))
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)? (YES):(NO))
#define IOS_VERSION_9_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue]>=9.0)? (YES):(NO))
#define IOS_VERSION_10_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue]>=10.0)? (YES):(NO))
#define IOS_VERSION_11_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue]>=11.0)? (YES):(NO))

//判断是否是齐刘海屏
#define IsBangs_iPhone (IsiPhoneXs||IsiPhoneXr||IsiPhoneXs_Max)

#define IsiPhoneXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define IsiPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828 , 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define IsiPhoneXs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define NavigationBarHeight                 44.f
#define TabbarSafeBottomMargin              (IsBangs_iPhone ? 34.f : 0.f)
#define MoreStatusBarHeight                 (IsBangs_iPhone ? 24.f : 0.f)
#define StatusBarAndNavigationBarHeight     (IsBangs_iPhone ? 88.f : 64.f)
#define StatusBarHeight                     (IsBangs_iPhone ? 44.f : 24.f)

//系统版本工具
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//检测是否是竖屏状态
#define IsPortrait ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)

#endif /* systemMacros_h */
