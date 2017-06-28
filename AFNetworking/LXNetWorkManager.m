//
//  LXNetWorkManager.m
//  ACFUN
//
//  Created by lx on 16/4/20.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "LXNetWorkManager.h"
@implementation LXNetWorkManager

//+(instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    static LXNetWorkManager *manager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [super allocWithZone:zone];
//    });
//    return manager;
//
//}
//
//+(instancetype)shareInstance
//{
//    return [[super alloc]init];
//}


+(void)requestWithURL:(NSString *)url
             LXGETNetWorkType:(LXGETNetWorkType)LXGETNetWorkType
                       pramas:(NSDictionary *)params
                       target:(id)target
                       action:(SEL)action
                      showHUD:(BOOL)showHUD
          currentView:(UIView *)currentView
                 successBlock:(successBlock)successBlock
                 failureBlock:(failureBlock)failureBlcok
{
    LXNetWorkHandler *hander = [LXNetWorkHandler shareInstance];
    [hander requsetWithURL:url LXGETNetWorkType:LXGETNetWorkType pramas:params target:target action:action showHUD:showHUD currentView:currentView successBlock:successBlock failureBlock:failureBlcok];
}


@end
