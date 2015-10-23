//
//  HXStatusPhotoView.m
//  WB微博
//
//  Created by 黄欣 on 15/9/18.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//  一张配图 给图片添加gif提醒

#import "HXStatusPhotoView.h"
#import "statusPhotoModle.h"
#import "UIView+Extension.h"

@interface HXStatusPhotoView()
@property (nonatomic, weak) UIImageView *gifview;
@end

@implementation HXStatusPhotoView

- (UIImageView *)gifview
{
    if (!_gifview)
    {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifview = [[UIImageView alloc]initWithImage:image];
        [self addSubview:gifview];
        self.gifview =  gifview;
    }
    return _gifview;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /**
         *   UIViewContentModeScaleToFill,
         UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
         UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
         UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
         UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
         UIViewContentModeTop,
         UIViewContentModeBottom,
         UIViewContentModeLeft,
         UIViewContentModeRight,
         UIViewContentModeTopLeft,
         UIViewContentModeTopRight,
         UIViewContentModeBottomLeft,
         UIViewContentModeBottomRight,
         */
        
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;//裁减超出边框的部分
        
        
    }
    return self;
}

- (void)setPhoto:(statusPhotoModle *)photo
{
    _photo = photo;
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //显示或隐藏gif图片
    if ([photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"])//将字符串改为小写 并验证后缀是否是gif
    {
        self.gifview.hidden = NO;
    }else{
        self.gifview.hidden = YES;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifview.x = self.width - self.gifview.width;
    self.gifview.y = self.height - self.gifview.height;
}
@end
