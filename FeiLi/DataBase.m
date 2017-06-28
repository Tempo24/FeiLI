//
//  DataBase.m
//  FeiLi
//
//  Created by lx on 16/4/14.
//  Copyright (c) 2016年 lx. All rights reserved.
//

#import "DataBase.h"

static DataBase *manager = nil;

@implementation DataBase

- (instancetype)init{

    
    if (self == [super init]) {
        
        //数据库路径
        NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)lastObject];
        
        NSString *filePath = [doc stringByAppendingPathComponent:@"feiLi_pingLun.sqlite"];
        NSLog(@"地址%@",filePath);
        db = [[FMDatabase alloc]initWithPath:filePath];
        BOOL result = [db open];
        if (!result) {
            NSLog(@"打开数据库失败");
            return self;
        }
        //成功就创建表
        result = [db executeUpdate:@"create table if not exists feiLi_pingLun(id integer primary key autoincrement,nickName text,pingLun text)"];
        if (!result) {
            NSLog(@"创建表失败");
            [db close];
            return self;
        }
        

    }
    
    return self;
}

+(DataBase *)shareManager{
    static dispatch_once_t once;
    //这个Block里面的代码只会被执行一次
    dispatch_once(&once, ^{
        if (manager == nil) {
            manager = [[DataBase alloc] init];
        }
        
    });
    return manager;

}

//-----增
-(void)addUser:(UserModel *)model{

    BOOL res = [db executeUpdate:@"insert into feiLi_pingLun(nickName,pingLun) values(?,?)",model.nickName,model.pingLun];
    if (!res) {
        NSLog(@"插入失败");
        return;
    }
   
}

//---删
- (void)deleteUser{

//    int idNum = 1;
//    [db executeUpdate:@"delete from feiLi_pingLun where id = ?;",@(idNum)];
    [db executeUpdateWithFormat:@"delete from feiLi_pingLun where nickName = %@;",@"cao"];
}

//---改
- (void)updataNameUser{

    [db executeUpdate:@"update feiLi_pingLun set pingLun = ? where nickName = ?",@"cccccccccccccc",@"cao"];
}

//----查
- (NSMutableArray *)getUser{

    NSMutableArray *arr = [NSMutableArray array];
    FMResultSet *set = [db executeQuery:@"select *from feiLi_pingLun"];
    while ([set next]) {
        UserModel *model = [[UserModel alloc]init];
        model.nickName = [set stringForColumn:@"nickName"];
        model.pingLun = [set stringForColumn:@"pingLun"];
        [arr addObject:model];
    }
    return arr;
 
}



@end
