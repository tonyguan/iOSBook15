//
//  BaseDAO.m
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

@implementation BaseDAO

- (id)init {
    self = [super init];
    if (self) {
        //初始化数据库
        [DBHelper initDB];
    }
    return self;
}

- (BOOL)openDB {

    const char* dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
    
    NSLog(@"DbFilePath = %s", dbFilePath);

    if (sqlite3_open(dbFilePath, &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败。");
        return FALSE;
    }
    return TRUE;
}

@end
