//
//  HXComposeToolbar.m
//  WB微博
//
//  Created by 黄欣 on 15/9/24.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXComposeToolbar.h"
#import "UIView+Extension.h"
@interface HXComposeToolbar()
@property (nonatomic, weak) UIButton *button;
@end
@implementation HXComposeToolbar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        // 初始化按钮
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:HXComposeToolbarButtonTypeCamera];
        
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:HXComposeToolbarButtonTypePicture];
        
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:HXComposeToolbarButtonTypeMention];
        
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:HXComposeToolbarButtonTypeTrend];
        
        self.button = [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:HXComposeToolbarButtonTypeEmotion];
    }
    return self;
}
/**
 * 创建一个按钮
 */
- (UIButton *)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(HXComposeToolbarButtonType)type
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.tag = type;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
    
}
- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        //NSUInteger index = (NSUInteger)btn.x / btn.width;
        [self.delegate composeToolbar:self didClickButton:btn.tag];
    }
}

- (void)setShowEmotionbutton:(BOOL)showEmotionbutton
{
    _showEmotionbutton = showEmotionbutton;
    if (self.showEmotionbutton) {
        [self.button setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }else{
        [self.button setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat bW = self.width/5;
    NSUInteger count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        UIButton *b = self.subviews[i];
        b.y = 0;
        b.x = i * bW;
        b.width = bW;
        b.height = 44;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
