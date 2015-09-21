//
//  HXStatusPhotosView.m
//  WB微博
//
//  Created by 黄欣 on 15/9/17.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXStatusPhotosView.h"
#import "statusPhotoModle.h"
#import "UIView+Extension.h"
#import "HXStatusPhotoView.h"
#define HXStatusPhotoMaxCol(count) ((count == 4)?2:3)
@implementation HXStatusPhotosView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor orangeColor ];
    }
    return  self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    int photocount = (int )photos.count;
    while (self.subviews.count < photocount) {
        HXStatusPhotoView *photoview = [[HXStatusPhotoView alloc]init];
        [self addSubview:photoview];
    }
    for (int i = 0; i < self.subviews.count; i++) {
        HXStatusPhotoView * photoview = self.subviews[i];
        if (i < photocount) {
            photoview.photo = photos[i];
            photoview.hidden = NO;
        }else{
            photoview.hidden = YES;
        }
    }
    
}
- (void)layoutSubviews{
    int photocount = (int )self.photos.count;
    int maxCols = HXStatusPhotoMaxCol(photocount);
    
    for (int i = 0; i < photocount; i++) {
        HXStatusPhotoView *image = self.subviews[i];
        
        //列数
        int cols = i % maxCols ;
        int row = i / maxCols;
            image.x = cols * (StatusPhotoWH +5) ;
            image.y = row * (StatusPhotoWH + 5);
            image.width = StatusPhotoWH;
            image.height = StatusPhotoWH ;   
    }
    
}



+ (CGSize)sizeWithCount:(int)count
{
    int maxCols =  HXStatusPhotoMaxCol(count);
    //列数
    int cols = (count >= maxCols) ? maxCols : count ;
    //行数
    int row;
    if (count % maxCols == 0) {
        row = count / maxCols;
    }else{
        row = count / maxCols + 1;
    }
    CGFloat photosW = StatusPhotoWH *  cols + (cols - 1 )* 10;
    CGFloat photosH = StatusPhotoWH *  row + (row - 1 )* 10;
    return CGSizeMake(photosW, photosH);
    
}



@end
