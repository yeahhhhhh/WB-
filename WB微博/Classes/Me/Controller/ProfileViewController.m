//
//  ProfileViewController.m
//  WB微博
//
//  Created by 黄欣 on 15/10/18.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "ProfileViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"
#import "UIImage+ImageEffects.h"
#import "CustomHeader.h"
#import "AccountTool.h"
#import "AFNetworking.h"
#import "userModle.h"
#import "MJExtension.h"
#import <Accelerate/Accelerate.h>//实现模糊
#import "UIImageView+WebCache.h"

#import "AllStatusTableViewController.h"
void *CusomHeaderInsetObserver = &CusomHeaderInsetObserver;
@interface ProfileViewController ()
@property (nonatomic, strong)  CustomHeader *customHeader;
@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
}


-(instancetype)init
{
    AllStatusTableViewController * table1 = [[AllStatusTableViewController alloc]init];
    TableViewController *table = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    CollectionViewController *collectionView = [[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil];
    
    
    self = [super initWithControllers:table,collectionView,table1, nil];
    if (self) {
        // your code
        self.segmentMiniTopInset = 64;
    }
    
    return self;
}

#pragma mark - override

-(UIView<ARSegmentPageControllerHeaderProtocol> *)customHeaderView
{
    
    
     CustomHeader *customHeader = [[[NSBundle mainBundle] loadNibNamed:@"CustomHeader" owner:nil options:nil] lastObject];
    self.customHeader = customHeader;
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 2.拼接请求参数
    Account * account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {
         userModle *user = [userModle objectWithKeyValues:responseObject];
         
         NSString *name = user.avatar_hd;
         NSURL *url = [NSURL URLWithString:name];
         NSData *data = [NSData dataWithContentsOfURL:url];
         UIImage *image = [UIImage imageWithData:data];
         
         //调用方法实现图片模糊
         self.customHeader.imageView.image =[self blurryImage:image withBlurLevel:0.2];
         
         
         //将iconImage设置为圆形
         self.customHeader.iconImage.layer.masksToBounds=YES;
         self.customHeader.iconImage.layer.cornerRadius= 75/2.0f; //设置为图片宽度的一半出来为圆形
         self.customHeader.iconImage.layer.borderWidth=0.0f; //边框宽度
         self.customHeader.iconImage.layer.borderColor=[[UIColor whiteColor] CGColor];//边框颜色
         
         
         //设置iconImage图片
         [self.customHeader.iconImage sd_setImageWithURL:[NSURL URLWithString:user.avatar_large] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
         
         
         NSString *followers = [NSString stringWithFormat:@"粉丝%i", user.followers_count];
         NSString *friends = [NSString stringWithFormat:@"关注%i", user.friends_count];
         NSString *statuses = [NSString stringWithFormat:@"微博%i", user.statuses_count];
        
         [self.customHeader.but1 setTitle:followers forState:UIControlStateNormal];
         [self.customHeader.but2 setTitle:friends forState:UIControlStateNormal];
         [self.customHeader.but3 setTitle:statuses forState:UIControlStateNormal];
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"请求失败-%@", error);
         
     }];
    
    return customHeader;
}




-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    if (context == CusomHeaderInsetObserver) {
        CGFloat inset = [change[NSKeyValueChangeNewKey] floatValue];
        NSLog(@"2222222222222222222222inset is %f",inset);

        UIButton * but = [[UIButton alloc]init];
        CGAffineTransform  transform = but.transform;
        but.transform = CGAffineTransformTranslate(transform, 10, 10);
    }
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"segmentToInset"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  使用 CoreImage 实现图片模糊
    通过查找参考资料,发现 iOS5.0中新增了vImage API可以使用，它属于Accelerate.Framework，模糊算法使用的是vImageBoxConvolve_ARGB8888这个函数
 *  @return 
 */
-(UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
@end
