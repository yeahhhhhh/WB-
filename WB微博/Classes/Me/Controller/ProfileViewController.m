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
void *CusomHeaderInsetObserver = &CusomHeaderInsetObserver;
@interface ProfileViewController ()

@end

@implementation ProfileViewController
-(instancetype)init
{
   
    TableViewController *table = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    CollectionViewController *collectionView = [[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil];
    
    
    self = [super initWithControllers:table,collectionView, nil];
    if (self) {
        // your code
        self.segmentMiniTopInset = 64;
    }
    
    return self;
}

#pragma mark - override

-(UIView<ARSegmentPageControllerHeaderProtocol> *)customHeaderView
{
    CustomHeader *view = [[[NSBundle mainBundle] loadNibNamed:@"CustomHeader" owner:nil options:nil] lastObject];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    [self addObserver:self forKeyPath:@"segmentToInset" options:NSKeyValueObservingOptionNew context:CusomHeaderInsetObserver];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
