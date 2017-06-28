//
//  DataBase.h
//  FeiLi
//
//  Created by lx on 16/4/14.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB/FMDatabase.h"

#import "UserModel.h"
@interface DataBase : NSObject{


    FMDatabase *db;
}

+(DataBase *)shareManager;
-(void)addUser:(UserModel *)model;
- (NSMutableArray *)getUser;
- (void)deleteUser;
- (void)updataNameUser;

@end
