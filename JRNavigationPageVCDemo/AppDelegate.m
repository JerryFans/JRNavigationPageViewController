//
//  AppDelegate.m
//  JRNavigationPageVCDemo
//
//  Created by JerryFans on 2017/7/11.
//  Copyright © 2017年 JerryFans. All rights reserved.
//

#import "AppDelegate.h"
#import "JRNavigationPageViewController.h"
#import "JRNavigationPageVCDemo-Swift.h"
#import "JRNavigationPageViewController.h"
#import "OCViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    JRMenuClassItem *ocItem = [[JRMenuClassItem alloc]init];
    ocItem.className = @"OCViewController";
    
    JRMenuClassItem *swiftItem = [[JRMenuClassItem alloc]init];
    swiftItem.className = @"OCViewController";
    
    JRNavigationPageViewController *pageVC = [[JRNavigationPageViewController alloc]initWithClassItems:^NSArray<JRMenuClassItem *> *{
        return @[ocItem,swiftItem];
    } andTitles:^NSArray<NSString *> *{
        return @[@"附近",@"人气"];
    }];
    
    
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:pageVC];
    navi.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:0];
    
    UINavigationController *navi1 = [[UINavigationController alloc]initWithRootViewController:[[OCViewController alloc] init]];
    navi1.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:0];
    UINavigationController *navi2 = [[UINavigationController alloc]initWithRootViewController:[[OCViewController alloc] init]];
    navi2.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:0];
    UINavigationController *navi3 = [[UINavigationController alloc]initWithRootViewController:[[OCViewController alloc] init]];
    navi3.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    [tabbar setViewControllers:@[navi,navi1,navi2,navi3]];
    [tabbar.tabBar setBackgroundColor:[UIColor whiteColor]];
    
   
    self.window.rootViewController = tabbar;
    //设定window的背景颜色clear
    self.window.backgroundColor = [UIColor clearColor];
    //显示
    [self.window makeKeyAndVisible];
    
    
    [[UINavigationBar appearance]setBackgroundColor:[UIColor blackColor]];
    [[UINavigationBar appearance]setBarTintColor:[UIColor blackColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
