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
#import "HXTitleButton.h"
#import "UIImageView+WebCache.h"
#import "userModle.h"
#import "statusModle(微博模型).h"
#import "MJExtension.h"
#import "LodeMoreFooter(下拉加载).h"
#import "HXStatusCell.h"
#import "statusFrame.h"
@interface HomeTableViewController ()<HXDropdownMenuDelegate>
@property (nonatomic, strong) NSMutableArray* statuses;//(微博模型) 里面存放的statusFrame(微博模型) 每一个statusFrame(微博模型)代表一个微博
@end
@implementation HomeTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    [self setupNav];
    //获取用户信息
    [self setupUserInfo];
    
    //[self loadNewSttus];
    
    //集成下拉刷新控件
    [self setDownRefresh];
    
    // 获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setStatusCount) userInfo:nil repeats:YES];
    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //集成上拉刷新控件
    [self setupRefresh];
}
/**
 * 集成刷新控件 下拉
 */
- (void)setDownRefresh
{
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    
    [control addTarget:self action:@selector(Refresh:) forControlEvents:UIControlEventValueChanged];
    control.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新......"];
    [self.tableView addSubview:control] ;
    //进入刷新状态 但不会刷新数据
    [control beginRefreshing];
    //调用方法刷新数据
    [self Refresh:control];
}
/**
 * 集成刷新控件 上拉
 */
- (void)setupRefresh
{
    LodeMoreFooter______ *footer = [LodeMoreFooter______ footer];
    self.tableView.tableFooterView = footer;
}
/**
 * 获得微博未读数
 */
- (void)setStatusCount
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 2.拼接请求参数
    Account * account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    // 3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {
         NSString *status = [responseObject[@"status"] description];
         if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
             self.tabBarItem.badgeValue = nil;
             [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
         } else { // 非0情况
             self.tabBarItem.badgeValue = status;
             [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
         }
         //NSLog(@"请求成功-%@", _statuses);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"请求失败-%@", error);
     }];
    
}

/**
 * UIRefreshControl 进入刷新状态
 */
- (void)Refresh:(UIRefreshControl*)control
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // AFN的AFJSONResponseSerializer默认不接受text/plain这种类型
    
    // 2.拼接请求参数
    Account * account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出最前面的微博 （最新的微博ID最大的微博）
    statusModle______ *firetStatus = [self.statuses firstObject];
    if (firetStatus) {
        params[@"since_id"] = firetStatus.idstr;
    }
    
    //    params[@"count"] = @1;
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {
         NSArray *array = [statusModle______ objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         
//         NSMutableArray *newFreams = [NSMutableArray array];
//         for (statusModle______ * status in array) {
//             statusFrame *f = [[statusFrame alloc]init];
//             f.status = status;
//             [newFreams addObject:f];
//         }
         
         
         NSRange range = NSMakeRange(0, array.count);
         NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
         
         [self.statuses insertObjects:array atIndexes:set];//插到最前面
         [self.tableView reloadData];//刷新表格
         [control endRefreshing];
         NSLog(@"请求成功-%@", responseObject);
         
         //显示微博刷新数量
         [self showNewStatusCount:array.count];
         self.tabBarItem.badgeValue = nil;
         [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
         
         
    
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"请求失败-%@", error);
         [control endRefreshing];
     }];
    
}

- (NSMutableArray *)statuses
{
    if (!_statuses)
    {
        self.statuses = [[NSMutableArray alloc]init];
    }
    return _statuses;
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
         userModle *user = [userModle objectWithKeyValues:responseObject];
         
         NSString *name = user.name;
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
    HXTitleButton *titleButton = [HXTitleButton buttonWithType:UIButtonTypeCustom];//UIButton *titleButton = [[UIButton alloc]init];写法等价
//    titleButton.width = 250;
//    titleButton.height = 30;
    //titleButton.backgroundColor = [UIColor blueColor];
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    
//    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
//    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    CGFloat titleW = titleButton.titleLabel.width * [UIScreen mainScreen].scale;
//    CGFloat imageW = titleButton.imageView.width * [UIScreen mainScreen].scale;//乘以scale系数 保证retina频幕上宽度正确
//    CGFloat left = titleW + imageW;
//    titleButton.imageView.backgroundColor = [UIColor redColor];
//    //titleButton.titleLabel.backgroundColor = [UIColor yellowColor];
//    NSLog(@"%f %f ",titleW,imageW);
//    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
    //titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, imageW);
    //添加监听
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}
/**
 * 导航栏中间按钮的监听方法
 */
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
/**
 * 下拉菜单被销毁了
 */
