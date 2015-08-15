//
//  BastNavigationViewController.m
//  WB微博
//
//  Created by 黄欣 on 15/7/19.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "BastNavigationViewController.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
@interface BastNavigationViewController ()

@end

@implementation BastNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (void)initialize
{
    //普通状态
    //设置整个item所有样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1)
    {
        
//        //设置左上角的按钮 选中时与未选时 （自定义按钮）
//        UIButton *backbut = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backbut setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
//        [backbut setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
//        //设置 leftBarButtonItem 大小
//        //    CGSize size = back.currentBackgroundImage.size;
//        //    back.frame = CGRectMake(0, 0, size.width, size.height);
//        backbut.size = backbut.currentBackgroundImage.size;
//        //事件监听
//        [backbut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside ];
//        [morebut addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside ];    
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemwithTarget:self action:@selector(back) image:@"navigationbar_back" Highimage:@"navigationbar_back_highlighted"];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemwithTarget:self action:@selector(more) image:@"navigationbar_more" Highimage:@"navigationbar_more_highlighted"];
    }
    
}
- (void)back
{
    [self popViewControllerAnimated:YES];
    
}
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
