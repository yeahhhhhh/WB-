//
//  HXEmotion.h
//  WB微博
//
//  Created by 黄欣 on 15/9/27.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXEmotion : NSObject 
/** 表情的文字描述*/
@property (nonatomic, copy) NSString *chs;

/** 表情图片名*/
@property (nonatomic, copy) NSString *png;

/** emoji表情16进制编码*/
@property (nonatomic, copy) NSString *code;
@end
