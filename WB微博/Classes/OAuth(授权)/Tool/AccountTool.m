//
//  AccountTool.m
//  WB微博
//
//  Created by 黄欣 on 15/8/13.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "AccountTool.h"

@implementation AccountTool
+(void)saveAccount:(Account *)account
{
   
    //沙盒路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"accont.archive"];
    //自定义对象的存储必须使用NSKeyedArchiver
    [NSKeyedArchiver archiveRootObject:account toFile:path];
}

+(Account *)account//检查授权是否过期
{
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accont.archive"]];
    
    //验证是否过期
    //获取 时间 秒
   long  long expires_in = [account.expires_in longLongValue];
    
    
    //当前时间
    NSDate *now = [NSDate date];
    //获得过期时间
    NSDate * expiresTime = [account.create_time dateByAddingTimeInterval:expires_in];
    /*
     NSOrderedAscending = -1L,生序
     NSOrderedSame,一样
     NSOrderedDescending 降序
     */
   NSComparisonResult result  = [expiresTime compare:now];
    if (result != NSOrderedDescending)//过期
    {
        return nil;
    }
    return account;
}
@end
