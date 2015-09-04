//
//  statusFrame.m
//  WB微博
//
//  Created by 黄欣 on 15/9/2.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "statusFrame.h"
//cell 边距离
#define StatusCellBorderW 10
@implementation statusFrame
- (void)setStatus:(statusModle______ *)status
{
    //原创微博整体
//      originaViewF;
    //头像
    self.iconImageF = CGRectMake(StatusCellBorderW, StatusCellBorderW, 50, 50);
    
    //会员图标
    self.vipViewF = CGRectMake(70, StatusCellBorderW, 20, 20);
//    //配图
//    @property (nonatomic, assign) CGRect  photoViewF;
    //昵称
     self.nameLableF = CGRectMake(100, 70, 20, 20);
//    //时间
//    @property (nonatomic, assign) CGRect  timeLableF;
//    //来源
//    @property (nonatomic, assign) CGRect  sourceLableF;
//    //内容
//    @property (nonatomic, assign) CGRect  contentLableF;
//    
//    @property (nonatomic, assign) float  cellhightF;
    self.cellhightF = 200;
}
@end
