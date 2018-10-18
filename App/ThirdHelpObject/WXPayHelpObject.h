//
//  WXPayHelpObject.h
//  App
//
//  Created by longcai on 2018/9/21.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WXApiObject.h"

@interface WXPayHelpObject : NSObject<WXApiDelegate>

typedef void (^weixinPayResult)(BOOL payRet);

@property (strong, nonatomic) weixinPayResult weixinBlock;

+(WXPayHelpObject *)weixin;
+(void)weixinPay:(NSMutableDictionary *)Dic block:(weixinPayResult)result;


@end
