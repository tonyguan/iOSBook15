//
//  ScheduleViewController.m
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


#import "ScheduleViewController.h"
#import "EventsDetailViewController.h"

#import "Schedule.h"
#import "ScheduleDAO.h"
#import "EventsDAO.h"

@interface ScheduleViewController ()
//表视图使用的数据
@property (strong, nonatomic) NSDictionary * data;
//比赛日期列表
@property (strong, nonatomic) NSArray * arrayGameDateList;
@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.data == nil || [self.data count] == 0) {
        //查询所有数据方法
        self.data = [self readData];
        NSArray* keys = [self.data allKeys];
        //对key进行排序
        self.arrayGameDateList = [keys sortedArrayUsingSelector:@selector(compare:)];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//查询所有数据方法
-(NSMutableDictionary*) readData {
    ScheduleDAO *scheduleDAO = [ScheduleDAO sharedInstance];
    
    NSMutableArray* schedules  = [scheduleDAO findAll];
    NSMutableDictionary *resDict = [[NSMutableDictionary alloc] init];
    
    EventsDAO *eventsDAO = [EventsDAO sharedInstance];
    
    //延迟加载Events数据
    for (Schedule *schedule in schedules) {
        Events *event = [eventsDAO findById:schedule.Event];
        schedule.Event = event;
        
        NSArray  *allkey = [resDict allKeys];
        
        //把数组（NSMutableArray）结构转化为字典（NSMutableDictionary）结构
        if([allkey containsObject:schedule.GameDate]) {
            NSMutableArray* value = resDict[schedule.GameDate];
            [value addObject:schedule];
        } else {
            NSMutableArray* value = [[NSMutableArray alloc] init];
            [value addObject:schedule];
            resDict[schedule.GameDate] = value;
        }
    }
    return resDict;
}

#pragma mark -- 表视图数据源

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray* keys = [self.data allKeys];
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //比赛日期
    NSString* strGameDate = self.arrayGameDateList[section];
    //比赛日期下的比赛日程表
    NSArray *schedules = self.data[strGameDate];
    return [schedules count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //比赛日期
    NSString* strGameDate = self.arrayGameDateList[section];
    return strGameDate;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    //比赛日期
    NSString* strGameDate = self.arrayGameDateList[indexPath.section];
    //比赛日期下的比赛日程表
    NSArray *schedules = self.data[strGameDate];
    
    Schedule *schedule = schedules[indexPath.row];
    NSString* subtitle = [[NSString alloc] initWithFormat:@"%@ | %@", schedule.GameInfo, schedule.Event.EventName];
    
    cell.textLabel.text = schedule.GameTime;
    cell.detailTextLabel.text = subtitle;
    
    return cell;
}

-(NSArray *) sectionIndexTitlesForTableView: (UITableView *) tableView {
    NSMutableArray *listTitles = [[NSMutableArray alloc] init];
    // 2020-08-09 -> 08-09
    for (NSString *item in self.arrayGameDateList) {
        NSString *title = [item substringFromIndex:5];
        [listTitles addObject:title];
    }
    return listTitles;
}


@end
