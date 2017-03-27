//
//  Schedule.h
//  PersistenceLayer
//
//  Created by tonyguan on 2016/11/16.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "Events.h"

// 比赛日程表 实体类
@interface Schedule : NSObject

//编号
@property(nonatomic, assign) int ScheduleID;
//比赛日期
@property(nonatomic, strong) NSString *GameDate;
//比赛时间
@property(nonatomic, strong) NSString *GameTime;
//比赛描述
@property(nonatomic, strong) NSString *GameInfo;
//比赛项目
@property(nonatomic, strong) Events *Event;

@end
