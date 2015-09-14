//
//  HXStatusCell.m
//  WB微博
//
//  Created by 黄欣 on 15/9/2.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HXStatusCell.h"
#import "statusFrame.h"
#import "UIImageView+WebCache.h"
#import "userModle.h"
#import "statusModle(微博模型).h"
#import "statusFrame.h"
#import "statusPhotoModle.h"
#define HWStatusCellBorderW 10

@interface HXStatusCell()
//原创微博
@property (nonatomic, weak) UIView* originaView;
//头像
@property (nonatomic, weak) UIImageView* iconImage; 
//会员图标
@property (nonatomic, weak) UIImageView* vipView;
//配图
@property (nonatomic, weak) UIImageView* photoView;
//昵称
@property (nonatomic, weak) UILabel* nameLable;
//时间
@property (nonatomic, weak) UILabel* timeLable;
//来源
@property (nonatomic, weak) UILabel* sourceLable;
//内容
@property (nonatomic, weak) UILabel* contentLable;

@end
@implementation HXStatusCell

+ (instancetype)cellwithTableView:(UITableView *)tableView
{
    
    NSString *ID = @"cell";
    HXStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (!cell)
    {
        cell= [[HXStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle
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
        
        UIView* originaView = [[UIView alloc]init];
        
        //originaView.backgroundColor = [UIColor yellowColor];
        
        [self.contentView addSubview:originaView];
        self.originaView = originaView;
        //头像
        UIImageView* iconImage = [[UIImageView alloc]init];
        [originaView addSubview:iconImage];
        self.iconImage = iconImage;
        //会员图标
        UIImageView* vipView = [[UIImageView alloc]init];
        vipView.contentMode = UIViewContentModeCenter;
        [originaView addSubview:vipView];
        self.vipView = vipView;
        //配图
        UIImageView* photoView = [[UIImageView alloc]init];
        [originaView addSubview:photoView];
        self.photoView = photoView;
        //昵称
        UILabel* nameLable = [[UILabel alloc]init];
        [originaView addSubview:nameLable];
        nameLable.font = HWStatusCellNameFont;
        self.nameLable = nameLable;
        //时间
        UILabel* timeLable = [[UILabel alloc]init];
        [originaView addSubview:timeLable];
        self.timeLable = timeLable;
        timeLable.font = HWStatusCellTimeFont;
        //来源
        UILabel* sourceLable = [[UILabel alloc]init];
        [originaView addSubview:sourceLable];
        self.sourceLable = sourceLable;
        sourceLable.font = HWStatusCellSourceFont;
        
        //内容
        UILabel* contentLable = [[UILabel alloc]init];
        contentLable.numberOfLines = 0;
        [originaView addSubview:contentLable];
        self.contentLable = contentLable;
        contentLable.font = HWStatusCellContentFont;
        
    }
    return self;
}

- (void)setStatusFrame:(statusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    statusModle______ *status = statusFrame.status;
    userModle *user = status.user;
    
    self.originaView.frame = statusFrame.originaViewF;
    //头像
    self.iconImage.frame = statusFrame.iconImageF;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
//    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url]];
    
    
    //会员图标
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipNmae = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipNmae];
    }
    else
    {
        self.vipView.hidden = YES;
    }
    //配图
    if (status.pic_urls.count) {
        self.photoView.frame = statusFrame.photoViewF;
        statusPhotoModle *photo = [status.pic_urls firstObject];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden = NO;
    }else{
        self.photoView.hidden = YES;
    }
    
    //昵称

    self.nameLable.frame = statusFrame.nameLableF;
    self.nameLable.text = user.name;
    


    //时间

    self.timeLable.frame = statusFrame.timeLableF;
    self.timeLable.text = status.created_at;
    
    //来源

    self.sourceLable.frame = statusFrame.sourceLableF;
    self.sourceLable.text = status.source;
    
    //内容

    self.contentLable.frame = statusFrame.contentLableF;
    self.contentLable.text = status.text;

    
}


@end
