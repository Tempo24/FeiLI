//
//  TableViewCell.m
//  FeiLi
//
//  Created by lx on 16/4/9.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lable = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 30)];
        _lable.textColor = [UIColor blackColor];
        _lable.textAlignment = NSTextAlignmentLeft;
        _lable.font = [UIFont systemFontOfSize:16];
        [self addSubview:_lable];
        
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0, 5, (KscreenWidth-2*5)/2, kcellHeight-5);
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        _leftButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_leftButton];
        
        _leftButLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, (_leftButton.frame.size.height-40)/2, 60, 40)];
        [_leftButton addSubview:_leftButLabel];
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(5 +_leftButton.bounds.size.width, 5, _leftButton.bounds.size.width, kcellHeight-5);
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        _rightButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_rightButton];
        
        _rightButLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, (_rightButton.frame.size.height-40)/2, 60, 40)];
        [_rightButton addSubview:_rightButLabel];
        
        
        
    }

    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
