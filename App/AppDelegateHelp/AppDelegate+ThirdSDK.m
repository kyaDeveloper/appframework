//
//  AppDelegate+ThirdSDK.m
//  App
//
//  Created by longcai on 2018/9/21.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#import "AppDelegate+ThirdSDK.h"
#import "WXPayHelpObject.h"

@implementation AppDelegate (ThirdSDK)

-(void)initThirdSDK{
    [MobSDKHelpObject MobShareSDK];
    [WXPayHelpObject weixin];
}


@end
