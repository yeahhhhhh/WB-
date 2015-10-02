//
//  HXEmotionPopView.m
//  WB微博
//
//  Created by 黄欣 on 15/9/29.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXEmotionPopView.h"
#import "HXEmotion.h"
#import "HXEmotionButton.h"
@interface HXEmotionPopView()
@property (weak, nonatomic) IBOutlet HXEmotionButton *emotionButton;

@end
@implementation HXEmotionPopView
//将HXEmotionPopView.xib 添加进来
+(instancetype)PopView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"HXEmotionPopView" owner:nil options:nil]lastObject];
}
/**
 *  显示popView
 */
- (void)showFrame:(HXEmotionButton *)btn
{
    self.emotionButton.emotion = btn.emotion;
    //获得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    //计算出被点击按钮在window 中的frame(相对坐标转化)
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    
    self.centerX = CGRectGetMidX(btnFrame);
    self.y = CGRectGetMidY(btnFrame) - self.height;
}

@end
