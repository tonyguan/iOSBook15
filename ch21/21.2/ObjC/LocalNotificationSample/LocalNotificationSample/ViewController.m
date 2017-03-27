//
//  ViewController.m
//  LocalNotificationSample
//
//  Created by tonyguan on 2016/11/9.
//  Copyright © 2016年 关东升. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <UNUserNotificationCenterDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)scheduleNotification:(id)sender {

    // 创建通知内容
    UNMutableNotificationContent * content = [[UNMutableNotificationContent alloc] init];
    content.body = @"通知内容：大家好，新年快乐！";
    // 默认的通知提示音
    content.sound = [UNNotificationSound defaultSound];
    content.subtitle = @"通知副标题";
    content.title = @"通知标题";
    // 通知附件
    NSURL *url  = [[NSBundle mainBundle] URLForResource:@"Icon" withExtension:@"png"];
    UNNotificationAttachment *attach = [UNNotificationAttachment attachmentWithIdentifier:@"icon" URL:url options:nil error:nil];
    content.attachments = @[attach];
    
    content.categoryIdentifier = @"myCategory";
    
    // 创建触发器
    UNNotificationTrigger* trigger = [self createTimeTrigger];
    UIButton* button = (UIButton*)sender;
    if (button.tag == 300) {//300是点击日历触发器按钮，200是点击时间中断触发器按钮，
        trigger = [self createCalendarTrigger];
    }
    
    // 创建通知请求对象
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"com.51work6.local.Notification" content:content trigger:trigger];
    
    // 添加通知
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"添加通知请求到通知中心");
        }
    }];
        
    UNNotificationAction *action = [UNNotificationAction actionWithIdentifier:@"myAction" title:@"OK" options: UNNotificationActionOptionNone];
    
    UNNotificationCategory* category = [UNNotificationCategory categoryWithIdentifier:@"myCategory" actions:@[action] intentIdentifiers:@[@""] options: UNNotificationCategoryOptionNone];
    NSSet* categories = [NSSet setWithObject:category];
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:categories];
    
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
}

//创建时间中断触发器触发器
-(UNNotificationTrigger*) createTimeTrigger {
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger
                                                      triggerWithTimeInterval:5 repeats:NO];
    return timeTrigger;
}

//创建日历触发器触发器
-(UNNotificationTrigger*) createCalendarTrigger {
    
    NSDateComponents *components= [[NSDateComponents alloc]init];
    components.hour= 7;
    components.minute= 30;
    
    UNCalendarNotificationTrigger *calendarTrigger= [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    
    return calendarTrigger;
}

//实现委托协议UNUserNotificationCenterDelegate
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    if ([response.actionIdentifier isEqual: @"myAction"]) {
        NSLog(@"OK！");
        
    }
    completionHandler();
}

@end
