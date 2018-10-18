//
//  PrefixHeader.h
//  App
//
//  Created by longcai on 2018/8/31.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h

//全局宏
#import "UtilsMacros.h"
#import "URLMacros.h"
#import "FontAndColorMacros.h"
#import "ThirdMacros.h"
#import "CommonMacros.h"
#import "systemMacros.h"

//基础类
#import "AppDelegate.h"
#import "AppDelegate+AppService.h"
#import "AppDelegate+PushService.h"
#import "AppDelegate+StartAnimation.h"
#import "AppDelegate+ThirdSDK.h"
#import "RootViewController.h"
#import "RootNavigationController.h"
#import "MBProgressHUD+XY.h"
#import "PPNetworkHelper.h"
#import "UserManager.h"
#import "UIButton+XYButton.h"
#import "AppManager.h"
#import <SVProgressHUD.h>
#import "MyToast.h"
#import "NSObject+WHC_Model.h"
#import "UITableView+ProtocolConfigure.h"
#import "RootWebViewController.h"
#import "MyWebViewController.h"

//第三方
#import <YYKit.h>
#import <MBProgressHUD.h>
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <IQKeyboardManager.h>
#import <Bugly/Bugly.h>
#import <Appirater.h>
#import "MobSDKHelpObject.h"
#import "WXPayHelpObject.h"
#import "JPUSHService.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>


#endif /* PrefixHeader_h */
