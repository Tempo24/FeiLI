//
//  WentiViewController.m
//  FeiLi
//
//  Created by lx on 16/4/12.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "WentiViewController.h"
#import "UserModel.h"
#import "DataBase.h"
@interface WentiViewController ()<UITextViewDelegate,UIAlertViewDelegate>{

    UILabel *label;
    UITextView *_textView;
    UIButton *button;
}

@end

@implementation WentiViewController


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"问题反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 75, KscreenWidth-20, 150)];
      _textView.layer.borderColor = [UIColor orangeColor].CGColor;
    _textView.layer.borderWidth = 1.0;
    _textView.delegate = self;
    [self.view addSubview:_textView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(_textView.frame.size.width-60, _textView.frame.size.height+44, 60, 30)];
    label.text = @"0/1000";
    label.textColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [button addTarget:self action:@selector(ClickAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //弹出键盘
    [_textView  becomeFirstResponder];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [_textView removeFromSuperview];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *temp = [_textView.text stringByReplacingCharactersInRange:range withString:text];
    label.text = [NSString stringWithFormat:@"%ld/1000",(unsigned long)temp.length];
    
    return YES;
}

- (void)ClickAction{
    
    if (_textView.text.length <= 10) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"评论内容不能少于10个汉字或字母" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定提交？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
    [self.view endEditing:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        return;
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提交成功" message:@"感谢您的反馈，我们将不断努力改善，谢谢！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        //保存数据到关于非礼页面。。。。
        UserModel *model = [[UserModel alloc]init];
        model.nickName = @"cao";
        model.pingLun = _textView.text;
        [[DataBase shareManager] addUser:model];
    }
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
