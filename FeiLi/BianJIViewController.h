//
//  BianJIViewController.h
//  FeiLi
//
//  Created by lx on 16/4/13.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^userNameBlock)(NSString *);
typedef void (^imgNameBlock)(NSString *);
@interface BianJIViewController : UIViewController

@property (nonatomic,strong)NSString *imgName;//相册路径--》图片名
@property (nonatomic,strong)UIImage *UserImage;//用户头像image
@property (nonatomic,strong)NSString *userName;//用户昵称
@property (nonatomic,copy)userNameBlock block;
@property (nonatomic,copy)imgNameBlock block1;

@end
