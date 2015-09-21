//
//  HXiconView.m
//  WB微博
//
//  Created by 黄欣 on 15/9/20.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXiconView.h"
#import "UIView+Extension.h"
#import "userModle.h"
#import "UIImageView+WebCache.h"
@implementation HXiconView

- (UIImageView *)VerifiedView
{
    if (!_VerifiedView)
    {
        UIImageView *VerifiedView = [[UIImageView alloc]init];
//        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
//        UIImageView *VerifiedView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:VerifiedView];
        self.VerifiedView =  VerifiedView;
       
    }
    return _VerifiedView;
}
- (void)setUser:(userModle *)user
{
    _user = user;
     [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
   
    switch (user.verified_type) {//@"avatar_enterprise_vip"
        case HXUserVerifiedTypeNone:// 没有任何认证
            self.VerifiedView.hidden = YES ;
            break;
        case HXUserVerifiedPersonal:// 个人认证
            
            self.VerifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            self.VerifiedView.hidden = NO;
            break;
            
        case HXUserVerifiedOrgEnterprice:// 企业官方：CSDN、EOE、搜狐新闻客户端
        case HXUserVerifiedOrgMedia:// 媒体官方：程序员杂志、苹果汇
        case HXUserVerifiedOrgWebsite:// 网站官方：猫扑
            self.VerifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            self.VerifiedView.hidden = NO;
            break;
            
        case HXUserVerifiedDaren:// 微博达人
            self.VerifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            self.VerifiedView.hidden = NO;
            break;
            
        default:
            self.VerifiedView.hidden = YES ;
            break;
    }
    
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.VerifiedView.size = self.VerifiedView.image.size;
    self.VerifiedView.x = self.width - self.VerifiedView.width *0.5;
    self.VerifiedView.y = self.height - self.VerifiedView.height *0.5;
}

@end

