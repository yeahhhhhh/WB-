//
//  HXTextView.m
//  WB微博
//
//  Created by 黄欣 on 15/9/21.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//
//  自定义控件 因为UITextView 没有占位文字 不可以使用placehoder

#import "HXTextView.h"
#import "UIView+Extension.h"
@implementation HXTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 通知
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
       [ [NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return  self;
}
- (void)dealloc
{
    //被监听对象 releas 掉后 解除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = [placehoder copy];
    
    [self setNeedsDisplay];
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor = placehoderColor;
    [self setNeedsDisplay];
}
/**
 *  监听文字改变
 */
- (void)textDidChange
{
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    if (!self.hasText) {//判断 是否有内容 没有内容
        NSMutableDictionary *dic = [NSMutableDictionary dictionary ];
        dic[NSFontAttributeName] = self.font;
        dic[NSForegroundColorAttributeName] = self.placehoderColor;
        //画文字
//        [self.placehoder drawAtPoint:CGPointMake(5, 8) withAttributes:dic];
        CGFloat x = 5;
        CGFloat y = 8;
        CGFloat w = rect.size.width  - 2 * x;
        CGFloat h = rect.size.height - 2 * y;
        [self.placehoder drawInRect:CGRectMake(x, y, w , h) withAttributes:dic];
    }
   
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
@end
