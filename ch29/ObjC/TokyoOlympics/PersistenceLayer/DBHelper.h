//
//  DBHelper.h
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
#import "sqlite3.h"

#define DB_FILE_NAME @"app.db"

static sqlite3 *db;

@interface DBHelper : NSObject

//获得沙箱Document目录下全路径
+ (const char *)applicationDocumentsDirectoryFile:(NSString *)fileName;

//初始化并加载数据
+ (void)initDB;

//从数据库获得当前数据库版本号
+ (int)dbVersionNubmer;

@end
