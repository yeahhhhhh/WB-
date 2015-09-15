//
//  HXStatusCell.h
//  WB微博
//
//  Created by 黄欣 on 15/9/2.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "statusPhotoModle.h"

// 昵称字体
#define HXStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define HXStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define HXStatusCellSourceFont HXStatusCellTimeFont
// 正文字体
#define HXStatusCellContentFont [UIFont systemFontOfSize:15]

//转发内容字体
#define HXStatusCellretweetContentFont [UIFont systemFontOfSize:13]

@class statusFrame;
@interface HXStatusCell : UITableViewCell
+ (instancetype)cellwithTableView:(UITableView *)tableview;
@property (nonatomic, strong) statusFrame *statusFrame;
@end
