//
//  HXDropdownMenu.m
//  WB微博
//
//  Created by 黄欣 on 15/7/21.
//  Copyright (c) 2015年 黄欣. All rights reserved.
/*
 
 封装好的下拉菜单
 使用时需要给有下拉菜单的按钮添加一个监听
 在实现监听的方法里放入下拉菜单的内容
 [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
 - (void)titleClick:(UIButton *)titleButton
 {
 //创建下啦菜单
 HXDropdownMenu *menu = [HXDropdownMenu menu];//这是类方法
 //显示菜单
 
 HomeMenuController *c = [[HomeMenuController alloc]init];
 c.view.height = 200;
 c.view.width = 150;
 menu.contentController = c;
 [menu showFrom:titleButton];//方法
 }
 @property (nonatomic ,strong)UIButton *c;//---------
                                                         (写在@interface ProfileTableViewController ()
                                                         @property (nonatomic ,strong)UIButton *c;//---------
                                                         @end 里)
 self.c = c;//-----(写在 - (void)viewDidLoad 里)
 [menu showFrom:self.c];//--------(写在- (void)titleClick:(UIButton *)titleButton里)
 */

#import "HXDropdownMenu.h"
#import "UIView+Extension.h"
@interface HXDropdownMenu ()
@property (nonatomic , weak)UIImageView *containerView;

@end

@implementation HXDropdownMenu
- (UIImageView *)containerView
{
    if (!_containerView) {
        // 添加一个灰色图片控件
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES; // 开启交互
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}
- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;//拥有控制器防止销毁
    
    self.content = contentController.view;
}
+ (instancetype)menu
{
    return [[self alloc] init];
}

- (void)showFrom:(UIView *)from
{
    //获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    //添加自己到窗口上
    [window addSubview:self];
    //设置尺寸
    self.frame = window.bounds;
    
    // 4.调整灰色图片的位置
    // 默认情况下，frame是以父控件左上角为坐标原点
    // 转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
}
    
- (void)dismiss
{
    [self removeFromSuperview];
    //[titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    //通知外界 自己被销毁
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)])
    {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self dismiss];
    /*
     事件监听 如果点击了该区域外的地方，该区域就被销毁
     */
}
- (void)setContent:(UIView *)content
{
    _content = content;
    
    // 调整内容的位置
    content.x = 10;
    content.y = 15;
    
    // 调整内容的宽度
    //    content.width = self.containerView.width - 2 * content.x;
    
    // 设置灰色的高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 11;
    // 设置灰色的宽度
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
    // 添加内容到灰色图片中
    [self.containerView addSubview:content];

}

@end
