//
//  AES128.h
//  ocCrazy
//
//  Created by dukai on 16/1/12.
//  Copyright © 2016年 dukai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES128 : NSObject
//key 16 iv 16
+(NSString *)AES128Encrypt:(NSString *)plainText withKey:(NSString *)key withIV:(NSString *)iv;
+(NSString *)AES128Decrypt:(NSString *)encryptText withKey:(NSString *)key withIV:(NSString *)iv;
@end
