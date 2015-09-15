//
//  statusFrame.m
//  WB微博
//
//  Created by 黄欣 on 15/9/2.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "statusFrame.h"
#import "userModle.h"
@implementation statusFrame
- (void)setStatus:(statusModle______ *)status
{
    
    _status = status;
     userModle *user = status.user;
    //头像
    CGFloat iconWH = 35;
    CGFloat iconX = StatusCellBorderW;
    CGFloat iconY = StatusCellBorderW;
    self.iconImageF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconImageF) + StatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize  nameSize = [self sizeWithText:user.name font:StatusCellNameFont];
    self.nameLableF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    //会员图标
    if (status.user.isVip) {
        CGFloat VipX = CGRectGetMaxX(self.nameLableF) + StatusCellBorderW;
        CGFloat VipY = iconX;
        CGFloat VipW = 14;
        CGFloat VipH = nameSize.height;
        self.vipViewF = CGRectMake(VipX, VipY, VipW, VipH);
    }
    
    //时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLableF) + StatusCellBorderW;
    CGSize  timeSize = [self sizeWithText:status.created_at font:StatusCellTimeFont];
    self.timeLableF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    //来源
    CGFloat sourceX =  CGRectGetMaxX(self.timeLableF) + 3 * StatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize  sourceSize = [self sizeWithText:status.created_at font:StatusCellTimeFont];
    self.sourceLableF = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    //内容
    CGFloat contentX =  StatusCellBorderW;
    CGFloat contentY =MAX(CGRectGetMaxY(self.iconImageF), CGRectGetMaxY(self.timeLableF))  + StatusCellBorderW;
    
    CGFloat maxW = [UIScreen mainScreen].bounds.size.width - 2 * StatusCellBorderW;
    CGSize  contentSize = [self sizeWithText:status.text font:StatusCellContentFont maxW:maxW];
    self.contentLableF =  (CGRect){{contentX,contentY},contentSize};//CGRectMake(contentX, contentY, contentSize.width, sourceSize.height);
    
    //配图
    CGFloat originaViewH;
        if (status.pic_urls.count ) {//有配图
            CGFloat photoWH = 60;
            CGFloat photoX = StatusCellBorderW;
            CGFloat photoY = CGRectGetMaxY(self.contentLableF) + StatusCellBorderW ;
            self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
    
             originaViewH = StatusCellBorderW + CGRectGetMaxY(self.photoViewF);
           
            
        }else{//无配图
    
             originaViewH = StatusCellBorderW + CGRectGetMaxY(self.contentLableF);
        }
    
    //原创微博整体
    CGFloat originaViewX = 0;
    CGFloat originaViewY = StatusCellBorderW;
    CGFloat originaViewW = [UIScreen mainScreen].bounds.size.width;
//    originaViewH = StatusCellBorderW + CGRectGetMaxY(self.contentLableF);
    self.originaViewF = CGRectMake(originaViewX, originaViewY, originaViewW, originaViewH);
    
    
//    //转发微博
    CGFloat toolbarY;
    if (status.retweeted_status) {
        
        //转发微博内容
        CGFloat retweetContentLableX = StatusCellBorderW;
        CGFloat retweetContentLableY = StatusCellBorderW;
        CGFloat maxW = [UIScreen mainScreen].bounds.size.width - 2 * StatusCellBorderW;
        NSString *retweetContent = [NSString  stringWithFormat:@"@%@ : %@",status.retweeted_status.user.name , status.retweeted_status.text];
        CGSize  retweetContentSize = [self sizeWithText:retweetContent font:StatusCellretweetContentFont maxW:maxW];
        self.retweetContentLableF =  (CGRect){{retweetContentLableX,retweetContentLableY},retweetContentSize};

        //转发微博配图
        CGFloat retweetViewH;
        if (status.retweeted_status.pic_urls.count ) {//有配图
            CGFloat retweetPhotoWH = 60;
            CGFloat retweetPhotoX = StatusCellBorderW;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLableF) + StatusCellBorderW ;
            self.retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
            retweetViewH = StatusCellBorderW + CGRectGetMaxY(self.retweetPhotoViewF);
        }else{//无配图
            retweetViewH = StatusCellBorderW + CGRectGetMaxY(self.retweetContentLableF);
        }
        
        //转发微博整体
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = originaViewH;
        CGFloat retweetViewW = originaViewW;
        self.retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
         //工具条y坐标
         toolbarY = CGRectGetMaxY(self.retweetViewF);

    }else{//工具条y坐标
          toolbarY = CGRectGetMaxY(self.originaViewF);
    }
 
    //工具条
    CGFloat toolbarX = 0;
    CGFloat toolbarW = [UIScreen mainScreen].bounds.size.width;
    CGFloat toolbarH = 35;
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    //cell高
    self.cellhightF = CGRectGetMaxY(self.toolbarF) ;
    
}
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font //maxW:(CGFloat)maxW
{
    
       return [self sizeWithText:text font:font maxW:(MAXFLOAT)];
}
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
     return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//    return [text sizeWithAttributes:attrs];
}

@end
