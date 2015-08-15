//
//  HXDropdownMenu.h
//  WB微博
//
//  Created by 黄欣 on 15/7/21.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXDropdownMenu;
@protocol HXDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenuDidDismiss:(HXDropdownMenu *)menu;

@end



@interface HXDropdownMenu : UIView
@property (nonatomic, weak) id<HXDropdownMenuDelegate> delegate;
+ (instancetype)menu;
- (void)showFrom:(UIView *)from;//显示
- (void)dismiss;//销毁
/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;

@end
//     UIWindow *window = [[UIApplication sharedApplication].windows lastObject];//这样获得的窗口是这个频幕最上面窗口，不会被其他控件遮住
//    //先添加蒙板
//    UIView * cover = [[UIView alloc]init];
//    //cover.backgroundColor = [UIColor clearColor];
//    cover.frame = window.bounds;//设置大小与窗口一样大
//    [window addSubview:cover];
//
//    //添加带箭头 图片
//    UIImageView *dropdownMenu = [[UIImageView alloc]init];
//    dropdownMenu.image = [UIImage imageNamed:@"popover_background"];
//    dropdownMenu.width = 217;
//    dropdownMenu.height = 350;
//    dropdownMenu.y = 55;
//    dropdownMenu.x = 60;
//    dropdownMenu.userInteractionEnabled = YES;//开启交互功能 里面的控件就可以与被使用
//
//    [cover addSubview:dropdownMenu];
//    /*
//     [self.view.window addSubview:dropdownMenu];
//     self.view.window 等同于 [UIApplication sharedApplication].keyWindow
//     建议使用[UIApplication sharedApplication].keyWindow 获得窗口
//     self.view.window 方法获得的窗口值可能为nul.
//    */