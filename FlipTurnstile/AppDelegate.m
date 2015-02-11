//
//  AppDelegate.m
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/17/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import "AppDelegate.h"
#import "GNZRosterViewController.h"
#import "SwimmerDataStore.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
  UITabBarController *tabBarVC = [[UITabBarController alloc] init];
  GNZRosterViewController *rosterVC = [[GNZRosterViewController alloc] init];
  UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:rosterVC];
  tabBarVC.viewControllers = @[navVC];
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
