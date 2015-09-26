//
//  Account.h
//  WB微博
//
//  Created by 黄欣 on 15/8/13.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
/*
 access_token	string	用于调用access_token，接口获取授权后的access token。
 expires_in	string	access_token的生命周期，单位是秒数。
 remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
 uid	string	当前授权用户的UID。
 */
@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *expires_in;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong) NSDate *create_time;//access_token的创建时间

/** 用户的昵称 */
@property (nonatomic, copy) NSString *name;

+(instancetype)accountWithDict:(NSDictionary *)dict;

@end
