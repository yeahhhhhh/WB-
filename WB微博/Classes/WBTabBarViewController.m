//
//  WBTabBarViewController.m
//  WB微博
//
//  Created by 黄欣 on 15/7/18.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "WBTabBarViewController.h"
#import "BastNavigationViewController.h"
#import "UIView+Extension.h"
#import "HXTabBar.h"//自定义的TabBar 用于添加  “＋”
#import "HomeMenuController.h"
@interface WBTabBarViewController ()

@end

@implementation WBTabBarViewController

- (void)viewDidLoad {
   //初始化子控制器
    HomeTableViewController *home = [[HomeTableViewController alloc]init];
    [self addchildVC:home title:@"首页" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
    
    MessageCenterTableViewController *messageCenter = [[MessageCenterTableViewController alloc]init];
    [self addchildVC:messageCenter title:@"消息" image:@"tabbar_message_center" selectImage:@"tabbar_message_center_selected"];
    
    DiscoverTableViewController *discover = [[DiscoverTableViewController alloc]init];
    [self addchildVC:discover title:@"发现" image:@"tabbar_discover" selectImage:@"tabbar_discover_selected"];
    
    ProfileTableViewController *profile= [[ProfileTableViewController alloc]init];
    [self addchildVC:profile title:@"我" image:@"tabbar_profile" selectImage:@"tabbar_profile_selected"];

    /*
     要在最下面那栏添加一个“＋”，因为位置不好调整 所以自定义来一个tabBar栏
     跟换系统自带的TabBar 因为 TabBar 是只读类型 所以不可以直接修改
     self.tabBar = [[HXTabBar alloc] init];
     
      //    Person *p = [[Person allooc] init]; －－－1
     //    p.name = @"jack";－－－2
     //    [p setValue:@"jack" forKeyPath:@"name"];－－－3
      3 的写法 等价于 2
     
     
     
     [student setValue:@"张三" forKey:@"name"];
     NSString *name = [student valueForKey:@"name"];
     NSLog(@"学生姓名:%@",name);
    */
    [self setValue:[[HXTabBar alloc] init] forKeyPath:@"tabBar"];
   
    

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addchildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image  selectImage:(NSString *)selectImage
{
    
    childVC.tabBarItem.title = title;
    childVC.navigationItem.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    //    这张图片不会被渲染，会显示原图
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //childVC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:(1)];
    //设置文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    
    textAttrs [NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:1];
    
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    selectTextAttrs [NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC .tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    BastNavigationViewController *nav = [[BastNavigationViewController alloc]initWithRootViewController:childVC];
    
    //添加控制器到tabbarviewcontrller
    [self addChildViewController:nav];
    
}

#pragma mark - HWTabBarDelegate代理方法
- (void)tabBarDidClickPlusButton:(HXTabBar *)tabBar
{
    HomeMenuController *vc = [[HomeMenuController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
