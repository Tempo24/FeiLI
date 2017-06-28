//
//  LXNetWorkHandler.h
//  ACFUN
//
//  Created by lx on 16/4/20.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXNetWorkItem.h"



@interface LXNetWorkHandler : NSObject

@property (nonatomic,strong)LXNetWorkItem *netWorkItem;
@property (nonatomic,assign)BOOL netWorkError;

-(LXNetWorkItem *)requsetWithURL:(NSString *)url
                LXGETNetWorkType:(LXGETNetWorkType)LXGETNetWorkType
                          pramas:(NSDictionary *)params
                          target:(id)target
                          action:(SEL)action
                         showHUD:(BOOL)showHUD
                     currentView:(UIView *)currentView
                    successBlock:(successBlock)successBlock
                    failureBlock:(failureBlock)failureBlcok;

+(LXNetWorkHandler *)shareInstance;

@end
