//
//  HXStatusCell.h
//  WB微博
//
//  Created by 黄欣 on 15/9/2.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>
// 昵称字体
#define HWStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define HWStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define HWStatusCellSourceFont HWStatusCellTimeFont
// 正文字体
#define HWStatusCellContentFont [UIFont systemFontOfSize:15]

@class statusFrame;
@interface HXStatusCell : UITableViewCell
+ (instancetype)cellwithTableView:(UITableView *)tableview;
@property (nonatomic, strong) statusFrame *statusFrame;
@end
