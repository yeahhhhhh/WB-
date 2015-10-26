//
//  MeStatusCell.h
//  WB微博
//
//  Created by 黄欣 on 15/10/25.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeStatusFrame;
@interface MeStatusCell : UITableViewCell
+ (instancetype)cellwithTableView:(UITableView *)tableview;
@property (nonatomic, strong) MeStatusFrame *meStatusFrame;
@end
