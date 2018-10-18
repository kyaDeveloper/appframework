//
//  MyWebHandler.h
//  App
//
//  Created by longcai on 2018/9/27.
//  Copyright © 2018年 LongCaiJiTuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface MyWebHandler : NSObject<WKScriptMessageHandler>

@property (nonatomic,weak,readonly) UIViewController * webVC;
@property (nonatomic,strong,readonly) WKWebViewConfiguration * configuration;

-(instancetype)initWithViewController:(UIViewController *)webVC configuration:(WKWebViewConfiguration *)configuration;
-(void)cancelHandler;

@end
