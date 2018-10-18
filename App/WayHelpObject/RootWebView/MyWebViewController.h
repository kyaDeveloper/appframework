//
//  MyWebViewController.h
//  App
//
//  Created by longcai on 2018/9/27.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface MyWebViewController : RootViewController

@property (nonatomic,strong) WKWebView * webView;
@property (nonatomic,strong) UIProgressView * progressView;
@property (nonatomic) UIColor *progressViewColor;
@property (nonatomic,weak) WKWebViewConfiguration * webConfiguration;
@property (nonatomic, copy) NSString * url;

-(instancetype)initWithUrl:(NSString *)url;

//更新进度条
-(void)updateProgress:(double)progress;

//更新导航栏按钮，子类去实现
-(void)updateNavigationItems;


@end
