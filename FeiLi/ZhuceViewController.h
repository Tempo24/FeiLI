//
//  ZhuceViewController.h
//  FeiLi
//
//  Created by lx on 16/4/25.
//  Copyright © 2016年 lx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UITextField *psd;//第一遍密码

@property (weak, nonatomic) IBOutlet UITextField *password;//重复确认密码

@end
