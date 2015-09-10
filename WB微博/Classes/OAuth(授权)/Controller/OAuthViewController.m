//
//  OAuthViewController.m
//  WB微博
//
//  Created by 黄欣 on 15/7/27.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"
#import "Account.h"
#import "WBTabBarViewController.h"
#import "NewFeatureViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AccountTool.h"
@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]init];
     webView.delegate = self;
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    //https://api.weibo.com/oauth2/authorize
    
    /*
     参数 ：client_id 	true	string	申请应用时分配的AppKey。 1484366926
           redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     */
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1484366926&redirect_uri=http://baidu.com"];//web加载登陆页面
    //    NSURL *url = [NSURL URLWithString:@"https://baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - webView代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@" 正在加载..."];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   // NSLog(@"%@",request.URL.absoluteURL);
    
    
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0)
    {
        //截取url里的code值
        long  index = range.location + range.length;
        NSString *code = [url substringFromIndex:index];//code是授权成功的标记
//        NSLog(@"%@,%@",code,url) ;
        [self accessTokenwithCode:code];
        
        //禁止加载回调地址
        return NO;
    }
    
    
    return YES;
    
}
- (void)accessTokenwithCode:(NSString *)code
{
    
    //获得access token
    /*
     client_id	     true	string	申请应用时分配的AppKey。
     client_secret	 true	string	申请应用时分配的AppSecret。
     grant_type	     true	string	请求的类型，填写authorization_code
     code	         true	string	调用authorize获得的code值。
     redirect_uri    true	string	回调地址，需需与注册应用里的回调地址一致。
     */
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // AFN的AFJSONResponseSerializer默认不接受text/plain这种类型
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"1484366926";
    params[@"client_secret"] = @"4cd00da35c1cd326ba25797bab278d19";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://baidu.com";
    params[@"code"] = code;
    
    // 3.发送请求
    
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject)
    {
        //NSLog(@"请求成功-%@", responseObject);
        [MBProgressHUD hideHUD];//隐藏
        //将返回的账号数据转换为模型存入沙盒
         Account *account = [Account accountWithDict:responseObject];
        [AccountTool saveAccount:account];
        
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleVersion"];//上一次使用时的版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];//当前使用的版本号
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//获取沙盒所在的路径
        //NSLog(@"%@",paths);
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if ([lastVersion isEqualToString:currentVersion])
        {
            //设置控制器
            UITabBarController *tabbarVC = [[WBTabBarViewController alloc]init];
            window.rootViewController = tabbarVC;
        }
        else
        {
            window.rootViewController = [[NewFeatureViewController alloc]init];//显示新特性
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"CFBundleVersion"];//将当前使用版本号存到沙盒中去
            [[NSUserDefaults standardUserDefaults] synchronize];//立即存储到沙盒 必须写
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"accessTokenwithCode");
        NSLog(@"请求失败-%@", error);
        [MBProgressHUD hideHUD];
    }];
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
