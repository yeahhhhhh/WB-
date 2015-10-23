//
//  DetailedTableViewController.m
//  WB微博
//
//  Created by 黄欣 on 15/10/17.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "DetailedTableViewController.h"
#import "DetailedTableViewCell.h"
#import "DetailedFrame.h"
#import "UIBarButtonItem+Extension.h"
@interface DetailedTableViewController ()
@property (nonatomic, strong) DetailedFrame *detailedFrame;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;//手势
@end

@implementation DetailedTableViewController


-(void)setStatusModle:(statusModle______ *)statusModle
{
    _statusModle = statusModle;
    NSLog(@"%@",statusModle.text);
}
- (DetailedFrame *)detailedFrame
{
    if (!_detailedFrame)
    {
        self.detailedFrame = [[DetailedFrame alloc]init];
    }
    return _detailedFrame;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[[UIView alloc]init];//删除多余空cell关键语句
    

    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
//    self.view.backgroundColor = [UIColor orangeColor];
    [self setupNav];
}
/**
 * 设置导航栏内容
 */
- (void)setupNav
{
    
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemwithTarget:self action:@selector(cancel) image:@"navigationbar_back" Highimage:@"navigationbar_back_highlighted"];
    
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemwithTarget:self action:@selector(more) image:@"navigationbar_more" Highimage:@"navigationbar_more_highlighted"];

    self.tabBarController.tabBar.hidden = YES;
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}
/**
 *  取消
 */
- (void)cancel {
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}
/**
 *  更多
 */
- (void)more {
    NSLog(@"more");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@" %s view即将卸载",__FUNCTION__);
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailedTableViewCell *cell = [DetailedTableViewCell cellwithTableView:tableView];
     cell.statusModle = self.statusModle;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"heightForRowAtIndexPath %f",self.detailedFrame.cellhightF);
    return self.detailedFrame.cellhightF;
}
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
         [self.navigationController popViewControllerAnimated:YES];
        self.tabBarController.tabBar.hidden = NO;
    }
}


@end
