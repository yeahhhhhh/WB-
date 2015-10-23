//
//  DetailedTableViewCell.m
//  WB微博
//
//  Created by 黄欣 on 15/10/17.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "DetailedTableViewCell.h"
#import "DetailedFrame.h"
#import "HXStatusPhotosView.h"
#import "NSString+Extention.h"
#import "HXiconView.h"
@interface DetailedTableViewCell()<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic, strong) DetailedFrame * detailedFrame;

/**原创微博*/
@property (nonatomic, weak) UIView* originaView;
/**头像*/
@property (nonatomic, weak) HXiconView* iconImage;
/**会员图标*/
@property (nonatomic, weak) UIImageView* vipView;
/**配图*/
@property (nonatomic, weak) HXStatusPhotosView* photosView;
/**昵称*/
@property (nonatomic, weak) UILabel* nameLable;
/**时间*/
@property (nonatomic, weak) UILabel* timeLable;
/**来源*/
@property (nonatomic, weak) UILabel* sourceLable;
/**内容*/
@property (nonatomic, weak) UILabel* contentLable;

/**转发微博*/
@property (nonatomic, weak) UIView* retweetView;
/**转发微博内容*/
@property (nonatomic, weak) UILabel* retweetContentLable;
/**转发微博配图*/
@property (nonatomic, weak) HXStatusPhotosView* retweetPhotosView;
@end
@implementation DetailedTableViewCell

