//
//  DetailTableViewCell.h
//  FeiLi
//
//  Created by lx on 16/4/17.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *introContent;
//-----------------------
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *summaryContent;

@property (weak, nonatomic) IBOutlet UIImageView *subImageView;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
