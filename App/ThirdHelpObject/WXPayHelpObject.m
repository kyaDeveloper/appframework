//
//  WXPayHelpObject.m
//  App
//
//  Created by longcai on 2018/9/21.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#import "WXPayHelpObject.h"

static WXPayHelpObject *weixin = nil;
@implementation WXPayHelpObject

+(WXPayHelpObject *)weixin{
    if (weixin == nil) {
        weixin = [[WXPayHelpObject alloc]init];
        
        [WXApi registerApp:kAppID_Wechat];
    }
    return weixin;
}

+(void)weixinPay:(NSMutableDictionary *)Dic block:(weixinPayResult)result{
    if (weixin == nil) {
        weixin = [WXPayHelpObject weixin];
    }
    if (result) {
        weixin.weixinBlock = result;
    }
    [weixin sendPay_demo:Dic];
    
}
- (void)sendPay_demo:(NSMutableDictionary *)Dic{
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = [Dic objectForKey:@"appid"];
    req.partnerId           = [Dic objectForKey:@"partnerid"];
    req.prepayId            = [Dic objectForKey:@"prepayid"];
    req.nonceStr            = [Dic objectForKey:@"noncestr"];
    req.timeStamp           = [[Dic objectForKey:@"timestamp"] intValue];
    req.package             = [Dic objectForKey:@"package"];
    req.sign                = [Dic objectForKey:@"sign"];
    
    if ([WXApi isWXAppInstalled]) {
        if ([WXApi sendReq:req]) {
            NSLog(@"微信跳转成功");
        }
    }else{
        [MyToast showBottomWithText:@"没有安装微信"];
    }
}

-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                
                self.weixinBlock(YES);
                
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                
                self.weixinBlock(NO);
                
                break;
        }
    }
    
}

@end
