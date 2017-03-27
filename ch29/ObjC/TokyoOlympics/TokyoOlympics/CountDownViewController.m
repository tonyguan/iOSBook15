//
//  CountDownViewController.m
//  TokyoOlympics
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


#import "CountDownViewController.h"

@interface CountDownViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblCountDownPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblCountDownPad;

@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //创建NSDateComponents对象
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //设置NSDateComponents日期
    [comps setDay:24];
    //设置NSDateComponents月
    [comps setMonth:7];
    //设置NSDateComponents年
    [comps setYear:2020];
    //创建日历对象
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获得2020-7-24日的NSDate日期对象
    NSDate *destinationDate = [calender dateFromComponents:comps];
    NSDate *date = [NSDate date];
    //获得当前日期到2020-7-24时间的NSDateComponents对象
    NSDateComponents *components = [calender components:NSCalendarUnitDay fromDate:date toDate:destinationDate options:NSCalendarWrapComponents];
    //获得当前日期到2020-7-24相差的天数
    NSInteger days = [components day];
    
    NSString *strDays = [NSString stringWithFormat:@"%li天",(long)days];
    //设置iPhone中的标签
    self.lblCountDownPhone.text = strDays;
    //设置Pad中的标签
    self.lblCountDownPad.text = strDays;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
