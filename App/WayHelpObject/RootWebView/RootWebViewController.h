
//  RootWebViewController.h
//  App
//
//  Created by longcai on 2018/9/8.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//
//  webview 基类

#import "MyWebViewController.h"

@interface RootWebViewController : MyWebViewController

//在多级跳转后，是否在返回按钮右侧展示关闭按钮
@property(nonatomic,assign) BOOL isShowCloseBtn;

@end

