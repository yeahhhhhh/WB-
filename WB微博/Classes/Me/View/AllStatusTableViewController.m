//
//  AllStatusTableViewController.m
//  WB微博
//
//  Created by 黄欣 on 15/10/26.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import "AllStatusTableViewController.h"
#import "statusModle(微博模型).h"
#import "MeStatusFrame.h"
#import "MeStatusCell.h"
#import "UIImageView+WebCache.h"
#import "AccountTool.h"
#import "AFNetworking.h"
@interface AllStatusTableViewController ()
@property (nonatomic, strong) NSMutableArray* meStatusFrames;//(微博模型) 里面存放的meStatusFrame(微博模型) 每一个meStatusFrame(微博模型)代表一个微博
@end

@implementation AllStatusTableViewController
- (NSMutableArray *)meStatusFrames
{
    if (!_meStatusFrames)
    {
        self.meStatusFrames = [[NSMutableArray alloc]init];
    }
    return _meStatusFrames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUserstatus];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView=[[UIView alloc]init];//删除多余空cell关键语句
}
//获取当前用户发送的所有微博 获取自己的微博，参数uid与screen_name可以不填，则自动获取当前登录用户的微博；
- (void)setupUserstatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // AFN的AFJSONResponseSerializer默认不接受text/plain这种类型
    
    // 2.拼接请求参数
    Account * account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //    params[@"uid"] = account.uid;
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/user_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {
         NSLog(@"请求成功-%@", responseObject);
         
         NSArray *array = [statusModle______ objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         //
         
         NSArray *newFreams = [self meStatusFrameWithStatuses:array];
         
         [self.meStatusFrames addObjectsFromArray:newFreams];
         
         [self.tableView reloadData];//刷新表格
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"请求失败-%@", error);
         
     }];
}
- (NSArray *)meStatusFrameWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (statusModle______ *status in statuses) {
        MeStatusFrame *f = [[MeStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
     return self.meStatusFrames.count;
}

-(NSString *)segmentTitle
{
    return @"全部";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获得cell
        MeStatusCell *cell = [MeStatusCell cellwithTableView:tableView];
        NSLog(@"%@",self.meStatusFrames[indexPath.row]);
        cell.meStatusFrame = self.meStatusFrames[indexPath.row];
    
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
