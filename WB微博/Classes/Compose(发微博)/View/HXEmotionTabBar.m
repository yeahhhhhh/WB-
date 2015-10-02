//
//  HXEmotionTabBar.m
//  WB微博
//
//  Created by 黄欣 on 15/9/26.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXEmotionTabBar.h"
#import "HXEmotionTabBarButton.h"//导入这个文件点目的就是去除按钮的高亮操作
@interface HXEmotionTabBar()


@property (nonatomic, weak) HXEmotionTabBarButton *selectBut;
@end
@implementation HXEmotionTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        [self setuptitle:@"最近" buttonType:HXEmotionTabBarButtonTypeRecent];
        [self  setuptitle:@"默认" buttonType:HXEmotionTabBarButtonTypeDefault ];//设置键盘默认显示
        [self setuptitle:@"Emoji" buttonType:HXEmotionTabBarButtonTypeEmoji];
        [self setuptitle:@"浪小花" buttonType:HXEmotionTabBarButtonTypeLxh];
    }
    return self;
}
- (HXEmotionTabBarButton *)setuptitle:(NSString *)title buttonType:(HXEmotionTabBarButtonType)buttonType
{
    
    HXEmotionTabBarButton *Btn = [[HXEmotionTabBarButton alloc]init];
    Btn.tag = buttonType;
    [Btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [Btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:Btn];
    
    UIImage *normalImage = [UIImage imageNamed:@"compose_emotion_table_mid_normal"];
    UIImage *selectedImage = [UIImage imageNamed:@"compose_emotion_table_mid_selected"];
    if (self.subviews.count == 1) {
        normalImage = [UIImage imageNamed:@"compose_emotion_table_left_normal" ];
        selectedImage = [UIImage imageNamed:@"compose_emotion_table_left_selected"];
    }else if(self.subviews.count == 4){
        normalImage = [UIImage imageNamed:@"compose_emotion_table_right_normal" ];
        selectedImage = [UIImage imageNamed:@"compose_emotion_table_right_selected"];
    }
    
    
    //拉伸图片
    UIImage *image = [normalImage stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    [Btn setBackgroundImage:image forState:UIControlStateNormal];
    UIImage *selectImage = [selectedImage stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    [Btn setBackgroundImage:selectImage forState:UIControlStateDisabled];

    return Btn;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)self.subviews.count;
    CGFloat btnW = self.width / count;
    
    
    for (int i = 0; i <count; i++) {
        HXEmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = btnW * i;
        btn.width = btnW;
        btn.height = self.height;
    }
}
- (void)setDelegate:(id<HXEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    [self btnClick:(HXEmotionTabBarButton *)[self viewWithTag:HXEmotionTabBarButtonTypeDefault]];
}
- (void)btnClick:(HXEmotionTabBarButton *)Btn
{
    self.selectBut.enabled = YES;
    Btn.enabled = NO;
    self.selectBut = Btn;
    //通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:Btn.tag];
    }
    
}

@end
