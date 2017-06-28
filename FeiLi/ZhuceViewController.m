//
//  ZhuceViewController.m
//  FeiLi
//
//  Created by lx on 16/4/25.
//  Copyright © 2016年 lx. All rights reserved.
//

#import "ZhuceViewController.h"

@interface ZhuceViewController ()

@end

@implementation ZhuceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.psd.secureTextEntry = YES;//输入密码隐藏
    self.password.secureTextEntry = YES;
    
}


- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)finishAction:(id)sender {
    
    if (([_password.text isEqualToString:_psd.text] && _nickName.text.length != 0 && _password.text.length != 0)) {
        [self dismissViewControllerAnimated:YES completion:^{
            //发送通知
            [[NSNotificationCenter defaultCenter]postNotificationName:@"addUser" object:nil];
            
        }];
    }else{
        if (![_password.text isEqualToString:_psd.text]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您两次输入的密码不同，请重新输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"用户名或密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    }
    
    NSLog(@"%@--%@",_psd.text,_password.text);
    
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
