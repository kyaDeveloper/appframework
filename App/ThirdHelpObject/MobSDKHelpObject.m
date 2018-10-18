//
//  MobSDKHelpObject.m
//  App
//
//  Created by longcai on 2018/9/21.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#import "MobSDKHelpObject.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//微信SDK头文件
#import "WXApi.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//新浪微博SDK头文件
#import "WeiboSDK.h"

@implementation MobSDKHelpObject

+(void)MobShareSDK{
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeQQ)]
                             onImport:^(SSDKPlatformType platformType) {
                                 
                                 switch (platformType)
                                 {
                                     case SSDKPlatformTypeWechat:
                                         [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                                         break;
                                     case SSDKPlatformTypeQQ:
                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                         break;
                                     case SSDKPlatformTypeSinaWeibo:
                                         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                         break;
                                     default:
                                         break;
                                 }
                                 
                             }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                          
                          switch (platformType)
                          {
                              case SSDKPlatformTypeWechat:
                                  [appInfo SSDKSetupWeChatByAppId:@"" appSecret:@""];
                                  break;
                              case SSDKPlatformTypeQQ:
                                  [appInfo SSDKSetupQQByAppId:@"" appKey:@"" authType:SSDKAuthTypeBoth];
                                  break;
                              case SSDKPlatformTypeSinaWeibo:
                                  [appInfo SSDKSetupSinaWeiboByAppKey:@"" appSecret:@"" redirectUri:@"" authType:SSDKAuthTypeBoth];
                                  break;
                              default:
                                  break;
                          }
                      }];
}

+ (void)showMobShareSDKActionSheet:(UIView *)view AndShareWeb:(NSString *)web AndShareImage:(NSString *)imageUrl AndShareText:(NSString *)Text AndShareGoodTitle:(NSString *)GoodTitle{
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"分享-1.png"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    //    if (imageArray) {
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:GoodTitle
                                     images:imageArray
                                        url:[NSURL URLWithString:web]
                                      title:Text
                                       type:SSDKContentTypeAuto];
    //有的平台要客户端分享需要加此方法，例如微博
    [shareParams SSDKEnableUseClientShare];
    //2、分享（可以弹出我们的分享菜单和编辑界面）

    
    [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
               }
      ];
}
//QQ登录
+ (void)QQLoginBlock:(MobSDKResult)result{
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess){
            NSLog(@"uid=%@",user.uid);
            NSLog(@"%@",user.credential);
            NSLog(@"token=%@",user.credential.token);
            NSLog(@"nickname=%@",user.nickname);
            
            if (result) {
                MobSDKHelpObject *MobSDKHelp=[[MobSDKHelpObject alloc]init];
                if (result) {
                    MobSDKHelp.MobBlock = result;
                }
            }
            
        }else{
            NSLog(@"%@",error);
        }
    }];
}
//微信登录
+ (void)WXLoginBlock:(MobSDKResult)result{
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess){
            NSLog(@"uid=%@",user.uid);
            NSLog(@"%@",user.credential);
            NSLog(@"token=%@",user.credential.token);
            NSLog(@"nickname=%@",user.nickname);
            
            if (result) {
                MobSDKHelpObject *MobSDKHelp=[[MobSDKHelpObject alloc]init];
                if (result) {
                    MobSDKHelp.MobBlock = result;
                }
            }
            
        }else{
            NSLog(@"%@",error);
        }
    }];
}

@end

#pragma clang diagnostic pop
