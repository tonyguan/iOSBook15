//
//  CoreDataDAO.m
//  PersistenceLayer
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

#import "CoreDataDAO.h"

@implementation CoreDataDAO

@synthesize persistentContainer = _persistentContainer;

#pragma mark - Core Data 堆栈

//返回持久化存储容器
- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            //设置持久化存储描述对象
            NSPersistentStoreDescription *description = [[NSPersistentStoreDescription alloc] init];
            [description setValue:@"OFF" forPragmaNamed:@"synchronous"];
            [description setValue:@"OFF" forPragmaNamed:@"count_changes"];
            [description setValue:@"MEMORY" forPragmaNamed:@"journal_mode"];
            [description setValue:@"MEMORY" forPragmaNamed:@"temp_store"];
            
            _persistentContainer.persistentStoreDescriptions = @[description];
            
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CoreDataNotes"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"持久化存储容器错误：%@", error.localizedDescription);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}

#pragma mark -保存数据
//保存数据
- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"数据保存错误：%@", error.localizedDescription);
        abort();
    }
}


@end
