//
//  AjenDonwloadOriginalImage.h
//  AjenDonwloadOriginalImage
//
//  Created by Ajen on 2018/7/13.
//  Copyright © 2018年 Ajen. All rights reserved.
//
/*
    如果用 系统提供的保存图片到相册API(UIImageWriteToSavedPhotosAlbum)的话,是对UIImage对象进行操作,图片文件会被处理,压缩.
    这里直接以纯文件形式下载到本地文件夹,第一步保证文件不被压缩,用Photos框架将下载好的图片文件放入相册内,然后删除本地文件夹内刚下载好的文件,防止占用多余储存空间
 */
#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
@interface AjenDonwloadOriginalImage : NSObject<NSURLSessionDownloadDelegate>


/**
 根据图片地址下载原图片到本地相册

 @param urlString 原图片地址
 */
-(void)downloadOriginalImageWithURLString:(NSString *_Nullable)urlString;


/**
 进度回调
 */
@property (nullable, nonatomic, copy) void (^progressBlock)(double progress);


/**
 结果回调
 */
@property (nullable, nonatomic, copy) void (^resultBlock)(BOOL isSuccess);
@end