+ (instancetype)cellwithTableView:(UITableView *)tableView
{
    
    NSString *ID = @"cell";
    DetailedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (!cell)
    {
        cell= [[DetailedTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                 reuseIdentifier:ID];
    }
    return cell;
}
- (DetailedFrame *)detailedFrame
{
    if (!_detailedFrame)
    {
        self.detailedFrame = [[DetailedFrame alloc]init];
    }
    return _detailedFrame;
}
-(void)setStatusModle:(statusModle______ *)statusModle
{
    _statusModle = statusModle;
    self.detailedFrame.status = statusModle;
    

    
    statusModle______ *status = statusModle;
    userModle *user = status.user;
    
    self.originaView.frame = self.detailedFrame.originaViewF;
    self.originaView.backgroundColor = [UIColor whiteColor];
    //头像
    self.iconImage.frame = self.detailedFrame.iconImageF;
    self.iconImage.user = user;
    //    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url]];
    
    
    //会员图标
    //    if ((int)user.mbtype ) {
    //        self.vipView.hidden = NO;
//    self.vipView.frame = self.detailedFrame.vipViewF;
    //        NSString *vipNmae = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
//    self.vipView.image = [UIImage imageNamed:@"common_icon_membership_level1"];
    //    }
    //    else
    //    {
    //        self.vipView.hidden = YES;
    //    }
    //配图
    if (status.pic_urls.count) {
        self.photosView.frame = self.detailedFrame.photoViewF;
        self.photosView.photos = status.pic_urls;//将微博配图数组传递给photos
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
    
    //昵称
    
    self.nameLable.frame = self.detailedFrame.nameLableF;
    self.nameLable.text = user.name;
    
    
    
    //时间
    CGFloat timeX = 255;//CGRectGetMaxX(self.detailedFrame.nameLableF) + 6 * StatusCellBorderW;
    CGFloat timeY = self.detailedFrame.nameLableF.origin.y ;
    CGSize  timeSize = [status.created_at sizeWithfont:HXStatusCellTimeFont];
    self.timeLable.frame =(CGRect){{timeX,timeY},timeSize};
    self.timeLable.text = status.created_at;
    self.timeLable.textColor = [UIColor blueColor];
    //来源
    CGFloat sourceX =  self.detailedFrame.nameLableF.origin.x +  StatusCellBorderW;
    CGFloat sourceY = CGRectGetMaxY(self.detailedFrame.nameLableF) +  StatusCellBorderW;
    CGSize  sourceSize = [status.source sizeWithfont:HXStatusCellTimeFont];
    self.sourceLable.frame = (CGRect){{sourceX,sourceY},sourceSize};
    self.sourceLable.text = status.source;
    //内容
    
    self.contentLable.frame = self.detailedFrame.contentLableF;
    self.contentLable.text = status.text;
    
    if (status.retweeted_status) {
        
        self.retweetView.hidden = NO;//显示
        /**被转发微博整体*/
        self.retweetView.frame = self.detailedFrame.retweetViewF;
        self.retweetView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        
        
        /**转发微博内容*/
        NSString *retweetContent = [NSString  stringWithFormat:@"@%@ : %@",status.retweeted_status.user.name , status.retweeted_status.text];
        self.retweetContentLable.frame = self.detailedFrame.retweetContentLableF;
        self.retweetContentLable.text = retweetContent;
        
        /**转发微博图片*/
        if (status.retweeted_status.pic_urls.count){
            self.retweetPhotosView.frame = self.detailedFrame.retweetPhotoViewF;
            self.retweetPhotosView.photos = status.retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;
        }else{
            self.retweetPhotosView.hidden = YES;//没有配图 隐藏
        }
        
    }else{
        self.retweetView.hidden = YES;//隐藏
    }
}
/**
 * cell的初始化方法，一个cell只会调用一次
 * 在这里添加所有可能出现的字控件，以及子控件的一次性设置
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style  reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化原创微博
        [self setuporiginaView];
        //初始化转发微博
        [self setupRetweetView];
        
        CGFloat x = 0;
        CGFloat y = 80;
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        CGFloat h = self.detailedFrame.cellhightF;
        NSLog(@"%f",h);
        self.frame = CGRectMake(x, y, w, h);
        
        self.backgroundColor = [UIColor redColor];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;//选中cell 后使cell无颜色变化
        
    }
    return self;
}
/**
 *  初始化原创微博
 */
- (void)setuporiginaView
{
    UIView* originaView = [[UIView alloc]init];
    [self.contentView addSubview:originaView];
    self.originaView = originaView;
    //头像
    HXiconView* iconImage = [[HXiconView alloc]init];
    [originaView addSubview:iconImage];
    self.iconImage = iconImage;
    //会员图标
    UIImageView* vipView = [[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [originaView addSubview:vipView];
    self.vipView = vipView;
    //配图
    HXStatusPhotosView* photosView = [[HXStatusPhotosView alloc]init];
    [originaView addSubview:photosView];
    self.photosView = photosView;
    //昵称
    UILabel* nameLable = [[UILabel alloc]init];
    [originaView addSubview:nameLable];
    nameLable.font = HXStatusCellNameFont;
    self.nameLable = nameLable;
    //时间
    UILabel* timeLable = [[UILabel alloc]init];
    [originaView addSubview:timeLable];
    self.timeLable = timeLable;
    timeLable.font = HXStatusCellTimeFont;
    //来源
    UILabel* sourceLable = [[UILabel alloc]init];
    [originaView addSubview:sourceLable];
    self.sourceLable = sourceLable;
    sourceLable.font = HXStatusCellSourceFont;
    
    //内容
    UILabel* contentLable = [[UILabel alloc]init];
    contentLable.numberOfLines = 0;
    [originaView addSubview:contentLable];
    self.contentLable = contentLable;
    contentLable.font = HXStatusCellContentFont;
}
/**
 *  初始化转发微博
 */
- (void)setupRetweetView
{
    //转发微博整体
    UIView* retweetView = [[UIView alloc]init];
    //retweetView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    //昵称＋内容
    UILabel* retweetContentLable = [[UILabel alloc]init];
    retweetContentLable.numberOfLines = 0;
    [retweetView addSubview:retweetContentLable];
    self.retweetContentLable = retweetContentLable;
    retweetContentLable.font = HXStatusCellretweetContentFont;
    
    //转发微博配图
    HXStatusPhotosView* retweetPhotosView = [[HXStatusPhotosView alloc]init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
    
}

@end
