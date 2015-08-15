//
//  AccountTool.h
//  WB微博
//
//  Created by 黄欣 on 15/8/13.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//  处理账号相关的所有操作 

#import <Foundation/Foundation.h>
#import "Account.h"
/**
 存储账号信息
 */

@interface AccountTool : NSObject
+ (void )saveAccount:(Account *)account;
+ (Account *)account;
@end
