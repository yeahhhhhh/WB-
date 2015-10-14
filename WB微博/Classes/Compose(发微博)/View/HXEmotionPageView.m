//
//  HXEmotionPageView.m
//  WB微博
//
//  Created by 黄欣 on 15/9/28.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXEmotionPageView.h"
#import "HXEmotion.h"
#import "HXEmotionPopView.h"
#import "HXEmotionButton.h"
// 一页中最多3行
#define HWEmotionMaxRows 3
// 一行中最多7列
#define HWEmotionMaxCols 7
// 每一页的表情个数
#define HWEmotionPageSize ((HWEmotionMaxRows * HWEmotionMaxCols) - 1)
//// RGB颜色
//#define HWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//
//// 随机色
//#define HWRandomColor HWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface HXEmotionPageView ()
/** 点击表情按钮后弹出的放大镜*/
@property (nonatomic, strong) HXEmotionPopView *popView;
/** 删除按钮*/
@property (nonatomic, strong) UIButton *deleteButton;
@end
@implementation HXEmotionPageView
#pragma mark - 懒加载
- (HXEmotionPopView *)popView
{
    if (!_popView)
    {
        self.popView = [HXEmotionPopView PopView];
    }
    return _popView;
}
#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressView:)]];
    }
    return self;
}
- (void)setEmotion:(NSArray *)emotion
{
    _emotion = emotion;
    
    for (int i = 0; i < emotion.count; i++) {
        HXEmotionButton *button = [[HXEmotionButton alloc]init];
        //设置表情数据
        button.emotion = emotion[i];
        [self addSubview:button];
        //监听按钮点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    UIButton *deleteButton = [[UIButton alloc]init];
    self.deleteButton = deleteButton;
    [self.deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    [self.deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
    [self.deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 内边距(四周)
    CGFloat inset = 20;
    NSUInteger count = self.emotion.count;
    CGFloat btnW = (self.width - 2 * inset) / HWEmotionMaxCols;
    CGFloat btnH = (self.height -  inset) / HWEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        HXEmotionButton *button = self.subviews[i];
        button.width = btnW;
        button.height = btnH;
        button.x = inset + (i%HWEmotionMaxCols) * btnW;
        button.y = inset + (i/HWEmotionMaxCols) * btnH;
      }
    //设置取消按钮
     self.deleteButton.width = btnW;
     self.deleteButton.height = btnH;
     self.deleteButton.x = inset + (20 %HWEmotionMaxCols) * btnW;
     self.deleteButton.y = inset + (20 /HWEmotionMaxCols) * btnH;
}

/**
 监听表情按钮的点击
 */
- (void)buttonClick:(HXEmotionButton *)btn
{
    //显示popView
    [self.popView showFrame:btn];
    //设置“放大镜0.3秒自动消失”
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    //发通知，通知是哪个表情按钮被点击，并且传递按钮图片。
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"selectEmotion"] = btn.emotion;
    /**
     *  object:(id) 表示 是谁发出的通知 , 这里nil 匿名发出通知
     *  这个监听在控制器 HXComposeViewController 内监听
     */
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"HXEmotionDidSlectNotification" object:nil userInfo:userInfo];//这条通知被两个地方监听，1、HXComposeViewController 监听它将最近表情来存入沙盒 2、HXEmotionKeyboard监听它新点击了表情，刷新“最近”里面的数据。
    

}
/**
 *  删除按钮被点击
 */
- (void)deleteClick:(UIButton *)btn
{
    //发通知，通知删除uitextview内的图片
    [[NSNotificationCenter defaultCenter]postNotificationName:@"HXEmotionDidDeleteNotification" object:nil];
    
}
/**
 *  监听长按手势 在这个方法中处理长按手势触
 */
- (void)longPressView:(UILongPressGestureRecognizer *)recognizer
{
    //获得手指所在的位置
    CGPoint location = [recognizer locationInView:recognizer.view];
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {//结束和被强制结束
            //获得手指所在的位置（在那个按钮上）
            
            HXEmotionButton *button = [self emotionButtonWithLocation:location];
            if (button)
            {
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                userInfo[@"selectEmotion"] = button.emotion;
                [[NSNotificationCenter defaultCenter]postNotificationName:@"HXEmotionDidSlectNotification" object:nil userInfo:userInfo];
            }
            [self.popView removeFromSuperview];
            break;
        }
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:{//手势开始（刚检测到长按）手势改变、移动
            [self emotionButtonWithLocation:location];
            break;
            
        }
        case UIGestureRecognizerStatePossible:
            NSLog(@"UIGestureRecognizerStatePossible");
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"UIGestureRecognizerStateFailed");
            break;
            
        
            
    }
}

/**
 *  根据传进来的location 来寻找对应的按钮，如果找到返回button，如果找不到返回空（因为不在pageView界面内所以找不到）
 */
-(HXEmotionButton *)emotionButtonWithLocation:(CGPoint )location
{
    HXEmotionButton *button;
    for (int i = 0; i < self.emotion.count; i++)
    {
        button = self.subviews[i];
        if (CGRectContainsPoint(button.frame, location))//判断location 在那个按钮的frame的范围内
        {
            [self.popView showFrame:button];
            return button;
        }
    }
    return nil;
}









@end
