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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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
            UITabBarController *tabbarVC = [[WBTabBarViewController alloc]init];
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

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

@end
