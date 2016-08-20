//
//  ViewController.m
//  自定义登录界面
//
//  Created by apple on 16/8/10.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "LoginViewController.h"
#import "LYTextField.h"
#import "LYButton.h"
#import "NextViewController.h"

@interface LoginViewController ()
@property (nonatomic, strong) LYTextField *username;
@property (nonatomic, strong) LYTextField *password;
@property (nonatomic, strong) LYButton *login;
@end

@implementation LoginViewController

-(instancetype)init{
    if(self = [super init]){
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.layer addSublayer: [self backgroundLayer]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
    
    
    // 3.监听键盘出现和隐藏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
/**
 *  移除通知
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - NSNotification
#pragma mark - 键盘操作
/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.username.transform = CGAffineTransformMakeTranslation(0, - keyboardF.size.height / 2);
        self.password.transform = CGAffineTransformMakeTranslation(0, - keyboardF.size.height/ 2);
        self.login.transform = CGAffineTransformMakeTranslation(0, - keyboardF.size.height / 2);
    }];
}
/**
 *  键盘即将退出的时候调用
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.username.transform = CGAffineTransformIdentity;
        self.password.transform = CGAffineTransformIdentity;
        self.login.transform = CGAffineTransformIdentity;
    }];
}
// 退出键盘
- (void)dismiss
{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self setUp];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}
-(void)setUp{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    titleLabel.center = CGPointMake(self.view.center.x, 150);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"CLOVER";
    titleLabel.font = [UIFont systemFontOfSize:40.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    detail.center = CGPointMake(self.view.center.x,630);
    detail.textColor = [UIColor whiteColor];
    detail.text = @"Don`t have an account yet? Sign Up";
    detail.font = [UIFont systemFontOfSize:13.f];
    detail.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:detail];
    
    LYTextField *username = [[LYTextField alloc]initWithFrame:CGRectMake(0, 0, 270, 30)];
    self.username = username;
    username.center = CGPointMake(self.view.center.x, 350);
    username.ly_placeholder = @"Username";
    username.tag = 0;
    [self.view addSubview:username];
    
    LYTextField *password = [[LYTextField alloc]initWithFrame:CGRectMake(0, 0, 270, 30)];
    self.password = password;
    password.center = CGPointMake(self.view.center.x, username.center.y+60);
    password.ly_placeholder = @"Password";
    password.tag = 1;
    [self.view addSubview:password];
    
    LYButton *login = [[LYButton alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.login = login;
    login.center = CGPointMake(self.view.center.x, password.center.y+100);
    [self.view addSubview:login];
    
    __block LYButton *button = login;
    
    login.translateBlock = ^{
        NSLog(@"跳转了哦");
        button.bounds = CGRectMake(0, 0, 44, 44);
        button.layer.cornerRadius = 22;
        
        NextViewController *nextVC = [[NextViewController alloc]init];
        [self presentViewController:nextVC animated:YES completion:nil];
    };
}


-(CAGradientLayer *)backgroundLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor purpleColor].CGColor,(__bridge id)[UIColor redColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.locations = @[@0.65,@1];
    return gradientLayer;
}

@end
