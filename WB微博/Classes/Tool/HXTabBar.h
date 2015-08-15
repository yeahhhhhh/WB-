//
//  HXTabBar.h
//  WB微博
//
//  Created by 黄欣 on 15/7/23.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWTabBar;

#warning 因为HWTabBar继承自UITabBar，所以成为HWTabBar的代理，也必须实现UITabBar的代理协议
@protocol HWTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(HWTabBar *)tabBar;
@end

@interface HXTabBar : UITabBar
@property (nonatomic, weak) id<HWTabBarDelegate> delegate;

@end
