//
//  HXStatusToolBar.m
//  WB微博
//
//  Created by 黄欣 on 15/9/15.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXStatusToolBar.h"
#import "UIView+Extension.h"
#import "statusModle(微博模型).h"
@interface HXStatusToolBar()
/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;

/**微博评论按钮*/
@property (nonatomic, weak) UIButton *retweetBtn;

/**微博转发按钮*/
@property (nonatomic, weak) UIButton *commentBtn;

/**微博评赞按钮*/
@property (nonatomic, weak) UIButton *unlikeBtn;
@end

@implementation HXStatusToolBar

- (NSMutableArray *)btns
{
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

+ (instancetype)toolbar
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
       self.retweetBtn = [self setupBtn:@"timeline_icon_retweet" title:@"转发 "];
       self.commentBtn = [self setupBtn:@"timeline_icon_comment" title:@"评论"];
       self.unlikeBtn = [self setupBtn:@"timeline_icon_unlike" title:@"赞"];
        // 添加分割线
        [self setupDivider];
        
        [self setupDivider];
    }
    return self;
}
/**
 * 添加分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}
/**
 *  初始化按钮
 *
 *  @param icon  图片
 *  @param title 标题
 */
- (UIButton *)setupBtn:(NSString *)icon title:(NSString *)title
{
    UIButton *Btn = [[UIButton alloc]init];
    Btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [Btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [Btn setTitle:title forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:Btn];
    [self.btns addObject:Btn];
    return Btn;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)self.btns.count;
    NSLog(@"%d",count);
    CGFloat btnW = self.width / count;
    
    
    for (int i = 0; i <count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = btnW * i;
        btn.width = btnW;
        btn.height = self.height;
    }
    
    // 设置分割线的frame
    int dividerCount = (int)self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = self.height;
        divider.x = (i + 1) * btnW;
        divider.y = 0;
    }
}

- (void)setStatus:(statusModle______ *)status
{
    _status = status;
//    if (status.reposts_count) {
//        NSString *string = [NSString stringWithFormat:@"%d",status.reposts_count];
//        [self.retweetBtn setTitle:string forState:UIControlStateNormal];
//    }else
//    {
//        [self.retweetBtn setTitle:@"转发 " forState:UIControlStateNormal];
//        
//    }
//    
//    if (status.comments_count) {
//        NSString *string = [NSString stringWithFormat:@"%d",status.comments_count];
//        [self.commentBtn setTitle:string forState:UIControlStateNormal];
//    }else
//    {
//        [self.commentBtn setTitle:@"评论 " forState:UIControlStateNormal];
//        
//    }
//    
//    if (status.attitudes_count) {
//        NSString *string = [NSString stringWithFormat:@"%d",status.attitudes_count];
//        [self.unlikeBtn setTitle:string forState:UIControlStateNormal];
//    }else
//    {
//        [self.unlikeBtn setTitle:@"赞 " forState:UIControlStateNormal];
//        
//    }
//    [self setupTitle:@"赞 " count:status.attitudes_count Btn:self.unlikeBtn];
//    [self setupTitle:@"评论 " count:status.comments_count Btn:self.commentBtn];
//    [self setupTitle:@"转发 " count:status.reposts_count Btn:self.retweetBtn];
    
}

//- (void)setupTitle:(NSString *)title count:(int)count Btn:(UIButton *)Btn
//{
//    if (count) {
//        NSString *title = [NSString stringWithFormat:@"%d",count];
//        [Btn setTitle:title forState:UIControlStateNormal];
//    }else
//    {
//        [Btn setTitle:title forState:UIControlStateNormal];
//        
//    }
//}






@end
