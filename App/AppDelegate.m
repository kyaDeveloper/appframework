//
//  AppDelegate.m
//  App
//
//  Created by longcai on 2018/9/30.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#import "AppDelegate.h"
#import "MyWindow.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()

@property(nonatomic,strong)MyWindow *MyWindow;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //初始化window
    [self initWindow];
    
    //初始化app服务
    [self initService];
    
    //工具配置
    [self initTool];
    
    //初始化用户系统
    [self initUserManager];
    
    //网络监听
    [self monitorNetworkStatus];
    
    //极光推送通知注册
    [self setJPush:application didFinishLaunchingWithOptions:launchOptions];
    
    //启动动画
    [self initStartAnimation];
    
    //三方初始化
    [self initThirdSDK];
    
    return YES;
}
#pragma mark 程序失去焦点
- (void)applicationWillResignActive:(UIApplication *)application {
}
#pragma mark 程序进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self JPushDidEnterBackground:application];
}
#pragma mark 程序从后台回到前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self JPushWillEnterForeground:application];
}
#pragma mark 程序获取焦点
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
#pragma mark 程序即将退出
- (void)applicationWillTerminate:(UIApplication *)application {
}
#pragma mark 程序内存警告，可能要终止程序
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
}
//9.0以前
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    if ([url.host isEqualToString:@"safepay"]) {
//        // 支付跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//        }];
//
//    }else if ([url.absoluteString hasPrefix:[NSString stringWithFormat:@"%@",kAppID_Wechat]]){
//        return [WXApi handleOpenURL:url delegate:[WXPayHelpObject weixin]];
//    }
//    return YES;
//}
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    if ([url.absoluteString hasPrefix:[NSString stringWithFormat:@"%@",kAppID_Wechat]]){
//        //微信回调
//        return [WXApi handleOpenURL:url delegate:[WXPayHelpObject weixin]];
//    }
//    return  YES;
//}

// NOTE: 9.0以后使用新API接口 只用一个
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }else if ([url.absoluteString hasPrefix:[NSString stringWithFormat:@"%@",kAppID_Wechat]]){
        return [WXApi handleOpenURL:url delegate:[WXPayHelpObject weixin]];
    }
    return YES;
}





@end
