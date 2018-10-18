//
//  AmapLocationObject.m
//  ocCrazy
//
//  Created by LEIPENG on 2018/9/3.
//  Copyright © 2018年 LEIPENG. All rights reserved.
//

#import "AmapLocationObject.h"

static AmapLocationObject * amapLocation = nil;
AMapLocationManager *locationManager ;
@implementation AmapLocationObject

+(void)AMapLocation{
    [AMapServices sharedServices].apiKey = APPAmapkey;
    if (amapLocation == nil) {
        amapLocation = [[AmapLocationObject alloc]init];
        locationManager = [[AMapLocationManager alloc]init];
        [amapLocation configLocationManager];
    }
}
+(void)AMapLocation:(amapLocationBlock)locationBlock city:(cityAmapFinishBolck)cityBlock{
    amapLocation.locationBlock = locationBlock;
    amapLocation.cityBlock = cityBlock;
    [locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error == nil){
            amapLocation.locationBlock(location.coordinate);
            amapLocation.cityBlock(regeocode);
        }
    }];
}
- (void)configLocationManager{
    [locationManager setPausesLocationUpdatesAutomatically:NO];
    [locationManager setAllowsBackgroundLocationUpdates:NO];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
}

@end
