//
//  SecondAACollectionViewCell.m
//  FeiLi
//
//  Created by lx on 16/4/16.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "SecondAACollectionViewCell.h"

@implementation SecondAACollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-100)/2, 40, 100, 30)];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_label];
    }
    
    return self;
    
}




@end
