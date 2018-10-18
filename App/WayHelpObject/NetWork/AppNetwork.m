//
//  AppNetwork.m
//  App
//
//  Created by longcai on 2018/10/16.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#import "AppNetwork.h"
#import "DicNSObject.h"
#import "DES.h"


static AppNetwork * AppNetWork = nil;
@implementation AppNetwork

+(AppNetwork *)share{
    AppNetWork =[[AppNetwork alloc]init];
    return AppNetWork;
}

-(AFHTTPSessionManager *)create{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.timeoutInterval = requstTimeOut;
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    manager.securityPolicy = securityPolicy;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return manager;
}

//网络Get请求
+(void)CrazyRequest_Get:(NSString *)header HUD:(BOOL)HUD parameters:(NSDictionary *)parameters  success:(requestAppSuccess)success fail:(requestAppFail)fail{
    
    if (HUD) {
        [AppNetwork AppShowHUD];
    }
    AppNetwork *Network=[AppNetwork share];
    Network.manager=[Network create];
    Network.block_success=success;
    Network.block_fail=fail;
    
    NSDictionary *DataDic=[[NSDictionary alloc]initWithDictionary:parameters];

    if ([isNetWorkSecret isEqualToString:@"YES"]) {
        DataDic=[[NSDictionary alloc]initWithDictionary:[AppNetwork AESDictionaryEncrypt:parameters]];
    }

    [Network.manager GET:header parameters:DataDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (Network.block_Progress) {
            Network.block_Progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * json = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *requestUrl;
        
        if ([isNetWorkSecret isEqualToString:@"YES"]) {
            requestUrl = [AppNetwork requestURl:header parameters:[AppNetwork AESDictionaryEncrypt:parameters]];
            
            Network.block_success([DicNSObject deleteEmpty:[AppNetwork AESDictionaryDecrypt:json]],requestUrl,json);
        }else{
            requestUrl = [AppNetwork requestURl:header parameters:parameters];
            NSDictionary * dic = [AppNetwork crazy_JsonStringToObject:json];
            
            Network.block_success([DicNSObject deleteEmpty:dic],requestUrl,json);
        }
        [AppNetwork AppHiddenHUD];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *requestUrl = [AppNetwork requestURl:header parameters:parameters];
        if (Network.block_fail) {
            Network.block_fail(error,requestUrl);
            [AppNetwork AppHiddenHUD];
        }
    }];

}

//网络POST请求
+(void)CrazyRequest_Post:(NSString *)header HUD:(BOOL)HUD parameters:(NSDictionary *)parameters success:(requestAppSuccess)success fail:(requestAppFail)fail{
    if (HUD) {
        [AppNetwork AppShowHUD];
    }
    AppNetwork *Network=[AppNetwork share];
    Network.manager=[Network create];
    Network.block_success=success;
    Network.block_fail=fail;
    
    NSDictionary *DataDic=[[NSDictionary alloc]initWithDictionary:parameters];
    if ([isNetWorkSecret isEqualToString:@"YES"]) {
        DataDic=[[NSDictionary alloc]initWithDictionary:[AppNetwork AESDictionaryEncrypt:parameters]];
    }
    
    [Network.manager POST:header parameters:DataDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (Network.block_Progress) {
            Network.block_Progress(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * json = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *requestUrl;
        
        if ([isNetWorkSecret isEqualToString:@"YES"]) {
            requestUrl = [AppNetwork requestURl:header parameters:[AppNetwork AESDictionaryEncrypt:parameters]];
            
            Network.block_success([DicNSObject deleteEmpty:[AppNetwork AESDictionaryDecrypt:json]],requestUrl,json);
        }else{
            requestUrl = [AppNetwork requestURl:header parameters:parameters];
            NSDictionary * dic = [AppNetwork crazy_JsonStringToObject:json];
            
            Network.block_success([DicNSObject deleteEmpty:dic],requestUrl,json);
        }
        [AppNetwork AppHiddenHUD];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *requestUrl = [AppNetwork requestURl:header parameters:parameters];
        if (Network.block_fail) {
            Network.block_fail(error,requestUrl);
            [AppNetwork AppHiddenHUD];
        }
        
    }];
}

+(NSString *)requestURl:(NSString*)header parameters:(NSDictionary *)parameters{
    if (parameters.allKeys == 0 && parameters == nil) {
        return header;
    }else {
        NSMutableString *requstStr = [[NSMutableString alloc]initWithString:header];
        [requstStr appendString:@"?"];
        NSArray * keys = parameters.allKeys;
        for (int i = 0 ; i < keys.count; i++) {
            NSString *key  = keys[i];
            [requstStr appendFormat:@"%@=%@&",key,parameters[key]];
        }
        [requstStr deleteCharactersInRange:NSMakeRange(requstStr.length -1, 1)];
        return requstStr;
    }
}

//显示挡板
+(void)AppShowHUD{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
}

//隐藏挡板
+(void)AppHiddenHUD{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
//        [SVProgressHUD dismissWithDelay:1];
    });
}

//字典加密
+(NSDictionary *)AESDictionaryEncrypt:(NSDictionary *)parameters{
    NSString *json = [AppNetwork crazy_ObjectToJsonString:parameters];
    NSString *security_json = [DES DESEncrypt:json key:security_Key iv:security_iv];
    parameters = @{security_UrlKey:security_json};
    return parameters;
}
//字典解密
+(NSDictionary *)AESDictionaryDecrypt:(NSString *)text{
    NSMutableString *str = [[NSMutableString alloc]initWithString:text];
    NSString * json = [DES DESDecrypt:str key:security_Key iv:security_iv];
    return [AppNetwork crazy_JsonStringToObject:json];
}
//加密字符串
+(NSString *)AESStringEncrypt:(NSString *)text{
    return [DES DESEncrypt:text key:security_Key iv:security_iv];
}
//解析字符串
+(NSString *)AESStringDecrypt:(NSString *)text{
    NSMutableString *str = [[NSMutableString alloc]initWithString:text];
    NSString * json = [DES DESDecrypt:str key:security_Key iv:security_iv];
    return json;
}
//字典或者数组 转换成json串
+(NSString *)crazy_ObjectToJsonString:(id)object{
    if (object == nil) {
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
    
}
//json串 转换成字典或者数组
+(id)crazy_JsonStringToObject:(NSString *)JsonString{
    if (JsonString == nil) {
        return nil;
    }
    NSData *jsonData = [JsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
