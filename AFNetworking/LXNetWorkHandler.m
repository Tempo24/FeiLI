//
//  LXNetWorkHandler.m
//  ACFUN
//
//  Created by lx on 16/4/20.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "LXNetWorkHandler.h"

@implementation LXNetWorkHandler


+(LXNetWorkHandler *)shareInstance
{
    static LXNetWorkHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[LXNetWorkHandler alloc]init];
    });
    return handler;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.netWorkError = NO;
    }
    return self;
}

-(LXNetWorkItem *)requsetWithURL:(NSString *)url
             LXGETNetWorkType:(LXGETNetWorkType)LXGETNetWorkType
                       pramas:(NSDictionary *)params
                       target:(id)target
                       action:(SEL)action
                      showHUD:(BOOL)showHUD
                     currentView:(UIView *)currentView
                 successBlock:(successBlock)successBlock
                 failureBlock:(failureBlock)failureBlcok
{
    
//    self.netWorkItem = [[LXNetWorkItem alloc]initWithURL:url LXGETNetWorkType:LXGETNetWorkType pramas:params target:target action:action showHUD:showHUD successBlock:successBlock failureBlock:failureBlcok];
    self.netWorkItem = [[LXNetWorkItem alloc]initWithURL:url LXGETNetWorkType:LXGETNetWorkType pramas:params target:target action:action showHUD:showHUD currentView:currentView successBlock:successBlock failureBlock:failureBlcok];

    if (self.netWorkError == YES) {
        NSLog(@"请求失败");
    }
    
    return self.netWorkItem;
    
}



@end
