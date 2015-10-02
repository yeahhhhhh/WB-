//
//  HXTextAttachment.h
//  WB微博
//
//  Created by 黄欣 on 15/10/1.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//  自定义HXTextAttachment 在发送微博表情时用到，文本附件

#import <UIKit/UIKit.h>
@class HXEmotion;
@interface HXTextAttachment : NSTextAttachment
@property (nonatomic, strong) HXEmotion *emotion;
@end
