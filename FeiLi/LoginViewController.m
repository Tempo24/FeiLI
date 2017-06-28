//
//  LoginViewController.m
//  FeiLi
//
//  Created by lx on 16/4/24.
//  Copyright © 2016年 lx. All rights reserved.
//

#import "LoginViewController.h"
#import "ZhuceViewController.h"
@interface LoginViewController ()<UIAlertViewDelegate>{
    UILabel *tempLabel;
    UITextField *textField;
    UITextField *textField2;
    ZhuceViewController *vc;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((KscreenWidth-70)/2,50 , 70, 70)];
    imgView.backgroundColor = [UIColor grayColor];
    imgView.layer.cornerRadius = 35.0;
    imgView.clipsToBounds = YES;
    [self.view addSubview:imgView];
    
    textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 150, KscreenWidth, 40)];
    textField.placeholder = @"请输入账号";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:textField];
    
    textField2 = [[UITextField alloc]initWithFrame:CGRectMake(0, 200, KscreenWidth, 40)];
    textField2.placeholder = @"请输入密码";
    textField2.secureTextEntry = YES;//隐藏密码
    textField2.borderStyle = UITextBorderStyleRoundedRect;
    textField2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:textField2];
    
    UIButton *LoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    LoginButton.frame = CGRectMake(20, 260, KscreenWidth-40, 40);
    LoginButton.backgroundColor = [UIColor blueColor];
    [LoginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:LoginButton];
    [LoginButton addTarget:self action:@selector(LoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 330, 100, 20);
    [button setTitle:@"无法登录？" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(KscreenWidth-80, 330, 80, 20);
    [button2 setTitle:@"新用户" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addUserAction) name:@"addUser" object:nil];
    
}
//移除通知
- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"addUser" object:nil];
}
//通知响应事件
- (void)addUserAction{
    
    [self _transition];
    
    tempLabel.text = @"注册成功，请登录";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((1.5) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tempLabel removeFromSuperview];
        
    });
}

//弹出动画视图
- (void)_transition{

    tempLabel = [[UILabel alloc]initWithFrame:CGRectMake((KscreenWidth-300)/2, (KscreenHeight-60)/2, 300, 60)];
    tempLabel.backgroundColor = [UIColor orangeColor];
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tempLabel];
    CATransition *transition = [CATransition animation];
    transition.type = @"push";
    transition.subtype = @"fromTop";
    [tempLabel.layer addAnimation:transition forKey:nil];
    
}

//点击登录按钮
- (void)LoginAction:(UIButton *)button{
    
    if (([textField2.text  isEqual: KpassWord] && [textField.text isEqualToString:KuserName]) || ([textField.text isEqualToString:vc.nickName.text] && [textField2.text isEqualToString:vc.password.text]))
    {
        
        [self dismissViewControllerAnimated:YES completion:nil];
       
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kChange" object:nil];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"密码或账号错误，请重新输入。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
       
    }
    
    
}

- (void)buttonAction{

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"想要密码或账号？可以找操留煌索取" delegate:self cancelButtonTitle:@"不要了" otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        
        [self _transition];
        tempLabel.text = @"开玩笑啦😊，账号：clh，密码：9909";
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((5) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tempLabel removeFromSuperview];
            
        });

    }else{
        return;
    }
}

- (void)buttonClick{
    
     vc = [[[NSBundle mainBundle]loadNibNamed:@"ZhuceVC" owner:self options:nil]lastObject];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
