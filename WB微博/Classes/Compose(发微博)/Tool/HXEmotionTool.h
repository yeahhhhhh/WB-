//
//  HXEmotionTool.h
//  WB微博
//
//  Created by 黄欣 on 15/10/2.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//  记录最近使用的表情

#import <Foundation/Foundation.h>
@class HXEmotion;
@interface HXEmotionTool : NSObject
+(void)addRecentEmotion:(HXEmotion *)emotion;//最近使用表情
+(NSMutableArray *)recentEmotion;

@end
