//
//  subView.h
//  FeiLi
//
//  Created by lx on 16/4/9.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface subView : UIView

@property (nonatomic,strong)UIView *sbView;
@property (nonatomic,strong)UILabel *label;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@end
