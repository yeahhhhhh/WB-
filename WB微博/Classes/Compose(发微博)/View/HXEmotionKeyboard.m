//
//  HXEmotionKeyboard.m
//  WB微博
//
//  Created by 黄欣 on 15/9/26.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXEmotionKeyboard.h"
#import "HXEmotionListView.h"
#import "HXEmotionTabBar.h"
#import "HXEmotion.h"//添加模型类
#import "MJExtension.h"//转模型类
@interface HXEmotionKeyboard()<HXEmotionTabBarDelegate>
/** 将现实表情内容的空件添加到 contentView*/
@property (nonatomic, strong) UIView *contentView;
/** 表情内容 */
@property (nonatomic, strong) HXEmotionListView *contentlistView;
@property (nonatomic, strong) HXEmotionListView *defaultlistView;
@property (nonatomic, strong) HXEmotionListView *emojilistView;
@property (nonatomic, strong) HXEmotionListView *lxhlistView;
/** TabBar*/
@property (nonatomic, weak) HXEmotionTabBar *tabBar;
@end

@implementation HXEmotionKeyboard
#pragma mark - 懒加载
- (HXEmotionListView *)contentlistView
{
    if (!_contentlistView)
    {
        self.contentlistView = [[HXEmotionListView alloc]init];
        self.contentlistView.backgroundColor = [UIColor yellowColor];
    }
    return _contentlistView;
}
- (HXEmotionListView *)defaultlistView
{
    if (!_defaultlistView)
    {
        NSLog(@"laiduaoz");
        self.defaultlistView = [[HXEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *defaultEmotions = [NSArray arrayWithContentsOfFile:path];
        
        self.defaultlistView.emotions = [HXEmotion objectArrayWithKeyValuesArray:defaultEmotions];
        NSLog(@"%@",self.defaultlistView.emotions);
        self.defaultlistView.backgroundColor = [UIColor yellowColor];
    }
    return _defaultlistView;
}
- (HXEmotionListView *)emojilistView
{
    if (!_emojilistView)
    {
        
        self.emojilistView = [[HXEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *emojiEmotions = [NSArray arrayWithContentsOfFile:path];
        self.emojilistView.emotions = [HXEmotion objectArrayWithKeyValuesArray:emojiEmotions];
        self.emojilistView.backgroundColor = [UIColor blueColor];
    }
    return _emojilistView;
}
- (HXEmotionListView *)lxhlistView
{
    if (!_lxhlistView)
    {
        self.lxhlistView = [[HXEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *lxhEmotions = [NSArray arrayWithContentsOfFile:path];
        self.lxhlistView.emotions = [HXEmotion objectArrayWithKeyValuesArray:lxhEmotions];
       self.lxhlistView.backgroundColor = [UIColor orangeColor];
    }
    return _lxhlistView;
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 表情内容
        UIView *contentView = [[UIView alloc]init];
        self.contentView = contentView;
        
        // TabBar
        HXEmotionTabBar *tabBar = [[HXEmotionTabBar alloc]init];
        self.tabBar = tabBar;
        tabBar.delegate = self;
        
        [self addSubview:contentView];
        [self addSubview:tabBar];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //TabBar
    self.tabBar.height = 44;
    self.tabBar.width = self.width;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    //表情内容
    self.contentView.width = self.width;
    self.contentView.height = self.height - self.tabBar.height;
    self.contentView.x = 0;
    self.contentView.y = 0;
}

#pragma mark HXEmotionTabBarDelegate

- (void)emotionTabBar:(HXEmotionTabBar *)tabBar didSelectButton:(HXEmotionTabBarButtonType)buttonType
{
    //移除contentView所有子空件
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (buttonType) {
        case HXEmotionTabBarButtonTypeRecent: {// 最近
            [self.contentView addSubview:self.contentlistView];
            break;
        }
            
        case HXEmotionTabBarButtonTypeDefault:{ // 默认
            
            [self.contentView addSubview:self.defaultlistView];
            break;
        }
        case HXEmotionTabBarButtonTypeEmoji: {// Emoji
            [self.contentView addSubview:self.emojilistView];
            break;
        }
            
        case HXEmotionTabBarButtonTypeLxh: {// Lxh
            [self.contentView addSubview:self.lxhlistView];
             break;
        }
    }
    UIView *child = [self.contentView.subviews firstObject];
    child.frame = self.contentView.bounds;
}

@end
