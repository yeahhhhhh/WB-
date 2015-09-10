//
//  userModle.h
//  WB微博
//
//  Created by 黄欣 on 15/9/1.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userModle : NSObject

/**友好显示名称*/
@property (nonatomic, copy) NSString *name;

/**用户头像地址（中图），50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;

/**字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int *mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign, getter = isVip) BOOL vip;
@end
