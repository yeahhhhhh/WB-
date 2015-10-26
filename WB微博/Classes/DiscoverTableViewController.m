//
//  DiscoverTableViewController.m
//  WB微博
//
//  Created by 黄欣 on 15/7/18.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "UIView+Extension.h"
#import "SearchBar.h"
#import "UIImageView+WebCache.h"
@interface DiscoverTableViewController () <UITableViewDataSource,UISearchBarDelegate>

@end

@implementation DiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    SearchBar *searchBar = [SearchBar searchBar];//添加搜索栏 #import"SearchBar.h"
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.placeholder = @"dsfsadfsadadsf";
    searchBar.delegate = self;
    searchBar.height = 30;
    searchBar.width = 300;
    self.navigationItem.titleView = searchBar;
    self.tableView.tableFooterView=[[UIView alloc]init];//删除多余空cell关键语句
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

//设置有几个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//设置各个分组内的cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1)
    {
        return 5;
    }
    else {
        return 1;
    }
}
//设置cell内的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if (indexPath.section == 2) {
        cell.textLabel.text = @"清理内存";
        NSUInteger size = [SDImageCache sharedImageCache].getSize;
        NSString *str = [NSString stringWithFormat:@"%.1fMB",(size / 1024.0 /1024)];
        NSLog(@"%@",str);
        cell.detailTextLabel.text = str;
        cell.detailTextLabel.textColor = [UIColor orangeColor];
        return cell;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%li行",(long)indexPath.row];
    return cell;
}
//返回分组标题文字（上下标题）
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Header分组1";
    }else if(section == 1){
        return @"Header分组2";
    }else
    {
    
        return  @"Header分组3";
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        [[SDImageCache sharedImageCache ] clearDisk];
        [self.tableView reloadData];
    }
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
