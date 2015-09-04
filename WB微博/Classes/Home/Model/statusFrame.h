//
//  statusFrame.h
//  WB微博
//
//  Created by 黄欣 on 15/9/2.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "statusModle(微博模型).h"
//  一个StatusFrame模型里面包含的信息
//  1.存放着一个cell内部所有子控件的frame数据
//  2.存放一个cell的高度
//  3.存放着一个数据模型statusModle______ 
@interface statusFrame : NSObject

@property (nonatomic, strong) statusModle______ *status;
//原创微博整体
@property (nonatomic, assign) CGRect  originaViewF;
//头像
@property (nonatomic, assign) CGRect  iconImageF;
//会员图标
@property (nonatomic, assign) CGRect  vipViewF;
//配图
@property (nonatomic, assign) CGRect  photoViewF;
//昵称
@property (nonatomic, assign) CGRect  nameLableF;
//时间
@property (nonatomic, assign) CGRect  timeLableF;
//来源
@property (nonatomic, assign) CGRect  sourceLableF;
//内容
@property (nonatomic, assign) CGRect  contentLableF;

@property (nonatomic, assign) float  cellhightF;
@end
