//
//  LXNetWorkItem.h
//  ACFUN
//
//  Created by lx on 16/4/20.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//
typedef void(^successBlock)(id respondeData);
typedef void(^failureBlock)(NSError *netError);
typedef NS_ENUM(NSUInteger, LXGETNetWorkType) {
    LXGETNetWorkTypeWithGET,
    LXGETNetWorkTypeWithPOST
};
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LXNetWorkItem : NSObject
@property (nonatomic,copy)NSString *url;//url
@property (nonatomic,strong)NSDictionary *params;
@property (nonatomic,strong)id target;
@property (nonatomic,assign)SEL action;
@property (nonatomic,assign)BOOL showHUD;

-(LXNetWorkItem *)initWithURL:(NSString *)url
             LXGETNetWorkType:(LXGETNetWorkType)LXGETNetWorkType
                       pramas:(NSDictionary *)params
                       target:(id)target
                       action:(SEL)action
                      showHUD:(BOOL)showHUD
                  currentView:(UIView *)currentView
                 successBlock:(successBlock)successBlock
                 failureBlock:(failureBlock)failureBlcok;

@end
