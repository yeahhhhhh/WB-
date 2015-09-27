//
//  HXEmotionTabBarButton.m
//  WB微博
//
//  Created by 黄欣 on 15/9/26.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXEmotionTabBarButton.h"

@implementation HXEmotionTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted
{
    //按钮的高亮操作都不在了， 目的就是取消按钮的高亮操作
}
@end
