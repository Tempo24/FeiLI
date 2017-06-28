//
//  MyTabBarController.m
//  FeiLi
//
//  Created by lx on 16/4/24.
//  Copyright © 2016年 lx. All rights reserved.
//

#import "MyTabBarController.h"
#import "SheZhiViewController.h"
@interface MyTabBarController (){

    
    UIImageView *imageView;//tabBar视图
    UIView *redView;//标签按钮底部标记视图
}

@end


@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tabBar.hidden = YES;//隐藏系统的标签栏
    //[self.tabBar removeFromSuperview];//移除系统的标签栏
    //self.tabBar.alpha = 0.8;
    //imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, KscreenHeight-49, KscreenWidth, 49)];
    //直接创建一个视图覆盖在系统的tabBar上，相当于隐藏tabBar
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 49)];
    imageView.backgroundColor = [UIColor grayColor];
    imageView.userInteractionEnabled = YES;
    //[self.view addSubview:imageView];
    [self.tabBar addSubview:imageView];//隐藏tabBar就等于隐藏隐藏imageView
    
    //按钮名字数组
    NSArray *nameArr = @[@"首页",@"快挑",@"发现",@"我的"];
    
    for (int i = 0; i < nameArr.count; i++) {
        //标签按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:nameArr[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(KscreenWidth/nameArr.count * i, 0, KscreenWidth/nameArr.count, 49);
        button.layer.shadowColor = [UIColor blackColor].CGColor;
        button.layer.shadowOffset = CGSizeMake(5, 5);
        button.layer.shadowOpacity = 2.0;
        [imageView addSubview:button];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        
    }
    
    //标记视图
    redView = [[UIView alloc]initWithFrame:CGRectMake(25 , 40, KscreenWidth/nameArr.count-50, 3)];
    redView.backgroundColor = [UIColor redColor];
    [imageView addSubview:redView];
    
    //创建通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeIndex) name:@"kChange" object:nil];
    
    
    
    
}

//移除通知
- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kChange" object:nil];
}
//响应通知
- (void)changeIndex{

    redView.frame = CGRectMake(25 , 40, KscreenWidth/4-50, 3);
    
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake((KscreenWidth-300)/2, (KscreenHeight-60)/2, 300, 60)];
    tempLabel.backgroundColor = [UIColor orangeColor];
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.textAlignment = NSTextAlignmentCenter;
    tempLabel.text = @"登录成功";

    CATransition *transition = [CATransition animation];
    transition.type = @"push";
    transition.subtype = @"fromTop";
    [tempLabel.layer addAnimation:transition forKey:nil];
    
    [self.view addSubview:tempLabel];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((1.5) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tempLabel removeFromSuperview];
        
    });

}

- (void)buttonAction:(UIButton *)button{
    self.selectedIndex = button.tag;
    [UIView animateWithDuration:0.3 animations:^{

        redView.frame = CGRectMake(25 + button.frame.size.width * button.tag, 40,  button.frame.size.width-50, 3);
        
    }];
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
