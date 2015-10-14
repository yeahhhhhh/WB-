//
//  AppDelegate.m
//  WB微博
//
//  Created by 黄欣 on 15/7/18.
//  Copyright (c) 2015年 黄欣. All rights reserved.
//

#import "AppDelegate.h"
#import "WBTabBarViewController.h"
#import "NewFeatureViewController.h"
#import "OAuthViewController.h"
#import "AccountTool.h"
#import "SDWebImageManager.h"
@interface AppDelegate ()
@property (nonatomic , assign)UIBackgroundTaskIdentifier task;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //程序图标处消息提醒
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];

    //创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //沙盒路径
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *path = [doc stringByAppendingPathComponent:@"accont.archive"];
//    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    Account *account = [AccountTool account];
    if (account)
    {
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleVersion"];//上一次使用时的版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];//当前使用的版本号
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//获取沙盒所在的路径
        //NSLog(@"%@",paths);
    
        if ([lastVersion isEqualToString:currentVersion])
        {
            //设置控制器
            WBTabBarViewController *tabbarVC = [[WBTabBarViewController alloc]init];
            self.window.rootViewController = tabbarVC;
        }
        else
        {
            self.window.rootViewController = [[NewFeatureViewController alloc]init];//显示新特性
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"CFBundleVersion"];//将当前使用版本号存到沙盒中去
            [[NSUserDefaults standardUserDefaults] synchronize];//立即存储到沙盒 必须写
        }
    
    }
    else
    {
        NSLog(@"111");
        OAuthViewController *tabbarVC = [[OAuthViewController alloc]init];
        self.window.rootViewController = tabbarVC;
    }
   
    
            
    
    
     //显示窗口
    [self.window makeKeyAndVisible];

    return YES;
    
    
    ///Users/huangxin/Library/Developer/CoreSimulator/Devices/BA70BF3A-4A1C-430B-97F7-5F074299247C/data/Containers/Data/Application/8A612C31-E645-4700-8FEC-8BF7BD91DF59/Documents 沙盒路径
    
    
//    //tabbarVC.viewControllers = @[v1,v2,v3,v4];
//    [tabbarVC addChildViewController:home];
//    [tabbarVC addChildViewController:messageCenter];
//    [tabbarVC addChildViewController:discover];
//    [tabbarVC addChildViewController:profile];   

    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/**
 *  当app进入后台时调用
 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /**
     *  app的状态
     *  1.死亡状态：没有打开app
     *  2.前台运行状态
     *  3.后台暂停状态：停止一切动画、定时器、多媒体、联网操作，很难再作其他操作
     *  4.后台运行状态
     */
    // 向操作系统申请后台运行的资格，能维持多久，是不确定的
    self.task = [application beginBackgroundTaskWithExpirationHandler:^{
        // 当申请的后台运行时间已经结束（过期），就会调用这个block
        // 赶紧结束任务
        [application endBackgroundTask:self.task];
    }];
    
    // 在Info.plst中设置后台模式：Required background modes == App plays audio or streams audio/video using AirPlay
    // 搞一个0kb的MP3文件，没有声音
    // 循环播放
    
    // 以前的后台模式只有3种
    // 保持网络连接
    // 多媒体应用
    // VOIP:网络电话
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    // 1.取消下载
    [mgr cancelAll];
    
    // 2.清除内存中的所有图片
    [mgr.imageCache clearMemory];
}
@end
