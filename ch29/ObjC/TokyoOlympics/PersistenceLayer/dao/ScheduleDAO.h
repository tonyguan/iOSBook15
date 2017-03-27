//
//  ScheduleDAO.h
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

#import "BaseDAO.h"
#import "Schedule.h"
#import "Events.h"
#import "ScheduleDAO.h"

//比赛日程表 数据访问对象类
@interface ScheduleDAO : BaseDAO

+ (ScheduleDAO *)sharedInstance;

//插入Note方法
- (int)create:(Schedule *)model;

//删除Note方法
- (int)remove:(Schedule *)model;

//修改Note方法
- (int)modify:(Schedule *)model;

//查询所有数据方法
- (NSMutableArray *)findAll;

//按照主键查询数据方法
- (Schedule *)findById:(Schedule *)model;

@end
