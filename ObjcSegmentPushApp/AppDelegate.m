//
//  AppDelegate.m
//  ObjcSegmentPushApp
//
//  Created by FUJITSU CLOUD TECHNOLOGIES on 2016/10/17.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

#import "AppDelegate.h"
#import <NCMB/NCMB.h>
#import <UserNotifications/UserNotifications.h>

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [NCMB setApplicationKey:@"YOUR_APPLICATION_KEY"
                  clientKey:@"YOUR_CLIENT_KEY"];
    
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){10, 0, 0}]){
        
        //iOS10以上での、DeviceToken要求方法
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert |
                                                 UNAuthorizationOptionBadge |
                                                 UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (error) {
                                      return;
                                  }
                                  if (granted) {
                                      //通知を許可にした場合DeviceTokenを要求
                                      [[UIApplication sharedApplication] registerForRemoteNotifications];
                                  }
                              }];
    } else if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){8, 0, 0}]){
        
        //iOS10未満での、DeviceToken要求方法
        
        //通知のタイプを設定したsettingを用意
        UIUserNotificationType type = UIUserNotificationTypeAlert |
        UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting;
        setting = [UIUserNotificationSettings settingsForTypes:type
                                                    categories:nil];
        
        //通知のタイプを設定
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
        
        //DeviceTokenを要求
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } 
    
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"Device Token = %@", deviceToken);
    
    // 端末情報を扱うNCMBInstallationのインスタンスを作成
    NCMBInstallation *installation = [NCMBInstallation currentInstallation];
    
    // Device Tokenを設定
    [installation setDeviceTokenFromData:deviceToken];
    
    // 端末情報をデータストアに登録
    [installation saveInBackgroundWithBlock:^(NSError *error) {
        // 登録後ViewControllerのtableViewを更新する
        ViewController *viewController = (ViewController *)self.window.rootViewController;
        [viewController getInstallation];
        if(!error){
            // 端末情報の登録が成功した場合の処理
            viewController.statusLabel.text = [NSString stringWithFormat:@"登録に成功しました"];
        } else {
            // 端末情報の登録が失敗した場合の処理
            viewController.statusLabel.text = [NSString stringWithFormat:@"登録に失敗しました:%ld",(long)error.code];
        }
    }];
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
