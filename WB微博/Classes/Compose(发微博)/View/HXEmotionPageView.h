//
//  HXEmotionPageView.h
//  WB微博
//
//  Created by 黄欣 on 15/9/28.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//  用来存放每一个分页的表情（里面存放1～20个表情)

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@interface HXEmotionPageView : UIView
/** 存放从emotions截取来的表情数组*/
@property (nonatomic, strong) NSArray *emotion;
@end
