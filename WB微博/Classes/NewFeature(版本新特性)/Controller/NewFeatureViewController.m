//
//  NewFeatureViewController.m
//  WB微博
//
//  Created by 黄欣 on 15/7/26.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "UIView+Extension.h"
#import "WBTabBarViewController.h"
@interface NewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建ScrollView 显示所有新特性的图片
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(4 * scrollView.width, 0);//内容尺寸设置  设置滑动的区间 （4个屏幕宽度区间 上下没有滑动）
    [self.view addSubview:scrollView];
    for (int i = 0; i < 4; i++) {
        UIImageView *imageview = [[UIImageView alloc]init];
        imageview.size = scrollView.size;
        imageview.y = 0;
        imageview.x = i * imageview.width;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageview.image = [UIImage imageNamed:name];
        
        [scrollView addSubview:imageview];
        if (i == 3)
        {
            imageview.userInteractionEnabled = YES;//开启交互功能
            UIButton *shareBut = [[UIButton alloc]init];
            [shareBut setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
            [shareBut setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
            [shareBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [shareBut setTitle:@"分享到微博" forState:UIControlStateNormal];
            shareBut.titleLabel.font = [UIFont systemFontOfSize:13];
            
            shareBut.centerX = scrollView.width * 0.33;
            shareBut.centerY = scrollView.height * 0.65;
            shareBut.width = 100;
            shareBut.height = 40;
            [imageview addSubview:shareBut];
            [shareBut addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIButton *startBut = [[UIButton alloc]init];
            [startBut setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
            [startBut setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateSelected];
            [startBut setTitle:@"进入微博" forState:UIControlStateNormal];
            startBut.titleLabel.font = [UIFont systemFontOfSize:15];
//            startBut.size = startBut.currentBackgroundImage.size;
            startBut.centerX = scrollView.width * 0.35;
            startBut.centerY = scrollView.height * 0.73;
            startBut.width = 100;
            startBut.height = 40;
            [imageview addSubview:startBut];
            [startBut addTarget:self action:@selector(startButAction) forControlEvents:UIControlEventTouchUpInside];
            
            
            
//            shareBut.backgroundColor = [UIColor yellowColor];
//            shareBut.titleLabel.backgroundColor =[UIColor redColor];
//            shareBut.imageView.backgroundColor =[UIColor greenColor];
//            shareBut.contentEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 0);
//            shareBut.imageEdgeInsets =UIEdgeInsetsMake(0, 0, 0, 0);
            shareBut.titleEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);//设置  shareBut 到图片与文字之间的距离 UIEdgeInsetsMake（上 左 下 右）
        }
    }
    
    
    scrollView.bounces = NO;//关闭弹簧效果
    scrollView.pagingEnabled = YES;//分页效果
    scrollView.showsHorizontalScrollIndicator = NO;//关闭滚动条
    
    scrollView.delegate = self;
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = 4;
    //设置 橘红色 和 灰色 点
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:198/256.0 green:198/256.0 blue:198/256.0 alpha:1];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:253/256.0 green:98/256.0 blue:42/256.0 alpha:1];
    //pageControl.userInteractionEnabled = NO;//
    pageControl.centerX = scrollView.width * 0.5 - 50;
    pageControl.centerY = 500;
    pageControl.width = 100;
//    pageControl.height = 60; //可以不设置他的宽高

    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}
- (void)shareAction:(UIButton *)shareBut
{
    //状态取反
    shareBut.selected = !shareBut.isSelected;
}
- (void)startButAction
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;//获取到当前窗口
                        
    UITabBarController *tabbarVC = [[WBTabBarViewController alloc]init];
    window.rootViewController = tabbarVC;
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int) (page + 0.5);//设置四舍五入计算页码
}




@end
