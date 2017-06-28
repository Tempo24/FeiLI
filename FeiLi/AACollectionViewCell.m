//
//  AACollectionViewCell.m
//  FeiLi
//
//  Created by lx on 16/4/16.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "AACollectionViewCell.h"

@implementation AACollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-40)/2, (self.frame.size.height-40)/2, 40, 40)];
        [self.contentView addSubview:_imageView];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-100)/2, (self.frame.size.height-40)/2+40+10, 100, 20)];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_label];
    }
    
    return self;
}

@end
