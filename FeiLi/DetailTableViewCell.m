//
//  DetailTableViewCell.m
//  FeiLi
//
//  Created by lx on 16/4/17.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell{


    NSArray *urlArr;//进入淘宝链接
}


- (void)awakeFromNib {
    urlArr = @[@"1444300010",@"1126560670",@"1324607",@"1292459",@"1464288892",@"1335959155"];
}
- (IBAction)pushTBButton:(UIButton *)button {
   
    button.tag = [_numLabel.text intValue] - 1;
    
    
    if ([_numLabel.text intValue] <= 6) {
        // 构建淘宝客户端协议的 URL
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"taobao://item.jd.com/%@.html",urlArr[button.tag]]];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            // 如果已经安装淘宝客户端，就使用客户端打开链接
            [[UIApplication sharedApplication] openURL:url];
        } else {
            // 否则使用 Mobile Safari 或者内嵌 WebView 来显示
            url=[NSURL URLWithString:[NSString stringWithFormat:@"http://item.jd.com/%@.html",urlArr[button.tag]]];
            [[UIApplication sharedApplication] openURL:url];
        }

    }else{
    
       NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://item.jd.com/1335959155.html"]];
        [[UIApplication sharedApplication] openURL:url];
        
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
