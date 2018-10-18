//
//  AmapLocationObject.h
//  ocCrazy
//
//  Created by LEIPENG on 2018/9/3.
//  Copyright © 2018年 LEIPENG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

////https://lbs.amap.com/api/ios-sdk/guide/create-project/manual-configuration
typedef void (^amapLocationBlock)(CLLocationCoordinate2D Coordinate2D);
typedef void (^cityAmapFinishBolck)(AMapLocationReGeocode* regeocode);

@interface AmapLocationObject : NSObject<AMapLocationManagerDelegate>

@property(nonatomic,strong)amapLocationBlock locationBlock;
@property(nonatomic,strong)cityAmapFinishBolck cityBlock;

+(void)AMapLocation;
+(void)AMapLocation:(amapLocationBlock)locationBlock city:(cityAmapFinishBolck)cityBlock;

@end