-(void)dropdownMenuDidDismiss:(HXDropdownMenu *)menu
{
    UIButton *titlebtn =(UIButton *) self.navigationItem.titleView;
     [titlebtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}
/**
 * 加载最新的微博数据
 */
- (void) loadNewSttus
{

    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // AFN的AFJSONResponseSerializer默认不接受text/plain这种类型
    
    // 2.拼接请求参数
    Account * account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
//    params[@"count"] = @1;
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {
         /**
         //取得微博字典数组
         NSArray *dictArray = responseObject[@"statuses"];
         //将字典转换为模型
         for (NSDictionary *dict in dictArray) {
             
             statusModle______ *status = [statusModle______ objectWithKeyValues:dict];
             [self.statuses addObject:status ];
         }
       
          *写法与上面等价，responseObject[@"statuses"]是个大数组，数组中各项值为字典，将这些字典利用for循环取出进行模型准换存入statuses。这个写法利用数组直接进行模型转换
          *self.statuses = [statusModle______ objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
          **/
         
         NSArray *array = [statusModle______ objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         //
//         NSMutableArray *newFreams = [NSMutableArray array];
//         for (statusModle______ * status in array) {
//             statusFrame *f = [[statusFrame alloc]init];
//             f.status = status;
//             [newFreams addObject:f];
//         }
         [self.statuses addObjectsFromArray:array];
         [self.tableView reloadData];//刷新表格
         //NSLog(@"请求成功-%@", _statuses);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"请求失败-%@", error);
         
     }];
}
/**
 * 显示微博刷新数量
 */
- (void)showNewStatusCount:(int )count
{
    //创建lable
    UILabel *lable = [[UILabel alloc]init];
    lable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    lable.width = [UIScreen mainScreen].bounds.size.width;
    lable.height = 35;
    
    //设置其他属性
    if (count == 0 ) {
        lable.text = @"暂时没有新的微博数据。";
    }
    else{
        
        lable.text = [NSString stringWithFormat:@"共有%i条微博",count];
    }
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont systemFontOfSize:16];
    
    //添加
    lable.y = 64 - lable.height;
    //将lable 添加到导航控制器中 并盖在了导航兰下面
    [self.navigationController.view insertSubview:lable belowSubview:self.navigationController.navigationBar];
    CGFloat duration = 1.0;//动画执行时间
    CGFloat delay = 0.0;//延迟时间
    [UIView animateWithDuration:duration animations:^{
        
        lable.y += lable.height;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            lable.y -= lable.height;
        } completion:^(BOOL finished) {
            [lable removeFromSuperview];
        }];
    }];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {//组
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {//行
#warning Incomplete method implementation.
    //NSLog(@"%lu",(unsigned long)self.statuses.count);
    return self.statuses.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获得cell
//    HXStatusCell *cell = [HXStatusCell cellwithTableView:tableView];
//    cell.statusFrame = self.statusFrame[indexPath.row];
    static NSString *ID = @"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
      statusModle______ *status = self.statuses[indexPath.row];
      cell.textLabel.text = status.user.name;
      cell.detailTextLabel.text = status.text;
    
    
    
      //设置头像
        NSString *imageurl = status.user.profile_image_url;
        UIImage *placeholder = [UIImage imageNamed:@"avatar_default_small"];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:placeholder];
    
    return cell;
    
    //cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    
    //    NSDictionary * status = self.statuses[indexPath.row];
    //    NSDictionary * user = status[@"user"];
    //    cell.textLabel.text = user[@"name"];
    //    cell.detailTextLabel.text = status[@"text"];
    //设置头像
//    NSString *imageurl = user[@"profile_image_url"];
//    UIImage *placeholder = [UIImage imageNamed:@"avatar_default_small"];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:placeholder];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    statusFrame *frame = self.statusFrame[indexPath.row];
//    return frame.cellhightF;
//}


















@end
