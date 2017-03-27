//
//  NoteDAO.swift
//  MyNotes
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

public class NoteDAO : CoreDataDAO {
    
    //私有的DateFormatter属性
    private var dateFormatter = DateFormatter()
    
    public static let sharedInstance: NoteDAO = {
        let instance = NoteDAO()
        
        //初始化DateFormatter
        instance.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return instance
    }()
    
    //插入Note方法
    public func create(_ model: Note) -> Int {
        
        let context = persistentContainer.viewContext
        
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into:context) as! NoteManagedObject
        
        note.date = model.date
        note.content = model.content
        
        //保存数据
        self.saveContext()
        
        return 0
    }
    
    //删除Note方法
    public func remove(_ model: Note) -> Int {
        
        let context = persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "date = %@", model.date)
        
        do {
            let listData = try context.fetch(fetchRequest)
            if listData.count > 0 {
                let note = listData[0] as! NSManagedObject
                context.delete(note)
                //保存数据
                self.saveContext()
            }
        } catch {
            NSLog("删除数据失败")
        }
        return 0
    }
    
    //修改Note方法
    public func modify(_ model: Note) -> Int {
        
        let context = persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "date = %@", model.date)
        
        do {
            let listData = try context.fetch(fetchRequest)
            if listData.count > 0 {
                let note = listData[0] as! NoteManagedObject
                //note.setValue(model.content, forKey: "content")
                note.content = model.content
                
                //保存数据
                self.saveContext()
            }
        } catch {
            NSLog("修改数据失败")
        }
        return 0
    }
    
    //查询所有数据方法
    public func findAll() -> NSMutableArray {
        
        let context = persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        
        let sortDescriptor = NSSortDescriptor(key:"date", ascending:true)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        let resListData = NSMutableArray()
        
        do {
            let listData = try context.fetch(fetchRequest)
            
            if listData.count > 0 {
                
                for item in listData {
                    let mo = item as! NoteManagedObject
                    let note = Note(date: mo.date!, content: mo.content!)
                    resListData.add(note)
                }
            }
        } catch {
            NSLog("查询数据失败")
        }
        
        return resListData
    }
    
    //按照主键查询数据方法
    public func findById(_ model: Note) -> Note? {
        
        let context = persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "date = %@", model.date)
        
        do {
            let listData = try context.fetch(fetchRequest)
            
            if listData.count > 0 {
                let mo = listData[0] as! NoteManagedObject
                let note = Note(date: mo.date!, content: mo.content!)
                return note
            }
        } catch {
            NSLog("查询数据失败")
        }
        return nil
    }
    
}
