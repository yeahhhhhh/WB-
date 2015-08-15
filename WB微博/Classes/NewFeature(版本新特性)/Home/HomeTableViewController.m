//
//  HomeTableViewController.m
//  WB微博
//
//  Created by 黄欣 on 15/7/18.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "HomeTableViewController.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "SearchBar.h"
#import "HXDropdownMenu.h"
#import "HomeMenuController.h"
#import "AFNetworking.h"
#import "AccountTool.h"

@interface HomeTableViewController ()<HXDropdownMenuDelegate>

@end

@implementation HomeTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    //[self setupUserInfo];
    
    
}


/**
 *  获取用户信息
 */
- (void)setupUserInfo
{
    /*
     https://api.weibo.com/2/users/show.json
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     uid	false	int64	需要查询的用户ID。
     
     */
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // AFN的AFJSONResponseSerializer默认不接受text/plain这种类型
    
    // 2.拼接请求参数
    Account * account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;

    
    // 3.发送请求
    
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {
         //NSLog(@"请求成功-%@", responseObject);
         //获取名字
         NSString *name = responseObject[@"name"];
         // 标题按钮
         UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
         [titleButton setTitle:name forState:UIControlStateNormal];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"请求失败-%@", error);
         
     }];
}

/**
 *  设置导航栏内容
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemwithTarget:self action:@selector(pop) image:@"navigationbar_pop" Highimage:@"navigationbar_pop_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemwithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" Highimage:@"navigationbar_friendsearch_highlighted"];
    
    //导航栏中间按钮
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];//UIButton *titleButton = [[UIButton alloc]init];写法等价
    titleButton.width = 250;
    titleButton.height = 30;
    //titleButton.backgroundColor = [UIColor blueColor];
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    CGFloat titleW = titleButton.titleLabel.width * [UIScreen mainScreen].scale;
    CGFloat imageW = titleButton.imageView.width * [UIScreen mainScreen].scale;//乘以scale系数 保证retina频幕上宽度正确
    CGFloat left = titleW + imageW;
    titleButton.imageView.backgroundColor = [UIColor redColor];
    //titleButton.titleLabel.backgroundColor = [UIColor yellowColor];
    NSLog(@"%f %f ",titleW,imageW);
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
    //titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, imageW);
    //添加监听
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}
- (void)titleClick:(UIButton *)titleButton
{
    //创建下啦菜单
    HXDropdownMenu *menu = [HXDropdownMenu menu];//这是类方法
    menu.delegate = self;
    //显示菜单
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    HomeMenuController *c = [[HomeMenuController alloc]init];
    c.view.height = 200;
    c.view.width = 150;
    menu.contentController = c;
    [menu showFrom:titleButton];//方法
}
//下拉菜单被销毁了
-(void)dropdownMenuDidDismiss:(HXDropdownMenu *)menu
{
    UIButton *titlebtn =(UIButton *) self.navigationItem.titleView;
     [titlebtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

- (void)friendsearch
{
    NSLog(@"friendsearch");
    
}
- (void)pop
{
    NSLog(@"pop");
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
