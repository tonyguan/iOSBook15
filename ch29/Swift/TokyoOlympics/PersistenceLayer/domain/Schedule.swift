//
//  Schedule.swift
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

// 比赛日程表 实体类
public class Schedule {
    //编号
    public var ScheduleID: Int?
    //比赛日期
    public var GameDate: String?
    //比赛时间
    public var GameTime: String?
    //比赛描述
    public var GameInfo: String?
    //比赛项目
    public var Event: Events?

}
