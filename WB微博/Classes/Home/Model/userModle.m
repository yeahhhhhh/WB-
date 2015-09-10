//
//  userModle.m
//  WB微博
//
//  Created by 黄欣 on 15/9/1.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "userModle.h"

@implementation userModle
- (void)setMbtype:(int *)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
    
}
//- (BOOL)isVip
//{
//    return self.mbrank > 2;
//}
@end
