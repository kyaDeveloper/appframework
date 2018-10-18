//
//  DicNSObject.h
//  ocCrazy
//
//  Created by longcai on 2017/12/8.
//  Copyright © 2017年 dukai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DicNSObject : NSObject

//自定义的数据处理 <null>和null变@“” 很棒，暂时没有发现错误
+(NSDictionary *)deleteEmpty:(NSDictionary *)dic;

+(NSArray *)deleteEmptyArr:(NSArray *)arr;
@end
