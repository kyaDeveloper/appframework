
#import "AppDelegate.h"


#define ReplaceRootViewController(vc) [[AppDelegate shareAppDelegate] replaceRootViewController:vc]

/**
应用内业务的实现
 */
@interface AppDelegate (AppService)

//初始化服务
-(void)initService;

//初始化 window
-(void)initWindow;

//工具配置
-(void)initTool;

//初始化用户系统
-(void)initUserManager;

//监听网络状态
- (void)monitorNetworkStatus;

//单例
+ (AppDelegate *)shareAppDelegate;

/**
 当前顶层控制器
 */
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;
@end
