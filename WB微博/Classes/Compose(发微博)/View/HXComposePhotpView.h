//
//  HXComposePhotpView.h
//  WB微博
//
//  Created by 黄欣 on 15/9/24.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXComposePhotpView : UIView
- (void)addPhoto:(UIImage *)photo;
@property (nonatomic, strong,readonly ) NSMutableArray  *photos;
@end
