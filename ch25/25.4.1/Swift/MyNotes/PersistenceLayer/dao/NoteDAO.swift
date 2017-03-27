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

public class NoteDAO {
    
    //私有的DateFormatter属性
    private var dateFormatter = DateFormatter()
    //私有的沙箱目录中属性列表文件路径
    private var plistFilePath: String!
    
    public static let sharedInstance: NoteDAO = {
        let instance = NoteDAO()
        
        //初始化沙箱目录中属性列表文件路径
        instance.plistFilePath = instance.applicationDocumentsDirectoryFile()
        //初始化DateFormatter
        instance.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //初始化属性列表文件
        instance.createEditableCopyOfDatabaseIfNeeded()
        
        return instance
    }()
    
    //初始化属性列表文件
    private func createEditableCopyOfDatabaseIfNeeded() {
        
        let fileManager = FileManager.default
        let dbexits = fileManager.fileExists(atPath: self.plistFilePath)
        if (!dbexits) {
            
            let frameworkBundle = Bundle(for: NoteDAO.self)
            let frameworkBundlePath = frameworkBundle.resourcePath as NSString?
            let defaultDBPath = frameworkBundlePath!.appendingPathComponent("NotesList.plist")
            
            do {
                try fileManager.copyItem(atPath: defaultDBPath, toPath: self.plistFilePath)
            } catch {
                assert(false, "错误写入文件")
            }
        }
    }
    
    private func applicationDocumentsDirectoryFile() -> String {
        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let path = (documentDirectory[0] as AnyObject).appendingPathComponent("NotesList.plist") as String
        return path
    }
    
    //插入Note方法
    public func create(_ model: Note) -> Int {
        
        let array = self.readFromArray(self.plistFilePath)!
        
        let strDate = self.dateFormatter.string(from: model.date as Date)
        let dict = NSDictionary(objects: [strDate, model.content], forKeys: ["date" as NSCopying, "content" as NSCopying])
        
        array.add(dict)
        self.write(array, toFilePath: self.plistFilePath)
        
        return 0
    }
    
    //删除Note方法
    public func remove(_ model: Note) -> Int {
        
        let array = self.readFromArray(self.plistFilePath)!
        
        for item in array {
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)
            
            //比较日期主键是否相等
            if date! == model.date as Date {
                array.remove(dict)
                self.write(array, toFilePath: self.plistFilePath)
                break
            }
        }
        return 0
    }
    
    //修改Note方法
    public func modify(_ model: Note) -> Int {
        
        let array = self.readFromArray(self.plistFilePath)!
        
        for item in array {
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)
            
            //比较日期主键是否相等
            if date! == model.date as Date {
                dict.setValue(model.content, forKey: "content")
                self.write(array, toFilePath: self.plistFilePath)
                break
            }
        }
        return 0
    }
    //查询所有数据方法
    public func findAll() -> NSMutableArray {
        
        let array = self.readFromArray(self.plistFilePath)!
        
        let listData = NSMutableArray()
        
        for item in array {
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)!
            let content = dict["content"] as! String
            
            let note = Note(date: date, content: content)
            
            listData.add(note)
        }
        
        return listData
    }
    
    //按照主键查询数据方法
    public func findById(_ model: Note) -> Note? {
        
        let array = self.readFromArray(self.plistFilePath)!
        
        for item in array {
            
            let dict = item as! NSDictionary
            let strDate = dict["date"] as! String
            let date = dateFormatter.date(from: strDate)!
            let content = dict["content"] as! String
            
            //比较日期主键是否相等
            if date == model.date as Date {
                let note = Note(date: date, content: content)
                return note
            }
        }
        return nil
    }
    
    //从文件中读取数据到NSMutableArray
    private func readFromArray(_ path: String) -> NSMutableArray? {
        //从文件读取数据到data对象
        let data = NSMutableData(contentsOfFile: path)!
        var array: NSMutableArray!
        do {
            //反序列化到属性列表对象（NSMutableArray）
            array = try PropertyListSerialization.propertyList(from: data as Data, options: .mutableContainersAndLeaves, format: nil) as! NSMutableArray
        } catch let err as NSError {
            NSLog("读取文件失败，%@", err.description)
        }
        return array
    }
    
    //写入NSMutableArray数据到文件中
    private func write(_ array: NSMutableArray, toFilePath path: String) {
        do {
            //把属性列表对象（NSMutableArray）序列化为NSData
            let data = try PropertyListSerialization.data(fromPropertyList: array, format: PropertyListSerialization.PropertyListFormat.binary, options: 0)
            //写入到沙箱目录的序列化文件
            try data.write(to: URL(fileURLWithPath: path), options: .atomic)
        } catch let err as NSError {
            NSLog("写入文件失败，%@", err.description)
        }
    }
}
