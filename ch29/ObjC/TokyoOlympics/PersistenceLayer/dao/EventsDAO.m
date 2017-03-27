//
//  EventsDAO.m
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

#import "EventsDAO.h"

@implementation EventsDAO

static EventsDAO *sharedSingleton = nil;

+ (EventsDAO *)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{

        sharedSingleton = [[super alloc] init];

    });
    return sharedSingleton;
}

//插入Events方法
- (int)create:(Events *)model {

    if ([self openDB]) {

        NSString *sqlStr = @"INSERT INTO Events (EventName, EventIcon,KeyInfo,BasicsInfo,OlympicInfo) VALUES (?,?,?,?,?)";

        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {

            const char* cEventName = [model.EventName UTF8String];
            const char* cEventIcon = [model.EventName UTF8String];
            const char* cKeyInfo = [model.KeyInfo UTF8String];
            const char* cBasicsInfo = [model.BasicsInfo UTF8String];
            const char* cOlympicInfo = [model.OlympicInfo UTF8String];
            
            //绑定参数开始
            sqlite3_bind_text(statement, 1, cEventName, -1, NULL);
            sqlite3_bind_text(statement, 2, cEventIcon, -1, NULL);
            sqlite3_bind_text(statement, 3, cKeyInfo, -1, NULL);
            sqlite3_bind_text(statement, 4, cBasicsInfo, -1, NULL);
            sqlite3_bind_text(statement, 5, cOlympicInfo, -1, NULL);

            //执行插入
            if (sqlite3_step(statement) != SQLITE_DONE) {
                sqlite3_finalize(statement);
                sqlite3_close(db);
                NSAssert(NO, @"插入数据失败。");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }

    return 0;
}

//删除Events方法
- (int)remove:(Events *)model {
    if ([self openDB]) {

        //先删除子表（比赛日程表）相关数据
        NSString *sqlScheduleStr = [[NSString alloc] initWithFormat:@"DELETE  from Schedule where EventID=%i", model.EventID];

        //开启事务，立刻提交之前事务
        sqlite3_exec(db, "BEGIN IMMEDIATE TRANSACTION", NULL, NULL, NULL);

        char* err;
        
        if (sqlite3_exec(db, [sqlScheduleStr UTF8String], NULL, NULL, &err) != SQLITE_OK) {

            NSLog(@"err = %s", err);
            //回滚事务
            sqlite3_exec(db, "ROLLBACK TRANSACTION", NULL, NULL, NULL);
            NSAssert(NO, @"删除数据失败。");
        }

        //先删除主表（比赛项目）数据
        NSString *sqlEventsStr = [[NSString alloc] initWithFormat:@"DELETE  from Events where EventID =%i;", model.EventID];

        if (sqlite3_exec(db, [sqlEventsStr UTF8String], NULL, NULL, NULL) != SQLITE_OK) {
            //回滚事务
            sqlite3_exec(db, "ROLLBACK TRANSACTION", NULL, NULL, NULL);
            NSAssert(NO, @"删除数据失败。");
        }
        //提交事务
        sqlite3_exec(db, "COMMIT TRANSACTION", NULL, NULL, NULL);

        sqlite3_close(db);
    }

    return 0;
}

//修改Events方法
- (int)modify:(Events *)model {

    if ([self openDB]) {

        NSString *sqlStr = @"UPDATE Events set EventName=?, EventIcon=?,KeyInfo=?,BasicsInfo=?,OlympicInfo=? where EventID =?";

        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            const char* cEventName = [model.EventName UTF8String];
            const char* cEventIcon = [model.EventName UTF8String];
            const char* cKeyInfo = [model.KeyInfo UTF8String];
            const char* cBasicsInfo = [model.BasicsInfo UTF8String];
            const char* cOlympicInfo = [model.OlympicInfo UTF8String];
            
            //绑定参数开始
            sqlite3_bind_text(statement, 1, cEventName, -1, NULL);
            sqlite3_bind_text(statement, 2, cEventIcon, -1, NULL);
            sqlite3_bind_text(statement, 3, cKeyInfo, -1, NULL);
            sqlite3_bind_text(statement, 4, cBasicsInfo, -1, NULL);
            sqlite3_bind_text(statement, 5, cOlympicInfo, -1, NULL);
            sqlite3_bind_int(statement, 6, model.EventID);

            //执行
            if (sqlite3_step(statement) != SQLITE_DONE) {
                sqlite3_finalize(statement);
                sqlite3_close(db);
                NSAssert(NO, @"修改数据失败。");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return 0;
}

//查询所有数据方法
- (NSMutableArray *)findAll {
    
    NSMutableArray *listData = [[NSMutableArray alloc] init];

    if ([self openDB]) {

        NSString *qsql = @"SELECT EventName, EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID FROM Events";

        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) == SQLITE_OK) {

            //执行
            while (sqlite3_step(statement) == SQLITE_ROW) {

                Events *events = [[Events alloc] init];

                char *cEventName = (char *) sqlite3_column_text(statement, 0);
                events.EventName = [[NSString alloc] initWithUTF8String:cEventName];

                char *cEventIcon = (char *) sqlite3_column_text(statement, 1);
                events.EventIcon = [[NSString alloc] initWithUTF8String:cEventIcon];

                char *cKeyInfo = (char *) sqlite3_column_text(statement, 2);
                events.KeyInfo = [[NSString alloc] initWithUTF8String:cKeyInfo];

                char *cBasicsInfo = (char *) sqlite3_column_text(statement, 3);
                events.BasicsInfo = [[NSString alloc] initWithUTF8String:cBasicsInfo];

                char *cOlympicInfo = (char *) sqlite3_column_text(statement, 4);
                events.OlympicInfo = [[NSString alloc] initWithUTF8String:cOlympicInfo];

                events.EventID = sqlite3_column_int(statement, 5);

                [listData addObject:events];

            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);

    }
    return listData;
}

//按照主键查询数据方法
- (Events *)findById:(Events *)model {

    if ([self openDB]) {

        NSString *qsql = @"SELECT EventName, EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID FROM Events  where EventID =?";

        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) == SQLITE_OK) {

            //绑定参数开始
            sqlite3_bind_int(statement, 1, model.EventID);

            //执行
            if (sqlite3_step(statement) == SQLITE_ROW) {

                Events *events = [[Events alloc] init];

                char *cEventName = (char *) sqlite3_column_text(statement, 0);
                events.EventName = [[NSString alloc] initWithUTF8String:cEventName];

                char *cEventIcon = (char *) sqlite3_column_text(statement, 1);
                events.EventIcon = [[NSString alloc] initWithUTF8String:cEventIcon];

                char *cKeyInfo = (char *) sqlite3_column_text(statement, 2);
                events.KeyInfo = [[NSString alloc] initWithUTF8String:cKeyInfo];

                char *cBasicsInfo = (char *) sqlite3_column_text(statement, 3);
                events.BasicsInfo = [[NSString alloc] initWithUTF8String:cBasicsInfo];

                char *cOlympicInfo = (char *) sqlite3_column_text(statement, 4);
                events.OlympicInfo = [[NSString alloc] initWithUTF8String:cOlympicInfo];

                events.EventID = sqlite3_column_int(statement, 5);

                sqlite3_finalize(statement);
                sqlite3_close(db);
                return events;
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return nil;
}

@end
