//
//  HXiconView.h
//  WB微博
//
//  Created by 黄欣 on 15/9/20.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>
@class userModle;

@interface HXiconView : UIImageView
@property (nonatomic, strong) userModle *user;
//@property (nonatomic, strong) UIImage *VerifiedImage;
@property (nonatomic, strong) UIImageView *VerifiedView;
@end
