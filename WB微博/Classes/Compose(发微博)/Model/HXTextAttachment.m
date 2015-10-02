//
//  HXTextAttachment.m
//  WB微博
//
//  Created by 黄欣 on 15/10/1.
//  Copyright (c) 2015年 黄欣. All rights reserved.


#import "HXTextAttachment.h"
#import "HXEmotion.h"
@implementation HXTextAttachment
 -(void)setEmotion:(HXEmotion *)emotion
{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}
@end
