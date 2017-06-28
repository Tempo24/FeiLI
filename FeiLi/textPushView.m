//
//  textPushView.m
//  FeiLi
//
//  Created by lx on 16/4/11.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "textPushView.h"



@implementation textPushView

- (void)viewDidLoad{

    self.view.backgroundColor = [UIColor whiteColor];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 20, KscreenWidth-60, 30)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.placeholder = @"搜索攻略";
    _textField.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _textField.delegate = self;
    [self.view addSubview:_textField];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(KscreenWidth-45, 20, 40, 30);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //弹出键盘
    [_textField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [_textField removeFromSuperview];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
