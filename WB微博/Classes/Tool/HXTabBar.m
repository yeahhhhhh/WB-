//
//  HXTabBar.m
//  WB微博
//
//  Created by 黄欣 on 15/7/23.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXTabBar.h"
#import "UIView+Extension.h"
@interface HXTabBar()
@property (nonatomic, weak) UIButton *plusBtn;
@end
@implementation HXTabBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加一个按钮到tabbar中
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}
/**
 *  加号按钮点击
 */
- (void)plusClick
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    // 1.设置加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    //设置其他tabBarButton的位置尺寸
    int index = 0;
    long count = self.subviews.count - 2;
    for (int i = 0; i<count; i++)
    {
        UIView *child = self.subviews[i];
        
        Class class = NSClassFromString(@"UITabBarButton");
        {
            if ([child isKindOfClass:class])
            {
                child.width = self.width/count;
                child.x = index * self.width/count;
                index = index + 1;
            }
            if (index == 2)
            {
                index = index + 1;
            }
            
        }
    }
    
}
@end
