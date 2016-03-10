//
//  AppDelegate.m
//  CoffeeBook
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "AppDelegate.h"
#import "BookViewController.h"
#import "BookClassViewController.h"
#import "DiscoverViewController.h"
#import <BmobSDK/Bmob.h>
@interface AppDelegate ()
@property(nonatomic, strong) UITabBarController *tabBarVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Bmob registerWithAppKey:kBmobAppKey];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.tabBarVC = [[UITabBarController alloc] init];
    
    //书
    UIStoryboard *bookStoryboard = [UIStoryboard storyboardWithName:@"Book" bundle:nil];
    UINavigationController *bookNav = bookStoryboard.instantiateInitialViewController;
    bookNav.tabBarItem.image = [UIImage imageNamed:@"bookclub_tabIcon_read_stroked60"];
    bookNav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIImage *bookSelectImage = [UIImage imageNamed:@"bookclub_tabIcon_read_solid60"];
    bookNav.tabBarItem.selectedImage = [bookSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //发现
    UIStoryboard *discoverStoryboard = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
    UINavigationController *discoverNav = discoverStoryboard.instantiateInitialViewController;
    discoverNav.tabBarItem.image = [UIImage imageNamed:@"bookclub_tabIcon_social_stroked60"];
    
    discoverNav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIImage *discoverSelectImage = [UIImage imageNamed:@"bookclub_tabIcon_social_solid60"];
    discoverNav.tabBarItem.selectedImage = [discoverSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //类目
    UIStoryboard *bookClassStoryboad = [UIStoryboard storyboardWithName:@"BookClass" bundle:nil];
    UINavigationController *bookClassNav = bookClassStoryboad.instantiateInitialViewController;
    bookClassNav.tabBarItem.image = [UIImage imageNamed:@"bookclub_tabIcon_books_stroked60"];
    bookClassNav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIImage *bookClassSelectImage = [UIImage imageNamed:@"bookclub_tabIcon_books_solid60"];
    bookClassNav.tabBarItem.selectedImage = [bookClassSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    self.tabBarVC.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBarVC.viewControllers = @[bookNav, discoverNav, bookClassNav];
    self.window.rootViewController = self.tabBarVC;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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
