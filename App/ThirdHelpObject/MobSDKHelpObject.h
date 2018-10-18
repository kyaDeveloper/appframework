//
//  MobSDKHelpObject.h
//  App
//
//  Created by longcai on 2018/9/21.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobSDKHelpObject : NSObject

+(void)MobShareSDK;

+ (void)showMobShareSDKActionSheet:(UIView *)view AndShareWeb:(NSString *)web AndShareImage:(NSString *)imageUrl AndShareText:(NSString *)Text AndShareGoodTitle:(NSString *)GoodTitle;

typedef void (^MobSDKResult)(NSString *useruid,NSString *credential,NSString *token,NSString *nickname);

@property (strong, nonatomic) MobSDKResult MobBlock;


+ (void)QQLoginBlock:(MobSDKResult)result;

+ (void)WXLoginBlock:(MobSDKResult)result;



@end
