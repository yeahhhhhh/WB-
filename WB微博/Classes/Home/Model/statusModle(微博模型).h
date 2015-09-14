//
//  statusModle(微博模型).h
//  WB微博
//
//  Created by 黄欣 on 15/9/1.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "statusPhotoModle.h"
@class userModle;
@interface statusModle______ : NSObject

/**微博信息内容*/
@property (nonatomic, copy) NSString *text;

/** 字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;

/**微博作者的用户信息字段*/
@property (nonatomic, strong) userModle* user;

/**微博图片内容*/
@property (nonatomic, strong) NSArray *pic_urls;
@end
