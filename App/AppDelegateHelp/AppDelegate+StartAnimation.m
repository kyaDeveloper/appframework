//
//  AppDelegate+StartAnimation.m
//  App
//
//  Created by longcai on 2018/9/21.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#import "AppDelegate+StartAnimation.h"
#import "XHLaunchAd.h"
#import "XHLaunchAdConfiguration.h"
#import "RootWebViewController.h"
#import "DHGuidePageHUD.h"


@implementation AppDelegate (StartAnimation)

-(void)initStartAnimation{
    
    //设置启动广告页
    [self StartLaunchPage];
    
    //设置引导页
    [self StartGuidePage];
    
}
-(void)StartGuidePage{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
        // 静态引导页
//        [self setStaticGuidePage];
        
        // 动态引导页
         [self setDynamicGuidePage];
        
        // 视频引导页
//         [self setVideoGuidePage];
    }
}
#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"guideImage1.jpg",@"guideImage2.jpg",@"guideImage3.jpg",@"guideImage4.jpg",@"guideImage5.jpg"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.window.rootViewController.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
    guidePage.slideInto = YES;
    [self.window.rootViewController.view addSubview:guidePage];
}
#pragma mark - 设置APP动态图片引导页
- (void)setDynamicGuidePage {
    NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.window.rootViewController.view.frame imageNameArray:imageNameArray buttonIsHidden:YES];
    guidePage.slideInto = YES;
    [self.window.rootViewController.view addSubview:guidePage];
}
#pragma mark - 设置APP视频引导页
- (void)setVideoGuidePage {
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guideMovie1" ofType:@"mov"]];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.window.rootViewController.view.bounds videoURL:videoURL];
    [self.window.rootViewController.view addSubview:guidePage];
}


-(void)StartLaunchPage{
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 4;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"宅品惠送启动页.gif";
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = YES;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"广告点击";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFlipFromLeft;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = YES;
    //设置要添加的子视图(可选)
    //imageAdconfiguration.subViews = [self launchAdSubViews];
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}
// 广告点击
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    NSLog(@"广告点击事件");
    
    RootNavigationController *loginNavi =[[RootNavigationController alloc] initWithRootViewController:[[RootWebViewController alloc] initWithUrl:@"http://www.baidu.com"]];
    
    [kRootViewController presentViewController:loginNavi animated:YES completion:nil];
}

// 图片本地读取/或下载完成回调
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image imageData:(NSData *)imageData{
    NSLog(@"2");
}
// video本地读取/或下载完成回调
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadFinish:(NSURL *)pathURL{
    NSLog(@"3");
}
// 视频下载进度回调
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadProgress:(float)progress total:(unsigned long long)total current:(unsigned long long)current{
    NSLog(@"4");
}
// 倒计时回调
-(void)xhLaunchAd:(XHLaunchAd *)launchAd customSkipView:(UIView *)customSkipView duration:(NSInteger)duration{
    NSLog(@"5");
}
// 广告显示完成
-(void)xhLaunchAdShowFinish:(XHLaunchAd *)launchAd{
    NSLog(@"6");
}
@end
