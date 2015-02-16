//
//  AppDelegate.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/17/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "AppDelegate.h"
#import "GNZRosterViewController.h"
#import "GNZSwimmerDataStore.h"
#import "GNZSplitsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
  UITabBarController *tabBarVC = [[UITabBarController alloc] init];
  GNZRosterViewController *rosterVC = [[GNZRosterViewController alloc] init];
  UINavigationController *rosterNavVC = [[UINavigationController alloc] initWithRootViewController:rosterVC];
  GNZSplitsViewController *splitsVC = [[GNZSplitsViewController alloc] init];
  UINavigationController *splitsNavVC = [[UINavigationController alloc] initWithRootViewController:splitsVC];
  rosterNavVC.tabBarItem.image = [UIImage imageNamed:@"clipBoard1"];
  rosterNavVC.tabBarItem.title = @"Attendance";
  splitsNavVC.tabBarItem.image = [UIImage imageNamed:@"stopWatch2"];
  splitsNavVC.tabBarItem.title = @"Splits";
  tabBarVC.viewControllers = @[rosterNavVC, splitsNavVC];
  self.window.rootViewController = tabBarVC;
  
  return YES;
}

- (UIWindow *)window {
  if (!_window) {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
  }
  return _window;
}

@end
