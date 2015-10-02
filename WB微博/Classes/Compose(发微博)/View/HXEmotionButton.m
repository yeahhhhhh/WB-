//
//  HXEmotionButton.m
//  WB微博
//
//  Created by 黄欣 on 15/9/29.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXEmotionButton.h"
#import "HXEmotion.h"
#import "NSString+Emoji.h"
@implementation HXEmotionButton
/**
 *  当控件不是从xib、storyboard中创建时，就会调用这个方法
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //长按表情时，表情颜色不会变为灰色
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:32];
    }
    return self;
}
/**
 *  当控件是从xib、storyboard中创建时，就会调用这个方法
 */
//当一个对象从文件解析出来时回调用initWithCoder 因为放大镜里的图片是从xib创建出来的，所以它调用initWithCoder
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:32];
    }
    return self;
}
/**
 *  这个方法在initWithCoder:方法后调用
 */
- (void)awakeFromNib
{
    
}
- (void)setEmotion:(HXEmotion *)emotion
{
    _emotion = emotion;
    //设置默认和浪小花
    if (self.emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }
    
    //设置emoji
    if (emotion.code) {
        NSString *emoji = [self.emotion.code emoji];
        
        [self setTitle:emoji forState:UIControlStateNormal];
    }
}
//- (void)setHidden:(BOOL)hidden
//{
//    NSLog(@"从写setHidden方法 可以在长按表情时，表情不是灰色");
//}

@end
