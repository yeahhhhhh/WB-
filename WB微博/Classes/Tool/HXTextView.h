//
//  HXTextView.h
//  WB微博
//
//  Created by 黄欣 on 15/9/21.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//
//  自定义控件 因为UITextView 没有占位文字 不可以使用placehoder
//  带有占位文字

#import <UIKit/UIKit.h>

@interface HXTextView : UITextView
/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *placehoder;
/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *placehoderColor;
@end
