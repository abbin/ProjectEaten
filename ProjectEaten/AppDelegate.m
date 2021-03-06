//
//  AppDelegate.m
//  ProjectEaten
//
//  Created by Abbin Varghese on 05/11/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "AppDelegate.h"
#import "PEManager.h"
#import "PEFirstLaunchViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@import GooglePlaces;
@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [GMSServices provideAPIKey:@"AIzaSyCQYQ51xXYYURu9KSxwIfJ3H1mAzv_93Vc"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyDCXB1ZqQdo0mCq4bhgx6rpuL0NYs5qvZM"];
    
#ifdef DEBUG
    NSLog(@"DEBUG");
#else
    [Fabric with:@[[Crashlytics class]]];
#endif
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UIToolbar appearance] setBarTintColor:[UIColor whiteColor]];
    
    if (![PEManager isUserSet]) {
        PEFirstLaunchViewController *firstLaunch = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PEFirstLaunchViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:firstLaunch];
        [nav setNavigationBarHidden:YES];
        self.window.rootViewController = nav;
    }
    
    return YES;
}


-(void)changeRootViewControllerToViewController:(UIViewController*)controller{
    self.window.rootViewController = controller;
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
