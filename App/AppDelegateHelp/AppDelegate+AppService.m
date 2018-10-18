
#import "AppDelegate+AppService.h"
#import "OpenUDID.h"
#import "LoginVC.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation AppDelegate (AppService)

#pragma mark ————— 初始化服务 —————
-(void)initService{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:KNotificationLoginStateChange object:nil];
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkStateChange:) name:KNotificationNetWorkStateChange object:nil];
}
#pragma mark ————— 初始化window —————
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    if (@available(iOS 8.0, *)) {
         [[UIButton appearance] setExclusiveTouch:YES]; //避免在一个界面上同时点击多个UIButton导致同时响应多个方法
    }
//    [[UIButton appearance] setShowsTouchWhenHighlighted:YES]; //设置按钮被点中的高亮光晕效果

//    全局统一设置方法 Appearance 方法方法实例:
    if (@available(iOS 9.0, *)){

        //让某一类控件在另一种或另一些控件中同时变现某种属性 不推荐全部使用
        //设置转圈圈颜色
         [UIActivityIndicatorView  appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = KWhiteColor;
        //设置UISearchBar里UITextField输入框的字号和圆角
        [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setFont:[UIFont systemFontOfSize:16.f]];
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].layer.cornerRadius=14.5f;
        //设置view里面的button常规状态标题颜色
        [[UIButton appearanceWhenContainedInInstancesOfClasses:@[[UIView class]]] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        //让某一类控件同时表现某种属性
//        [[UIButton appearance] setBackgroundColor:[UIColor colorWithRed:51/255.0 green:143/255.0 blue:253/255.0 alpha:1]];
//        [[UITextField appearance] setTintColor:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1]];
//        [[UILabel appearance] setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        //不接受KVO更改属性的方法
    }else{
        [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = KWhiteColor; //设置转圈圈 9.0以后作废
        [UITextField appearanceWhenContainedIn:[UISearchBar class], nil].layer.cornerRadius=14.5f;
    }
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    //设置后使用UITableview 、UICollectionView、UIScrollview的时候就不需要再单独设置该属性 因为UIView以及他的子类都是遵循UIAppearance协议的,用于适配iOS11
}
#pragma mark —————工具配置 —————
-(void)initTool{
    //键盘初始化
    IQKeyboardManager * manager  = [IQKeyboardManager sharedManager];
    manager.enable = YES ;
    manager.shouldResignOnTouchOutside = YES; //点击空白收起键盘
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES; //设置键盘上的多个“完成”那条是否显示
    /*
     局部设置取消键盘效果
     - (void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
     [IQKeyboardManager sharedManager].enable = NO;
     }
     - (void)viewWillDisappear:(BOOL)animated{
     [super viewWillDisappear:animated];
     [IQKeyboardManager sharedManager].enable = YES;
     }
     
     另外IQKeyboardManager还可以轻松实现点击Done按钮进入下一个输入框 最后一个输入框点击后收起键盘
     #import <IQKeyboardReturnKeyHandler.h>
     {
     IQKeyboardReturnKeyHandler * _returnKeyHander;
     }
     
     - (void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
     _returnKeyHander = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
     }
     - (void)viewWillDisappear:(BOOL)animated{
     [super viewWillDisappear:animated];
     }
     */
    
    //挡板初始化 自定义HUD注释忽略
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat]; //SVProgressHUDAnimationTypeFlat是圆圈的转动动作 SVProgressHUDAnimationTypeNative是 菊花型的转动动作
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    /*
     [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight]; 窗的背景块是白色，字跟圆圈是黑色
     [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark]; 窗的背景块是黑色，字跟圆圈是白色
     
     若要自定义必须先设setDefaultStyle为SVProgressHUDStyleCustom,再进行setForegroundCo lor,setBackgroundColor的配置.*/
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    /*
     SVProgressHUDMaskTypeNone : 当提示显示的时间，用户仍然可以做其他操作，比如View 上面的输入等
     SVProgressHUDMaskTypeClear : 用户不可以做其他操作
     SVProgressHUDMaskTypeBlack :　用户不可以做其他操作，并且背景色是黑色
     SVProgressHUDMaskTypeGradient : 用户不可以做其他操作，并且背景色是渐变的
     除了插件自带的几种效果，还可以自定义背景色的效果
     [SVProgressHUD setBackgroundLayerColor:[[UIColor redColor] colorWithAlphaComponent:0.4]];
     [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
     */
    
    //腾讯Bugly
    [Bugly startWithAppId:BuglyAppID]; //异常上报和运营统计
    //Appirater评分
    [self ConfigAppirater];//初始化app打分提示
}
-(void)ConfigAppirater{
    [Appirater setAppId:Appid];
    //用户安装这个应用多久之后 才是计算
    [Appirater setDaysUntilPrompt:7];
    //用户启动多少次之后 开始弹出
    [Appirater setUsesUntilPrompt:5];
    //对于特定事件处理  -1
    [Appirater setSignificantEventsUntilPrompt:-1];
    //用户没有评分的话 多久再提醒一次
    [Appirater setTimeBeforeReminding:2];
    //Debug调试，每一次都可以调出来 上线需要设置成NO
    [Appirater setDebug:NO];
    //didFinishLaunchingWithOptions 最后调的 告诉 Appirater应用启动了
    [Appirater appLaunched:YES];
    
    /*
    - (void)applicationWillEnterForeground:(UIApplication *)application {
    //applicationWillEnterForeground 最后调的 告诉 Appirater应用进入前台
    [Appirater appEnteredForeground:YES];
    }
    */
    
    [Appirater setCustomAlertTitle:@"标题提示"];
    [Appirater setCustomAlertMessage:@"中间内容"];
    [Appirater setCustomAlertCancelButtonTitle:@"不了，谢谢"];
    [Appirater setCustomAlertRateLaterButtonTitle:@"稍后再说"];
    [Appirater setCustomAlertRateButtonTitle:@"现在去"];
}
#pragma mark ————— 网络状态变化 —————
- (void)netWorkStateChange:(NSNotification *)notification{
    BOOL isNetWork = [notification.object boolValue];
    if (isNetWork) {
        //有网络
        
    }else{
        //无网络
        
    }
}
#pragma mark ————— 初始化用户系统 —————
-(void)initUserManager{
    DLog(@"设备IMEI ：%@",[OpenUDID value]);
    if([userManager loadUserInfo]){
        
    }else{
        //没有登录过，展示登录页面
        KPostNotification(KNotificationLoginStateChange, @NO)
        //        [MBProgressHUD showErrorMessage:@"需要登录"];
    }
}
#pragma mark ————— 登录状态处理 —————
- (void)loginStateChange:(NSNotification *)notification{
    BOOL loginSuccess = [notification.object boolValue];
    if (loginSuccess) {//登陆成功加载主窗口控制器
        //为避免自动登录成功刷新tabbar
        if (!self.mainTabBar || ![self.window.rootViewController isKindOfClass:[MainTabBarController class]]) {
            self.mainTabBar = [MainTabBarController new];
            
            CATransition *anima = [CATransition animation];
            anima.type = @"cube";//设置动画的类型
            anima.subtype = kCATransitionFromRight; //设置动画的方向
            anima.duration = 0.3f;
            self.window.rootViewController = self.mainTabBar;
            
            [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
        }
    }else {//登陆失败加载登陆页面控制器
        self.mainTabBar = nil;
        RootNavigationController *loginNavi =[[RootNavigationController alloc] initWithRootViewController:[LoginVC new]];
        
        CATransition *anima = [CATransition animation];
        anima.type = @"fade";//设置动画的类型
        anima.subtype = kCATransitionFromRight; //设置动画的方向
        anima.duration = 0.3f;
        self.window.rootViewController = loginNavi;
        
        [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
    }
}
#pragma mark ————— 网络状态监听 —————
- (void)monitorNetworkStatus{
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType networkStatus) {
        switch (networkStatus) {
                // 未知网络
            case PPNetworkStatusUnknown:
                DLog(@"网络环境：未知网络");
                // 无网络
            case PPNetworkStatusNotReachable:
                DLog(@"网络环境：无网络");
                KPostNotification(KNotificationNetWorkStateChange, @NO);
                break;
                // 手机网络
            case PPNetworkStatusReachableViaWWAN:
                DLog(@"网络环境：手机自带网络");
                // 无线网络
            case PPNetworkStatusReachableViaWiFi:
                DLog(@"网络环境：WiFi");
                KPostNotification(KNotificationNetWorkStateChange, @YES);
                break;
        }
    }];
}
+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
/*当前顶层控制器*/
-(UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}
-(UIViewController *)getCurrentUIVC{
    UIViewController  *superVC = [self getCurrentVC];
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
             return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
             return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}


@end

#pragma clang diagnostic pop
