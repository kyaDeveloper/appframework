
//  Created by Yang Meyer on 03.02.12.
//  Copyright (c) 2012 compeople. All rights reserved.

#import "crazyShakeWindow.h"
#import "AppDelegate.h"
#import "CrazyGuideView.h"
crazyShakeWindow *shakeWindow;

@implementation crazyShakeWindow

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        CrazyGuideView * guide = [[CrazyGuideView alloc]init];
        [self addSubview:guide];
        [guide createLocationImageArr:@[@"TGuide1",@"TGuide2",@"TGuide3"] block:^{
            [guide removeFromSuperview];
        }];
        
    }
    return self;
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent*)event {
	if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake) {
	    
        if(shakeWindow.Shakeblock){
            shakeWindow.Shakeblock();
        }
        
	}
}

+(void)shakeBlock:(crazyShakeBlock)block{
   AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    shakeWindow = (crazyShakeWindow *)app.window;
    
    shakeWindow.Shakeblock = block;
}
+(void)removeBlock{
    if (shakeWindow.Shakeblock != nil ) {
        shakeWindow.Shakeblock = nil;
    }
}
@end
