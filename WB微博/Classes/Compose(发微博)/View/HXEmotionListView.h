//
//  HXEmotionListView.h
//  WB微博
//
//  Created by 黄欣 on 15/9/26.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//  表情键盘顶部的表情内容 存放了UIScrollView和 UIPageControl

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
@interface HXEmotionListView : UIView

/** 表情数组（里面存放HXEmotion模型数据）*/
@property (nonatomic, strong) NSArray *emotions;
@end
