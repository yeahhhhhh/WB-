//
//  Account.m
//  WB微博
//
//  Created by 黄欣 on 15/8/13.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "Account.h"

@implementation Account
+(instancetype)accountWithDict:(NSDictionary *)dict//字典转模型
{
    
    Account * account = [[self alloc]init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    
    //（accessToken产生时间）存入create_time
    account.create_time = [NSDate date];
    
    return account;
}
-(void)encodeWithCoder:(NSCoder *)enCoder//归档
{//一个对象要归档进沙盒的时候调用这个方法 说明在这个对象中有哪些属性要存入沙盒中
    [enCoder encodeObject:self.access_token forKey:@"access_token"];
    [enCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [enCoder encodeObject:self.uid forKey:@"uid"];
    [enCoder encodeObject:self.create_time forKey:@"create_time"];
    [enCoder encodeObject:self.name forKey:@"name"];
}
- (id)initWithCoder:(NSCoder *)decoder//解档
{
    /**
  *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
  *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
  */
    if (self = [super init])
    {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.create_time = [decoder decodeObjectForKey:@"create_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
