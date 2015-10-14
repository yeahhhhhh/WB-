//
//  HXEmotionListView.m
//  WB微博
//
//  Created by 黄欣 on 15/9/26.
//  Copyright (c) EmotionCount15年 黄欣. All rights reserved.
//

#import "HXEmotionListView.h"
#import "HXEmotionPageView.h"
//每个页面存放表情的数量
#define EmotionCount 20
// RGB颜色
#define HWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define HWRandomColor HWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface HXEmotionListView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) HXEmotionPageView *pagesView;
@end
@implementation HXEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //创建ScrollView 显示表情
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        self.scrollView = scrollView;
        //关闭弹簧效果
        scrollView.bounces = NO;
        //分页效果
        scrollView.pagingEnabled = YES;
        //关闭水平滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        //关闭垂直滚动条
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        
        
    
        [self addSubview:scrollView];
        
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        self.pageControl = pageControl;
        
        //设置内部的圆点图片 用到了　KVC
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal" ] forKey:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected" ] forKey:@"currentPageImage"];
        
        [self addSubview:pageControl];
        
        
    }
    return self;
}
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
  
    //删除之前的空件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    NSUInteger count = (self.emotions.count + EmotionCount - 1 ) /EmotionCount;
    //设置页数
    self.pageControl.numberOfPages = count ;//> 1? count : 0;//如果大于1 就是count 不大于1 就是0
    //创建用来显示每一页表情的容器
    for (int i = 0; i < count; i++) {
        HXEmotionPageView *pagesView = [[HXEmotionPageView alloc]init];
        self.pagesView = pagesView;
        //计算这一页的表情范围
        NSRange range ;
        range.location = i * EmotionCount;
        if (emotions.count - i * EmotionCount >= EmotionCount) {//如果大于EmotionCount说明还可以截取
            range.length = EmotionCount;
        }else {
            range.length = emotions.count - i * EmotionCount;//如果不可以，则剩多少截多少
        }
        
        
        //设置这一个分页的表情（1~EmotionCount 个）
        self.pagesView.emotion = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pagesView];
    }
    //从新排列
    [self setNeedsLayout];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;

    
    self.scrollView.x = self.scrollView.y = 0;
    self.scrollView.width = self.width;
    self.scrollView.height = self.height - self.pageControl.height;
   
    NSUInteger count = (self.emotions.count + EmotionCount - 1 ) /EmotionCount;
    //获得屏幕宽度
    
    for (int i =0; i < count; i ++) {
        HXEmotionPageView * pagesView = self.scrollView.subviews[i];
        pagesView.x = self.scrollView.width * i;
        pagesView.y = 0;
        pagesView.width = self.scrollView.width;
        pagesView.height = self.scrollView.height;
    }
    //内容尺寸设置  设置滑动的区间 （count个屏幕宽度区间 上下没有滑动）
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
    
}

#pragma mark - UIScrollViewDelegate
//监听翻页
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int) (page + 0.5);//设置四舍五入计算页码
}

@end
 