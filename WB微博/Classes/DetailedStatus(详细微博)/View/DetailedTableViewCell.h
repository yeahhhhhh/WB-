//
//  DetailedTableViewCell.h
//  WB微博
//
//  Created by 黄欣 on 15/10/17.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "statusModle(微博模型).h"
#import "userModle.h"
@interface DetailedTableViewCell : UITableViewCell
+ (instancetype)cellwithTableView:(UITableView *)tableView;
@property (nonatomic, strong) statusModle______ *statusModle;
@end
