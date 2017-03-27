//
//  TodayViewController.m
//  CountDown
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


#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
//显示倒计时
@property (weak, nonatomic) IBOutlet UILabel *lblCountDown;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    //创建NSDateComponents对象
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //设置NSDateComponents对象的日期属性
    [comps setDay:24];
    //设置NSDateComponents对象的月属性
    [comps setMonth:7];
    //设置NSDateComponents对象的年属性
    [comps setYear:2020];
    //创建日历对象
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获得2020-7-24日的NSDate日期对象
    NSDate *destinationDate = [calender dateFromComponents:comps];
    NSDate *date = [NSDate date];
    //获得当前日期到2020-7-24时间的NSDateComponents对象
    NSDateComponents *components = [calender components:NSCalendarUnitDay fromDate:date toDate:destinationDate options:NSCalendarWrapComponents];
    //获得当前日期到2020-7-24相差的天数
    NSInteger days = components.day;
    
    NSMutableAttributedString *strLabel = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%li天",(long)days]];
    
    [strLabel addAttribute:NSFontAttributeName
                     value:[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]
                     range:NSMakeRange(strLabel.length - 1, 1)];
    
    self.lblCountDown.attributedText = strLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
