//
//  HXStatusPhotosView.h
//  WB微博
//
//  Created by 黄欣 on 15/9/17.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//  微博首页cell显示的图片最多9张 里面都是HXStatusPhotoView

#import <UIKit/UIKit.h>
//图片大小
#define StatusPhotoWH 70
@interface HXStatusPhotosView : UIView
@property (nonatomic, strong) NSArray *photos;
/**
 *  根据图片个数计算相册尺寸
 */
+ (CGSize)sizeWithCount:(int)count;
@end
