//
//  DetTableViewCell.m
//  FeiLi
//
//  Created by lx on 16/4/23.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "DetTableViewCell.h"

@implementation DetTableViewCell{

    BOOL isSelected;
}

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)scButtonAction:(id)sender {
    isSelected = !isSelected;
    if (isSelected) {
       
        _scImage.image = [UIImage imageNamed:@"sc-hight.jpg"];
        int num = [_scCountLabel.text intValue];
        num += 1;
        _scCountLabel.text = [NSString stringWithFormat:@"%d",num];
    }else{
        _scImage.image = [UIImage imageNamed:@"sc.jpg"];
        int num = [_scCountLabel.text intValue];
        num -= 1;
        _scCountLabel.text = [NSString stringWithFormat:@"%d",num];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
