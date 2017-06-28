//
//  LXNetWorkItem.m
//  ACFUN
//
//  Created by lx on 16/4/20.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//

#import "LXNetWorkItem.h"
#import "MBProgressHUD.h"
#import "AFHTTPSessionManager.h"
@implementation LXNetWorkItem



-(LXNetWorkItem *)initWithURL:(NSString *)url
             LXGETNetWorkType:(LXGETNetWorkType)LXGETNetWorkType
                       pramas:(NSDictionary *)params
                       target:(id)target
                       action:(SEL)action
                      showHUD:(BOOL)showHUD
                  currentView:(UIView *)currentView
                 successBlock:(successBlock)successBlock
                 failureBlock:(failureBlock)failureBlcok

{
    if (self)
    {
        self.url = url;
        self.params = params;
        self.target = target;
        self.action = action;
        self.showHUD = showHUD;
    }
    
    if (LXGETNetWorkType == LXGETNetWorkTypeWithGET)
    {
        AFHTTPSessionManager *instance = [AFHTTPSessionManager manager];
        instance.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
        [instance.requestSerializer setValue:@"0" forHTTPHeaderField:@"deviceType"];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/javascript",@"application/json",@"application/xml",@"text/plain",nil];
        if (showHUD == YES) {
            [MBProgressHUD showHUDAddedTo:currentView animated:YES];
        }
        [instance GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            if (task !=nil) {
                
                if (successBlock) {
                    successBlock(responseObject);

                    [MBProgressHUD hideAllHUDsForView:currentView animated:YES];

                }
                

            }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlcok) {
                    failureBlcok(error);
//                    [MBProgressHUD hideAllHUDsForView:nil animated:YES];
            }
        }];
    }
    return self;
}






@end
