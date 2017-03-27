//
//  ScheduleDAO.m
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

#import "ScheduleDAO.h"

@implementation ScheduleDAO

static ScheduleDAO *sharedSingleton = nil;

+ (ScheduleDAO *)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedSingleton = [[super alloc] init];
    });
    return sharedSingleton;
}

//插入Schedule方法
- (int)create:(Schedule *)model {

    if ([self openDB]) {

        NSString *sqlStr = @"INSERT INTO Schedule (GameDate, GameTime,GameInfo,EventID) VALUES (?,?,?,?)";

        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            const char* cGameDate = [model.GameDate UTF8String];
            const char* cGameTime = [model.GameTime UTF8String];
            const char* cGameInfo = [model.GameInfo UTF8String];
            
            //绑定参数开始
            sqlite3_bind_text(statement, 1, cGameDate, -1, NULL);
            sqlite3_bind_text(statement, 2, cGameTime, -1, NULL);
            sqlite3_bind_text(statement, 3, cGameInfo, -1, NULL);
            sqlite3_bind_int(statement, 4, model.Event.EventID);

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

//删除Schedule方法
- (int)remove:(Schedule *)model {
    if ([self openDB]) {

        NSString *sqlStr = @"DELETE  from Schedule where ScheduleID =?";

        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {

            //绑定参数开始
            sqlite3_bind_int(statement, 1, model.ScheduleID);
            //执行
            if (sqlite3_step(statement) != SQLITE_DONE) {
                sqlite3_finalize(statement);
                sqlite3_close(db);
                NSAssert(NO, @"删除数据失败。");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }

    return 0;
}

//修改Schedule方法
- (int)modify:(Schedule *)model {

    if ([self openDB]) {

        NSString *sqlStr = @"UPDATE Schedule set GameInfo=?,EventID=?,GameDate =?, GameTime=? where ScheduleID=?";

        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {

            const char* cGameDate = [model.GameDate UTF8String];
            const char* cGameTime = [model.GameTime UTF8String];
            const char* cGameInfo = [model.GameInfo UTF8String];
            
            //绑定参数开始
            sqlite3_bind_text(statement, 1, cGameInfo, -1, NULL);
            sqlite3_bind_int(statement, 2, model.Event.EventID);
            sqlite3_bind_text(statement, 3, cGameDate, -1, NULL);
            sqlite3_bind_text(statement, 4, cGameTime, -1, NULL);
            sqlite3_bind_int(statement, 5, model.ScheduleID);
            
            //执行
            if (sqlite3_step(statement) != SQLITE_DONE) {
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

        NSString *qsql = @"SELECT GameDate, GameTime,GameInfo,EventID,ScheduleID FROM Schedule";

        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) == SQLITE_OK) {

            //执行
            while (sqlite3_step(statement) == SQLITE_ROW) {

                Schedule *schedule = [[Schedule alloc] init];
                Events *event = [[Events alloc] init];
                schedule.Event = event;

                char *cGameDate = (char *) sqlite3_column_text(statement, 0);
                schedule.GameDate = [[NSString alloc] initWithUTF8String:cGameDate];

                char *cGameTime = (char *) sqlite3_column_text(statement, 1);
                schedule.GameTime = [[NSString alloc] initWithUTF8String:cGameTime];

                char *cGameInfo = (char *) sqlite3_column_text(statement, 2);
                schedule.GameInfo = [[NSString alloc] initWithUTF8String:cGameInfo];

                schedule.Event.EventID = sqlite3_column_int(statement, 3);
                schedule.ScheduleID = sqlite3_column_int(statement, 4);

                [listData addObject:schedule];

            }
        }

        sqlite3_finalize(statement);
        sqlite3_close(db);

    }
    return listData;
}

//按照主键查询数据方法
- (Schedule *)findById:(Schedule *)model {

    if ([self openDB]) {

        NSString *qsql = @"SELECT GameDate, GameTime,GameInfo,EventID,ScheduleID FROM Schedule where ScheduleID=?";

        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) == SQLITE_OK) {

            //绑定参数开始
            sqlite3_bind_int(statement, 1, model.ScheduleID);

            //执行
            if (sqlite3_step(statement) == SQLITE_ROW) {

                Schedule *schedule = [[Schedule alloc] init];
                Events *event = [[Events alloc] init];
                schedule.Event = event;

                char *cGameDate = (char *) sqlite3_column_text(statement, 0);
                schedule.GameDate = [[NSString alloc] initWithUTF8String:cGameDate];

                char *cGameTime = (char *) sqlite3_column_text(statement, 1);
                schedule.GameTime = [[NSString alloc] initWithUTF8String:cGameTime];

                char *cGameInfo = (char *) sqlite3_column_text(statement, 2);
                schedule.GameInfo = [[NSString alloc] initWithUTF8String:cGameInfo];

                schedule.Event.EventID = sqlite3_column_int(statement, 3);

                schedule.ScheduleID = sqlite3_column_int(statement, 4);

                sqlite3_finalize(statement);
                sqlite3_close(db);

                return schedule;
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return nil;
}


@end
