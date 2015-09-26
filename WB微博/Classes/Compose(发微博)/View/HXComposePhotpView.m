//
//  HXComposePhotpView.m
//  WB微博
//
//  Created by 黄欣 on 15/9/24.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXComposePhotpView.h"
#import "UIView+Extension.h"
@implementation HXComposePhotpView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)addPhoto:(UIImage *)photo
{
    UIImageView *photoView = [[UIImageView alloc]init];
    photoView.image = photo;
    [self addSubview:photoView];
    //存储图片
    [_photos addObject:photo];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = (int )self.subviews.count;
    int maxCols = 4;
    CGFloat imageWH = 65;
    CGFloat imageMargin = 10;//图片间距
    for (int i = 0; i < count; i++) {
        UIImageView *image = self.subviews[i];
        
        //列数
        int cols = i % maxCols ;
        int row = i / maxCols;
        image.x = cols * (imageWH + imageMargin) ;
        image.y = row * (imageWH + imageMargin);
        image.width = imageWH;
        image.height = imageWH ;
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
