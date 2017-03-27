//
//  AppDelegate.m
//  PushNotificationSample
//
//  Created by 关东升 on 2016-11-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//


#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UNUserNotificationCenter currentNotificationCenter]
     requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound)
     completionHandler:^(BOOL granted, NSError * _Nullable error) {
         if (!error) {
             NSLog(@"授权成功");
             [application registerForRemoteNotifications];
         } else {
             NSLog(@"授权失败");
         }
     }];

    return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    //获得设备令牌
    NSString *tokeStr = deviceToken.description;
    NSLog(@"tokeStr: %@", deviceToken);
    
    tokeStr = [tokeStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    tokeStr = [tokeStr stringByReplacingOccurrencesOfString:@">" withString:@""];
    tokeStr = [tokeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"设备令牌: %@", tokeStr);
    
    //通知接收后的处理
    UNNotificationAction* deleteAction = [UNNotificationAction
                                          actionWithIdentifier:@"delete_action_id"
                                          title:@"Delete"
                                          options: UNNotificationActionOptionNone];
    
    UNNotificationAction* replyAction = [UNNotificationAction
                                          actionWithIdentifier:@"reply_action_id"
                                          title:@"Reply"
                                          options: UNNotificationActionOptionNone];
    
    UNNotificationCategory* deleteReplyCategory = [UNNotificationCategory categoryWithIdentifier:@"custom_category_id" actions:@[deleteAction, replyAction] intentIdentifiers:@[@"", @""] options: UNNotificationCategoryOptionNone];
    NSSet* categories = [NSSet setWithObject:deleteReplyCategory];
    
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:categories];
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"获得令牌失败: %@", error);
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    if ([response.actionIdentifier isEqualToString:@"delete_action_id"]) {
        NSLog(@"Delete被单击");
    } else if ([response.actionIdentifier isEqualToString:@"reply_action_id"]) {
        NSLog(@"Reply被单击");
    }
    completionHandler();
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
