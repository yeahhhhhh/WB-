//
//  Text1ViewController.m
//  WB微博
//
//  Created by 黄欣 on 15/7/19.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "Text1ViewController.h"

@interface Text1ViewController ()

@end

@implementation Text1ViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    UIView *view1 = [[UIView alloc]init];
    view1.frame = [UIScreen mainScreen].bounds;
    //view1.frame = CGRectMake(300, 48, 48, 48);
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    
   
   
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"sad" style:0 target:nil action:nil  ];
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
