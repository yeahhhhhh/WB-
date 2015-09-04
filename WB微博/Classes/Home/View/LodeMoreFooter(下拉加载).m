//
//  LodeMoreFooter(下拉加载).m
//  WB微博
//
//  Created by 黄欣 on 15/9/1.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "LodeMoreFooter(下拉加载).h"

@implementation LodeMoreFooter______

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LodeMoreFooter" owner:nil options:nil] lastObject] ;
}

@end
