//
//  AjenDonwloadOriginalImage.m
//  AjenDonwloadOriginalImage
//
//  Created by Ajen on 2018/7/13.
//  Copyright © 2018年 Ajen. All rights reserved.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#import "AjenDonwloadOriginalImage.h"

@implementation AjenDonwloadOriginalImage


//根据文件地址,开始下载文件
-(void)downloadOriginalImageWithURLString:(NSString *)urlString{
    //默认配置
    NSURLSessionConfiguration *configuration= [NSURLSessionConfiguration defaultSessionConfiguration];
    //得到session对象
    NSURLSession* session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    // url
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    //创建任务
    NSURLSessionDownloadTask* downloadTask = [session downloadTaskWithURL:url];
    //开始任务
    [downloadTask resume];
}


//下载
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSError *saveError;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * nowTimeString = [formatter stringFromDate:[NSDate date]];
    //用当前时间给文件命名,以png为后缀下载到文件夹内
    NSString *savePath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",nowTimeString]];
    NSURL *saveUrl = [NSURL fileURLWithPath:savePath];
    [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&saveError];
    if (!saveError) {
        NSLog(@"save success");
        NSLog(@"%@",savePath);
        //下载成功之后将图片文件保存到相册
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status){
                [[PHPhotoLibrary sharedPhotoLibrary]performChanges:^{
                    [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:[NSURL fileURLWithPath:savePath]];
                    
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    if(success){
                        NSLog(@"文件下载成功");
                        //成功保存到相册后,将文件夹内刚刚下载好的文件删除
                        [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
                    }else{
                        NSLog(@"%@",error);
                    }
                    if(self.resultBlock){
                        self.resultBlock(success);
                    }
                }];
            }
        }];
    }else{
        NSLog(@"save error:%@",saveError.localizedDescription);
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
//    NSLog(@"%@",[NSString stringWithFormat:@"下载进度:%f",(double)totalBytesWritten/totalBytesExpectedToWrite]);
    if(self.progressBlock){
        self.progressBlock((double)totalBytesWritten/totalBytesExpectedToWrite);
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}
@end

#pragma clang diagnostic pop
