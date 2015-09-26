//
//  HXComposeToolbar.h
//  WB微博
//
//  Created by 黄欣 on 15/9/24.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//  用于键盘上方 有照相 图片 表情等选择

#import <UIKit/UIKit.h>
typedef enum {
    HXComposeToolbarButtonTypeCamera, // 拍照
    HXComposeToolbarButtonTypePicture, // 相册
    HXComposeToolbarButtonTypeMention, // @
    HXComposeToolbarButtonTypeTrend, // #
    HXComposeToolbarButtonTypeEmotion // 表情
} HXComposeToolbarButtonType;

@class HXComposeToolbar;
@protocol HXComposeToolbarDelegate <NSObject>

@optional
- (void)composeToolbar:(HXComposeToolbar *)toolbar didClickButton:(HXComposeToolbarButtonType)buttonType;
@end
@interface HXComposeToolbar : UIView
@property (nonatomic, weak) id<HXComposeToolbarDelegate> delegate;

@end
