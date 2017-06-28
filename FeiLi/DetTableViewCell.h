//
//  DetTableViewCell.h
//  FeiLi
//
//  Created by lx on 16/4/23.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *scImage;


@end
