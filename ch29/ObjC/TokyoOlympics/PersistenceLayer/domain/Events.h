//
//  Events.h
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

#import <Foundation/Foundation.h>

//比赛项目 实体类
@interface Events : NSObject

//编号
@property(nonatomic, assign) int EventID;
//项目名
@property(nonatomic, strong) NSString *EventName;
//项目图标
@property(nonatomic, strong) NSString *EventIcon;
//项目关键信息
@property(nonatomic, strong) NSString *KeyInfo;
//项目基本信息
@property(nonatomic, strong) NSString *BasicsInfo;
//项目奥运会历史信息
@property(nonatomic, strong) NSString *OlympicInfo;

@end
