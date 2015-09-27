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
/** 表情内容 */
@property (nonatomic, weak) HXEmotionListView *listView;
/** TabBar*/
@property (nonatomic, weak) HXEmotionTabBar *tabBar;
@end

@implementation HXEmotionKeyboard
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 表情内容
        HXEmotionListView *listView = [[HXEmotionListView alloc]init];
        self.listView = listView;
        listView.backgroundColor = [UIColor redColor];
        
        // TabBar
        HXEmotionTabBar *tabBar = [[HXEmotionTabBar alloc]init];
        self.tabBar = tabBar;
        tabBar.delegate = self;
        
        [self addSubview:listView];
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
    self.listView.width = self.width;
    self.listView.height = self.height - self.tabBar.height;
    self.listView.x = 0;
    self.listView.y = 0;
}

#pragma mark HXEmotionTabBarDelegate

- (void)emotionTabBar:(HXEmotionTabBar *)tabBar dudSelectButton:(HXEmotionTabBarButtonType)buttonType
{
    switch (buttonType) {
        case HXEmotionTabBarButtonTypeRecent: {// 最近
        
            
                break;
        }
            
        case HXEmotionTabBarButtonTypeDefault:{ // 默认
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
            NSArray *defaultEmotions = [NSArray arrayWithContentsOfFile:path];
            self.listView.emotions = [HXEmotion objectArrayWithKeyValuesArray:defaultEmotions];
            
            break;
        }
        case HXEmotionTabBarButtonTypeEmoji: {// Emoji
            NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
            NSArray *emojiEmotions = [NSArray arrayWithContentsOfFile:path];
            self.listView.emotions = [HXEmotion objectArrayWithKeyValuesArray:emojiEmotions];
            NSLog(@"%@",emojiEmotions);
            break;
        }
            
        case HXEmotionTabBarButtonTypeLxh: {// Lxh
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
            NSArray *lxhEmotions = [NSArray arrayWithContentsOfFile:path];
            self.listView.emotions = [HXEmotion objectArrayWithKeyValuesArray:lxhEmotions];
            NSLog(@"%@",lxhEmotions);
             break;
        }
    }
}

@end
