//
//  userModle.h
//  WB微博
//
//  Created by 黄欣 on 15/9/1.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HXUserVerifiedTypeNone = -1, // 没有任何认证
    
    HXUserVerifiedPersonal = 0,  // 个人认证
    
    HXUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    
    HXUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    
    HXUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    HXUserVerifiedDaren = 220 // 微博达人
    
} HXUserVerifiedType;

@interface userModle : NSObject

/**友好显示名称*/
@property (nonatomic, copy) NSString *name;

/**用户头像地址（中图），50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;
/**用户头像 高清*/
@property (nonatomic, copy) NSString *avatar_hd;
/**字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;
/*用户头像地址（大图），180×180像素*/
@property (nonatomic, copy) NSString *avatar_large;
/*	粉丝数*/
@property (nonatomic, assign) int followers_count;
/*	关注数*/
@property (nonatomic, assign) int friends_count;
/*	微博数*/
@property (nonatomic, assign) int statuses_count;
/*收藏数*/
@property (nonatomic, assign) int favourites_count;

///** 会员类型 > 2代表是会员 */
//@property (nonatomic, assign) int *mbtype;
//
///** 会员等级 */
//@property (nonatomic, assign) int mbrank;
//
//@property (nonatomic, assign, getter = isVip) BOOL vip;

/**认证类型*/
@property (nonatomic, assign) HXUserVerifiedType  verified_type;
@end
