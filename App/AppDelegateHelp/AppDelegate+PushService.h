
#import "AppDelegate.h"
#import "JPUSHService.h"

/**
单独拿出来做推送设置和推送消息接收处理,以极光推送为例
 */
@interface AppDelegate (PushService)<JPUSHRegisterDelegate>

//极光推送初始化方法
- (void)setJPush:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
//进入后台的方法
- (void)JPushDidEnterBackground:(UIApplication *)application;
//将要进入前台的时候的方法
- (void)JPushWillEnterForeground:(UIApplication *)application;

@end
