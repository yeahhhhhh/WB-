//
//  HXStatusCell.h
//  WB微博
//
//  Created by 黄欣 on 15/9/2.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "statusPhotoModle.h"
@class statusFrame;
@interface HXStatusCell : UITableViewCell
+ (instancetype)cellwithTableView:(UITableView *)tableview;
@property (nonatomic, strong) statusFrame *statusFrame;
@end
