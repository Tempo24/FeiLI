//
//  MyDataModel.h
//  FeiLi
//
//  Created by lx on 16/4/9.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDataModel : NSObject{

    NSMutableArray *_array;// 每组的数据
    BOOL _isShow;// 组的状态，yes显示组，no不显示组
    NSString *_name;// 组名
    
   
}

@property (nonatomic,retain) NSMutableArray *array;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,assign) BOOL isShow;

@end
