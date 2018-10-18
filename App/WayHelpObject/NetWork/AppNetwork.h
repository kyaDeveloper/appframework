//
//  AppNetwork.h
//  App
//
//  Created by longcai on 2018/10/16.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"

#define isNetWorkSecret  @"YES"   //是否加密
#define security_UrlKey  @"keys"
#define security_Key  @"GHTE#gheawf32hoUIPSDAFqhka8dsaghDASGou"
#define security_iv   @"A903245ghiopeHAOWEsadfasdGKSADH"
#define requstTimeOut  30   //接口请求超时时间


@interface AppNetwork : NSObject

typedef void (^requestAppSuccess)(NSDictionary *dic,NSString *url,NSString *Json);
typedef void (^requestAppFail)(NSError *error,NSString *url);
typedef void (^Progress)(NSProgress * downloadProgress);


@property(nonatomic,strong)requestAppSuccess block_success;
@property(nonatomic,strong)requestAppFail block_fail;
@property(nonatomic,strong)Progress block_Progress;

@property(nonatomic,strong)AFHTTPSessionManager * manager;


//网络Get请求
+(void)CrazyRequest_Get:(NSString *)header HUD:(BOOL)HUD parameters:(NSDictionary *)parameters  success:(requestAppSuccess)success fail:(requestAppFail)fail;

//网络POST请求
+(void)CrazyRequest_Post:(NSString *)header HUD:(BOOL)HUD parameters:(NSDictionary *)parameters success:(requestAppSuccess)success fail:(requestAppFail)fail;

//显示挡板
+(void)AppShowHUD;

//隐藏挡板
+(void)AppHiddenHUD;

//字典加密
+(NSDictionary *)AESDictionaryEncrypt:(NSDictionary *)parameters;

//字典解密
+(NSDictionary *)AESDictionaryDecrypt:(NSString *)text;

//加密字符串
+(NSString *)AESStringEncrypt:(NSString *)text;

//解析字符串
+(NSString *)AESStringDecrypt:(NSString *)text;

@end
