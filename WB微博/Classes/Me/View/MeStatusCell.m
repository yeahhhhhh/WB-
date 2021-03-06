
//
//  MeStatusCell.m
//  WB微博
//
//  Created by 黄欣 on 15/10/25.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "MeStatusCell.h"

#import "UIImageView+WebCache.h"
#import "userModle.h"
#import "statusModle(微博模型).h"
#import "statusPhotoModle.h"
#import "HXStatusToolBar.h"
#import "NSString+Extention.h"
#import "HXStatusPhotosView.h"
#import "HXiconView.h"
#import "MeStatusFrame.h"
@interface MeStatusCell()
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

/**工具条*/
@property (nonatomic, weak) HXStatusToolBar* toolbar;


@end
@implementation MeStatusCell

+ (instancetype)cellwithTableView:(UITableView *)tableView
{
    
    NSString *ID = @"cell";
    MeStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (!cell)
    {
        cell= [[MeStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                 reuseIdentifier:ID];
    }
    return cell;
}
/**
 * cell的初始化方法，一个cell只会调用一次
 * 在这里添加所有可能出现的字控件，以及子控件的一次性设置
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style  reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;//选中cell 后使cell无颜色变化
        //初始化原创微博
        [self setuporiginaView];
        //初始化转发微博
        [self setupRetweetView];
        
        //初始化工具条
        [self setupToolBar];
        
        
    }
    return self;
}
///**
// *  自定义frame 让所有的cell的y都往下15个单位
// */
//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y += 15;
//    [super setFrame:frame];
//}
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

/**
 *  初始化工具条
 */
- (void)setupToolBar
{
    //微博工具条整体
    HXStatusToolBar* toolbar = [HXStatusToolBar toolbar];
    //    toolbar.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
    
    
}
- (void)setMeStatusFrame:(MeStatusFrame *)meStatusFrame
{
    _meStatusFrame = meStatusFrame;
    
    statusModle______ *status = meStatusFrame.status;
    userModle *user = status.user;
    
    self.originaView.frame = meStatusFrame.originaViewF;
    self.originaView.backgroundColor = [UIColor whiteColor];
    //头像
    self.iconImage.frame = meStatusFrame.iconImageF;
    self.iconImage.user = user;
    //    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url]];
    
    
    //会员图标
    //    if ((int)user.mbtype ) {
    //        self.vipView.hidden = NO;
    self.vipView.frame = meStatusFrame.vipViewF;
    //        NSString *vipNmae = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
    self.vipView.image = [UIImage imageNamed:@"common_icon_membership_level1"];
    //    }
    //    else
    //    {
    //        self.vipView.hidden = YES;
    //    }
    //配图
    if (status.pic_urls.count) {
        self.photosView.frame = meStatusFrame.photoViewF;
        self.photosView.photos = status.pic_urls;//将微博配图数组传递给photos
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
    
    //昵称
    
    self.nameLable.frame = meStatusFrame.nameLableF;
    self.nameLable.text = user.name;
    
    
    
    //时间
    CGFloat timeX = meStatusFrame.nameLableF.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.meStatusFrame.nameLableF) ;
    CGSize  timeSize = [status.created_at sizeWithfont:HXStatusCellTimeFont];
    self.timeLable.frame =(CGRect){{timeX,timeY},timeSize};
    self.timeLable.text = status.created_at;
    
    //来源
    CGFloat sourceX =  CGRectGetMaxX((CGRect){{timeX,timeY},timeSize}) +  StatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize  sourceSize = [status.source sizeWithfont:HXStatusCellTimeFont];
    self.sourceLable.frame = (CGRect){{sourceX,sourceY},sourceSize};
    self.sourceLable.text = status.source;
    
    //    //时间
    //    self.timeLable.frame = statusFrame.timeLableF;
    //    self.timeLable.text = status.created_at;
    
    //来源
    
    //    self.sourceLable.frame = statusFrame.sourceLableF;
    //    self.sourceLable.text = status.source;
    
    //内容
    
    self.contentLable.frame = meStatusFrame.contentLableF;
    self.contentLable.text = status.text;
    
    if (status.retweeted_status) {
        
        self.retweetView.hidden = NO;//显示
        /**被转发微博整体*/
        self.retweetView.frame = meStatusFrame.retweetViewF;
        self.retweetView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        
        
        /**转发微博内容*/
        NSString *retweetContent = [NSString  stringWithFormat:@"@%@ : %@",status.retweeted_status.user.name , status.retweeted_status.text];
        self.retweetContentLable.frame = meStatusFrame.retweetContentLableF;
        self.retweetContentLable.text = retweetContent;
        
        /**转发微博图片*/
        if (status.retweeted_status.pic_urls.count){
            self.retweetPhotosView.frame = meStatusFrame.retweetPhotoViewF;
            self.retweetPhotosView.photos = status.retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;
        }else{
            self.retweetPhotosView.hidden = YES;//没有配图 隐藏
        }
        
    }else{
        self.retweetView.hidden = YES;//隐藏
    }
    self.toolbar.frame = meStatusFrame.toolbarF;
    self.toolbar.status = status;
}


@end
