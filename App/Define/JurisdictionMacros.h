//
//  JurisdictionMacros.h
//  App
//
//  Created by longcai on 2018/8/31.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#ifndef JurisdictionMacros_h
#define JurisdictionMacros_h

//获取相机权限状态
#define CameraStatus [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]
#define CameraDenied ((CameraStatus == AVAuthorizationStatusRestricted)||(CameraStatus == AVAuthorizationStatusDenied))
#define CameraAllowed (!CameraDenyed)
//定位权限
#define LocationStatus [CLLocationManager authorizationStatus];
#define LocationAllowed ([CLLocationManager locationServicesEnabled] && !((status == kCLAuthorizationStatusDenied) || (status == kCLAuthorizationStatusRestricted)))
#define LocationDenied (!LocationAllowed)
// 消息推送权限
#define PushClose (([[UIDevice currentDevice].systemVersion floatValue]>=8.0f)?(UIUserNotificationTypeNone == [[UIApplication sharedApplication] currentUserNotificationSettings].types):(UIRemoteNotificationTypeNone == [[UIApplication sharedApplication] enabledRemoteNotificationTypes]))
#define PushOpen (!PushClose)




#endif /* JurisdictionMacros_h */
