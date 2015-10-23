//
//  ProfileTableViewController.m
//  WB微博
//
//  Created by 黄欣 on 15/7/18.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "HXDropdownMenu.h"
#import "UIView+Extension.h"
#import "HomeMenuController.h"
#import "OTCover.h"
@interface ProfileTableViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (nonatomic ,strong)UIButton *c;//---------
@end

@implementation ProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    OTCover *test = [[OTCover alloc] initWithTableViewWithHeaderImage:[UIImage imageNamed:@"image.png"] withOTCoverHeight:200 withTableViewStyle:UITableViewStylePlain];
    test.tableView.delegate = self;
    test.tableView.dataSource = self;
    [self.view addSubview:test];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:(0) target:self  action:@selector(titleClick:) ];
    UIButton *c = [[UIButton alloc]init];
    c.height = 20;
    c.width = 35;
    [self.view addSubview:c];
    c.backgroundColor = [UIColor orangeColor];
    self.c = c;//-----
    self.navigationItem.titleView = c;
}
- (void)titleClick:(UIButton *)c
{
    //创建下啦菜单
    HXDropdownMenu *menu = [HXDropdownMenu menu];//这是类方法
    //显示菜单
    //menu.content = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    HomeMenuController *hcc = [[HomeMenuController alloc]init];
    hcc.view.width = 150;
    hcc.view.height = 200;
    menu.contentController = hcc;
    [menu showFrom:self.c];//--------
}
/*
 
 三个------处必须这么写
 
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d",indexPath.row + 1];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
