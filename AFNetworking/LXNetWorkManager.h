//
//  LXNetWorkManager.h
//  ACFUN
//
//  Created by lx on 16/4/20.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//
#ifdef DEBUG
#   define DTLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#else
#   define DTLog(...)
#endif
#import <Foundation/Foundation.h>
#import "LXNetWorkHandler.h"

@interface LXNetWorkManager : NSObject

+(void)requestWithURL:(NSString *)url
     LXGETNetWorkType:(LXGETNetWorkType)LXGETNetWorkType
               pramas:(NSDictionary *)params
               target:(id)target
               action:(SEL)action
              showHUD:(BOOL)showHUD
          currentView:(UIView *)currentView
         successBlock:(successBlock)successBlock
         failureBlock:(failureBlock)failureBlcok;


@end
