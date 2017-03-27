//
//  DBHelper.m
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

#import "DBHelper.h"

@implementation DBHelper

+ (const char *)applicationDocumentsDirectoryFile:(NSString *)fileName {

    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:fileName];

    const char *cpath = [path UTF8String];

    return cpath;
}


//初始化并加载数据
+ (void)initDB {

    NSBundle *frameworkBundle = [NSBundle bundleForClass:[DBHelper class]];

    NSString *configTablePath = [frameworkBundle pathForResource:@"DBConfig" ofType:@"plist"];

    NSDictionary *configTable = [[NSDictionary alloc] initWithContentsOfFile:configTablePath];
    //从配置文件获得数据库版本号
    NSNumber *dbConfigVersion = configTable[@"DB_VERSION"];
    if (dbConfigVersion == nil) {
        dbConfigVersion = 0;
    }
    //从数据库DBVersionInfo表记录返回的数据库版本号
    int versionNubmer = [DBHelper dbVersionNubmer];

    //版本号不一致
    if ([dbConfigVersion intValue] != versionNubmer) {
        const char *dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
        if (sqlite3_open(dbFilePath, &db) == SQLITE_OK) {
            //加载数据到业务表中
            NSLog(@"数据库升级...");
            NSString *createtablePath = [frameworkBundle pathForResource:@"create_load" ofType:@"sql"];
            NSString *sql = [[NSString alloc] initWithContentsOfFile:createtablePath encoding:NSUTF8StringEncoding error:nil];
            sqlite3_exec(db, [sql UTF8String], NULL, NULL, NULL);

            //把当前版本号写回到文件中
            NSString *usql = [[NSString alloc] initWithFormat:@"update  DBVersionInfo set version_number = %i", [dbConfigVersion intValue]];
            sqlite3_exec(db, [usql UTF8String], NULL, NULL, NULL);
        } else {
            NSLog(@"数据库打开失败。");
        }
        sqlite3_close(db);
    }
}

+ (int)dbVersionNubmer {

    int versionNubmer = -1;

    const char *dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];

    if (sqlite3_open(dbFilePath, &db) == SQLITE_OK) {
        NSString *sql = @"create table if not exists DBVersionInfo ( version_number int )";
        sqlite3_exec(db, [sql UTF8String], NULL, NULL, NULL);

        NSString *qsql = @"select version_number from DBVersionInfo";
        const char *cqsql = [qsql UTF8String];

        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, cqsql, -1, &statement, NULL) == SQLITE_OK) {
            //执行查询
            if (sqlite3_step(statement) == SQLITE_ROW) { //有数据情况
                NSLog(@"有数据情况");
                versionNubmer = sqlite3_column_int(statement, 0);
            } else {//无数据情况，插入数据
                NSLog(@"无数据情况");
                NSString *insertSql = @"insert into DBVersionInfo (version_number) values(-1)";
                const char *cInsertSql = [insertSql UTF8String];
                sqlite3_exec(db, cInsertSql, NULL, NULL, NULL);
            }
        }

        sqlite3_finalize(statement);
        sqlite3_close(db);
    } else {
        sqlite3_close(db);
    }

    return versionNubmer;
}


@end
