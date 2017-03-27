//
//  CoreDataDAO.swift
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


import Foundation
import CoreData

open class CoreDataDAO: NSObject {

    //返回持久化存储容器
    lazy var persistentContainer: NSPersistentContainer = {
        
        //设置持久化存储描述对象
        let description = NSPersistentStoreDescription()
        description.setValue("OFF" as NSObject?, forPragmaNamed: "synchronous")
        description.setValue("OFF" as NSObject?, forPragmaNamed: "count_changes")
        description.setValue("MEMORY" as NSObject?, forPragmaNamed: "journal_mode")
        description.setValue("MEMORY" as NSObject?, forPragmaNamed: "temp_store")
        
        let container = NSPersistentContainer(name: "CoreDataNotes")
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("持久化存储容器错误：", error.localizedDescription)
            }
        })
        return container
    }()

    /// MARK: - 保存数据
    //保存数据
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("数据保存错误：", nserror.localizedDescription)

            }
        }
    }
}
