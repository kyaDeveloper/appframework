
#import "MyToast.h"

//Toast默认停留时间
#define ToastDispalyDuration 1.2f
//Toast到顶端/底端默认距离
#define ToastSpace 100.0f
//Toast背景颜色
#define ToastBackgroundColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75]

@interface MyToast ()

@property(nonatomic,strong)UIButton *contentView;
@property(nonatomic,assign)CGFloat duration;

@end

@implementation MyToast


- (id)initWithText:(NSString *)text{
    if (self = [super init]) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
        CGRect rect=[text boundingRectWithSize:CGSizeMake(250,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,rect.size.width + 40, rect.size.height+ 20)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        self.contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
        self.contentView.layer.cornerRadius = 20.0f;
        self.contentView.backgroundColor = ToastBackgroundColor;
        [self.contentView addSubview:textLabel];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addTarget:self action:@selector(toastTaped:) forControlEvents:UIControlEventTouchDown];
        self.contentView.alpha = 0.0f;
        self.duration = ToastDispalyDuration;
    }
    return self;
}
-(void)dismissToast{
    
    [self.contentView removeFromSuperview];
}
-(void)toastTaped:(UIButton *)sender{
    
    [self hideAnimation];
}
-(void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    self.contentView.alpha = 1.0f;
    [UIView commitAnimations];
}
-(void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    self.contentView.alpha = 0.0f;
    [UIView commitAnimations];
}
+(UIWindow *)window{
    UIWindow *window =  [[[UIApplication sharedApplication] windows] lastObject];
    if(window && !window.hidden) return window;
    window = [UIApplication sharedApplication].delegate.window;
    return window;
}
- (void)showIn:(UIView *)view{
    self.contentView.center = view.center;
    [view  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}
- (void)showIn:(UIView *)view fromTopOffset:(CGFloat)top{
    self.contentView.center = CGPointMake(view.center.x, top + self.contentView.frame.size.height/2);
    [view  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}
- (void)showIn:(UIView *)view fromBottomOffset:(CGFloat)bottom{
    self.contentView.center = CGPointMake(view.center.x, view.frame.size.height-(bottom + self.contentView.frame.size.height/2));
    [view  addSubview:self.contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}
#pragma mark-中间显示
+ (void)showCenterWithText:(NSString *)text{
    [MyToast showCenterWithText:text duration:ToastDispalyDuration];
}
+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration{
    MyToast *toast = [[MyToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:[self window]];
}
#pragma mark-上方显示
+ (void)showTopWithText:(NSString *)text{
    [MyToast showTopWithText:text  topOffset:ToastSpace duration:ToastDispalyDuration];
}
+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration{
    [MyToast showTopWithText:text  topOffset:ToastSpace duration:duration];
}
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset{
    [MyToast showTopWithText:text  topOffset:topOffset duration:ToastDispalyDuration];
}
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration{
    MyToast *toast = [[MyToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:[self window] fromTopOffset:topOffset];
}
#pragma mark-下方显示
+ (void)showBottomWithText:(NSString *)text{
    [MyToast showBottomWithText:text  bottomOffset:ToastSpace duration:ToastDispalyDuration];
}
+ (void)showBottomWithText:(NSString *)text duration:(CGFloat)duration{
    [MyToast showBottomWithText:text  bottomOffset:ToastSpace duration:duration];
}
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset{
    [MyToast showBottomWithText:text  bottomOffset:bottomOffset duration:ToastDispalyDuration];
}
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration{
    MyToast *toast = [[MyToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:[self window] fromBottomOffset:bottomOffset];
}
@end

@implementation UIView (MyToast)
#pragma mark-中间显示
- (void)showMyToastCenterWithText:(NSString *)text{
    [self showMyToastCenterWithText:text duration:ToastDispalyDuration];
}
- (void)showMyToastCenterWithText:(NSString *)text duration:(CGFloat)duration{
    MyToast *toast = [[MyToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:self];
}
#pragma mark-上方显示
- (void)showMyToastTopWithText:(NSString *)text{
    [self showMyToastTopWithText:text topOffset:ToastSpace duration:ToastDispalyDuration];
}
- (void)showMyToastTopWithText:(NSString *)text duration:(CGFloat)duration{
    [self showMyToastTopWithText:text topOffset:ToastSpace duration:duration];
}
- (void)showMyToastTopWithText:(NSString *)text topOffset:(CGFloat)topOffset{
    [self showMyToastTopWithText:text topOffset:topOffset duration:ToastDispalyDuration];
}
- (void)showMyToastTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration{
    MyToast *toast = [[MyToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:self fromTopOffset:topOffset];
}
#pragma mark-下方显示
- (void)showMyToastBottomWithText:(NSString *)text{
    [self showMyToastBottomWithText:text bottomOffset:ToastSpace duration:ToastDispalyDuration];
}
- (void)showMyToastBottomWithText:(NSString *)text duration:(CGFloat)duration{
    [self showMyToastBottomWithText:text bottomOffset:ToastSpace duration:duration];
}
- (void)showMyToastBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset{
    [self showMyToastBottomWithText:text bottomOffset:bottomOffset duration:ToastDispalyDuration];
}
- (void)showMyToastBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration{
    MyToast *toast = [[MyToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showIn:self fromBottomOffset:bottomOffset];
}


@end
