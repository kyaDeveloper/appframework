//
//  DES.h
//  ocCrazy
//
//  Created by dukai on 16/1/25.
//  Copyright © 2016年 dukai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES : NSObject
//key 24 iv 8
+ (NSString*)DESEncrypt:(NSString*)plainText key:(NSString*)key iv:(NSString *)iv;
+ (NSString*)DESDecrypt:(NSString*)plainText key:(NSString*)key iv:(NSString *)iv;
@end
