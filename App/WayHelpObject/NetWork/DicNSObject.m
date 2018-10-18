//
//  DicNSObject.m
//  ocCrazy
//
//  Created by longcai on 2017/12/8.
//  Copyright © 2017年 dukai. All rights reserved.
//

#import "DicNSObject.h"

@implementation DicNSObject

+(NSDictionary *)deleteEmpty:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSMutableArray *set = [[NSMutableArray alloc] init];
    NSMutableDictionary *dicSet = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *arrSet = [[NSMutableDictionary alloc] init];
    for (id obj in mdic.allKeys)
    {
        id value = mdic[obj];
        if ([value isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *changeDic = [self deleteEmpty:value];
            [dicSet setObject:changeDic forKey:obj];
        }
        else if ([value isKindOfClass:[NSArray class]])
        {
            NSArray *changeArr = [self deleteEmptyArr:value];
            [arrSet setObject:changeArr forKey:obj];
        }
        else
        {
            if ([value isKindOfClass:[NSNull class]]) {
                [set addObject:obj];
            }
        }
    }
    for (id obj in set)
    {
        mdic[obj] = @"";
    }
    for (id obj in dicSet.allKeys)
    {
        mdic[obj] = dicSet[obj];
    }
    for (id obj in arrSet.allKeys)
    {
        mdic[obj] = arrSet[obj];
    }
    
    return mdic;
}

//删除数组中的null值
+(NSArray *)deleteEmptyArr:(NSArray *)arr
{
    NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
    NSMutableArray *set = [[NSMutableArray alloc] init];
    NSMutableDictionary *dicSet = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *arrSet = [[NSMutableDictionary alloc] init];
    
    for (id obj in marr)
    {
        if ([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *changeDic = [self deleteEmpty:obj];
            NSInteger index = [marr indexOfObject:obj];
            [dicSet setObject:changeDic forKey:@(index)];
        }
        else if ([obj isKindOfClass:[NSArray class]])
        {
            NSArray *changeArr = [self deleteEmptyArr:obj];
            NSInteger index = [marr indexOfObject:obj];
            [arrSet setObject:changeArr forKey:@(index)];
        }
        else
        {
            if ([obj isKindOfClass:[NSNull class]]) {
                NSInteger index = [marr indexOfObject:obj];
                [set addObject:@(index)];
            }
        }
    }
    for (id obj in set)
    {
        marr[(int)obj] = @"";
    }
    for (id obj in dicSet.allKeys)
    {
        int index = [obj intValue];
        marr[index] = dicSet[obj];
    }
    for (id obj in arrSet.allKeys)
    {
        int index = [obj intValue];
        marr[index] = arrSet[obj];
    }
    return marr;
}


@end
