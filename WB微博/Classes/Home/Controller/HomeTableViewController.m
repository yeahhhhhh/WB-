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
//#import "MJExtension.h"
//#import "LodeMoreFooter(下拉加载).h"//使用了MJRefresh框架 舍去自定义的下拉加载
#import "HXStatusCell.h"
#import "statusFrame.h"
#import "BastNavigationViewController.h"
#import "MJRefresh.h"
#import "DetailedTableViewController.h"
#import "DetailedTableViewCell.h"
@interface HomeTableViewController ()<HXDropdownMenuDelegate>
@property (nonatomic, strong) DetailedTableViewController * compose;
@property (nonatomic, strong) NSMutableArray* statusFrames;//(微博模型) 里面存放的statusFrame(微博模型) 每一个statusFrame(微博模型)代表一个微博
@property (nonatomic, strong) NSMutableArray* statusArray;//单纯的只是微博数据
@end
@implementation HomeTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1];
//    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);//将cell往下移到15个单位
    
    //设置导航栏内容
    [self setupNav];
    //获取用户信息
    [self setupUserInfo];
    
    [self loadNewSttus];
    
    //集成下拉刷新控件
    [self setDownRefresh];
    
    // 获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setStatusCount) userInfo:nil repeats:YES];
    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //集成上拉刷新控件
    [self setupRefresh];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     NSLog(@" %s view即将卸载",__FUNCTION__);
    // Dispose of any resources that can be recreated.
}
/**
 * 集成刷新控件 下拉
 */
- (void)setDownRefresh
{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(Refresh)];

    // 设置header
    self.tableView.header = header;
//    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(Refresh)];
    
//    UIRefreshControl *control = [[UIRefreshControl alloc]init];
//    
//    [control addTarget:self action:@selector(Refresh:) forControlEvents:UIControlEventValueChanged];
//    control.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新......"];
//    [self.tableView addSubview:control] ;
//    //进入刷新状态 但不会刷新数据
//    [control beginRefreshing];
//    //调用方法刷新数据
//    [self Refresh:control];
}
/**
 * 集成刷新控件 上拉
 */
- (void)setupRefresh
{
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    qq
//    LodeMoreFooter______ *footer = [LodeMoreFooter______ footer];
//    footer.hidden = YES;
//    self.tableView.tableFooterView = footer;
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
         NSLog(@"获得微博未读数");
         NSLog(@"请求失败-%@", error);
     }];
    
}

/**
 * UIRefreshControl 进入刷新状态
 */
- (void)Refresh
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
    statusFrame *firetStatusF = [self.statusFrames firstObject];
    if (firetStatusF) {
        params[@"since_id"] = firetStatusF.status.idstr;
    }
    
//        params[@"count"] = @1;
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
     {
         NSArray *array = [statusModle______ objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         
         
         /**
          *  将json转换为plist文件
          */
//         NSArray *array = [statusModle______ objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//         NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//         dict[@"statuses"] = [statusModle______ keyValuesArrayWithObjectArray:array];
//         dict[@"total_number"] = responseObject[@"total_number"];
//         [dict writeToFile:@"/Users/huangxin/Desktop/huang.plist"  atomically:YES];
         
         // 将 HWStatus数组 转为 HWStatusFrame数组
         
         NSArray *newFrames = [self stausFramesWithStatuses:array];
         
         
         
         NSRange range = NSMakeRange(0, newFrames.count);
         NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
         
         [self.statusFrames insertObjects:newFrames atIndexes:set];//插到最前面
         [self.tableView reloadData];//刷新表格
         [self.tableView.header endRefreshing];//结束刷新
//         [control endRefreshing];
         //显示微博刷新数量
         [self showNewStatusCount:array.count];
         self.tabBarItem.badgeValue = nil;
         [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
         
         
    
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"进入刷新状态");
         NSLog(@"请求失败-%@", error);
         [self.tableView.header endRefreshing];//结束刷新
//         [control endRefreshing];
     }];
    
}
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (statusModle______ *status in statuses) {
        statusFrame *f = [[statusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}
- (NSMutableArray *)statusFrames
{
    if (!_statusFrames)
    {
        self.statusFrames = [[NSMutableArray alloc]init];
    }
    return _statusFrames;
}
- (NSMutableArray *)statusArray
{
    if (!_statusArray)
    {
        self.statusArray = [[NSMutableArray alloc]init];
    }
    return _statusArray;
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
         
         NSArray *newFreams = [self stausFramesWithStatuses:array];
         [self.statusFrames addObjectsFromArray:newFreams];
         [self.statusArray addObjectsFromArray:array];
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
- (void)showNewStatusCount:(NSUInteger )count
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
        
        lable.text = [NSString stringWithFormat:@"共有%lu条微博",(unsigned long)count];
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
/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    statusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        //NSLog(@"%@",responseObject);
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [statusModle______ objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将 HWStatus数组 转为 HWStatusFrame数组
        NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        [self.statusArray addObjectsFromArray:newStatuses];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"加载更多的微博数据");
        NSLog(@"请求失败-%@", error);
        
        
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
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
    return self.statusFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获得cell
    HXStatusCell *cell = [HXStatusCell cellwithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    
         
    return cell;
//    statusModle______ *status = self.statuses[indexPath.row];
//    cell.textLabel.text = status.user.name;
//    cell.detailTextLabel.text = status.text;
//    
//    
//    
//    //设置头像
//    NSString *imageurl = status.user.profile_image_url;
//    UIImage *placeholder = [UIImage imageNamed:@"avatar_default_small"];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:placeholder];
//    
    
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
//-(DetailedTableViewController *)compose
//{
//    if (!_compose)
//    {
//        self.compose = [[DetailedTableViewController alloc]init];
//    }
//    return _compose;
//}
/**
 *  选中cell行
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailedTableViewController *compose = [[DetailedTableViewController alloc]init];
    compose.statusModle = self.statusArray[indexPath.row];
    [self.navigationController pushViewController:compose animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    statusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellhightF;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    // 如果tableView还没有数据，就直接返回
    if (self.statusFrames.count == 0) return;
    //    if ([self.tableView numberOfRowsInSection:0] == 0) return;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        [self loadMoreStatus];
        NSLog(@"加载更多的微博数据");

    }
    
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}

/**
 1.将字典转为模型
 2.能够下拉刷新最新的微博数据
 3.能够上拉加载更多的微博数据
 */






@end
