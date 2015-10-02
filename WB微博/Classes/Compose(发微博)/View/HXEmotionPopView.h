//
//  HXEmotionPopView.h
//  WB微博
//
//  Created by 黄欣 on 15/9/29.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
@class HXEmotion,HXEmotionButton;
@interface HXEmotionPopView : UIView
/**  显示popView */
- (void)showFrame:(HXEmotionButton *)btn;

+(instancetype)PopView;
@end
