//
//  HXEmotionTabBar.h
//  WB微博
//
//  Created by 黄欣 on 15/9/26.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//  表情键盘底部的选项卡

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

typedef enum {
    HXEmotionTabBarButtonTypeRecent, // 最近
    HXEmotionTabBarButtonTypeDefault, // 默认
    HXEmotionTabBarButtonTypeEmoji, // emoji
    HXEmotionTabBarButtonTypeLxh, // 浪小花
} HXEmotionTabBarButtonType;

@class HXEmotionTabBar;
@protocol HXEmotionTabBarDelegate<NSObject>

@optional
- (void)emotionTabBar:(HXEmotionTabBar *)tabBar dudSelectButton:(HXEmotionTabBarButtonType)buttonType;

@end
@interface HXEmotionTabBar : UIView
@property (nonatomic, weak) id<HXEmotionTabBarDelegate> delegate;
@end
