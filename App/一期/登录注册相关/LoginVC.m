//
//  LoginVC.m
//  ocCrazy
//
//  Created by longcai on 2018/8/22.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import "LoginVC.h"


@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;

@property (strong, nonatomic) NSString *Code;


@property (nonatomic)NSInteger type;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.type=1;
    self.topHeight.constant=110-20+HitoSafeAreaHeight;
    self.bottomHeight.constant=U_TabbarSafeBottomMargin;
    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.loginBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.loginBtn.bounds.size];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//    maskLayer.frame = self.loginBtn.bounds;
//    maskLayer.path = maskPath.CGPath;
//    self.loginBtn.layer.mask = maskLayer;
    
    
    self.loginBtn.layer.cornerRadius = 23.0;
    self.loginBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.loginBtn.layer.borderWidth = 0.0f;
    
    [self.nameTf setValue:[UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTf setValue:[UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
}
#pragma mark 立即登陆
- (IBAction)loginButton:(UIButton *)sender {
    [self.view endEditing:YES];
    KPostNotification(KNotificationLoginStateChange, @YES);

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

@end
