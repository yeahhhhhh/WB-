//
//  statusModle(微博模型).m
//  WB微博
//
//  Created by 黄欣 on 15/9/1.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "statusModle(微博模型).h"
#import "userModle.h"
@implementation statusModle______
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[statusPhotoModle class]};//使 pic_urls数组中存放 statusPhotoModle的数据模型
}
@end
