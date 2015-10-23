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
#import "MJPhotoBrowser.h"
//#import "MJPhoto.h"
//#import "statusPhotoModle.h"
#import "SDPhotoBrowser.h"
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
    //添加点按手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    for (int i = 0; i < self.subviews.count; i++) {
        HXStatusPhotoView * photoview = self.subviews[i];
        
        //设置空件允许交互
        self.userInteractionEnabled = YES;
        
        
        [self addGestureRecognizer:tap];
        photoview.tag = i;
        
        if (i < photocount) {
            photoview.photo = photos[i];
            photoview.hidden = NO;
        }else{
            photoview.hidden = YES;
        }
    }
    
    
}

-(void)tap:(UITapGestureRecognizer *)tap
{
    NSLog(@"%li",tap.view.tag);
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.photos.count;
    browser.currentImageIndex = self.subviews[1].tag;
    
    
//    for (int j = 0; j<self.subviews.count; j++)
//    {
//        NSLog(@"%ld",(long)self.subviews[j].tag);
//    }
        browser.delegate = self;
    [browser show]; // 展示图片浏览器
    
    
    
    
    //----------------------------------
    //    MJPhotoBrowser *browers = [[MJPhotoBrowser alloc]init];
    //    // 弹出相册时显示的第一张图片是点击的图片
    //   browers.currentPhotoIndex = tap.view.tag;
    //    NSMutableArray *array = [NSMutableArray array];
    //    int i = 0;
    //    for (statusPhotoModle *photo in self.photos) {
    //        MJPhoto *p = [[MJPhoto alloc]init];
    //        p.url = [NSURL URLWithString:photo.thumbnail_pic];
    //        p.index = i;
    //        p.srcImageView = (UIImageView *)tap.view;;
    //        [array addObject:p];
    //        i++;
    //    }
    //    browers.photos = array;
    //    [browers show];
}

#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    statusPhotoModle *p = [[statusPhotoModle alloc]init];
    for (statusPhotoModle *photo in self.photos) {
        
        p.thumbnail_pic = photo.thumbnail_pic;
    }
    
    UIImage * image = [UIImage imageNamed:p.thumbnail_pic];
    return image;
    NSLog(@"%@",image);
}


//返回高质量图片的url
int i = 0;
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSLog(@"index%i",index);
        statusPhotoModle *p = [[statusPhotoModle alloc]init];
        for (statusPhotoModle *photo in self.photos) {
            
            if (i == 1) {
                p.thumbnail_pic = photo.thumbnail_pic;
                continue;
            }
            i++;  
        }
    NSString *urlString = [NSURL URLWithString:p.thumbnail_pic].absoluteString;
    urlString = [urlString stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlString];
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
