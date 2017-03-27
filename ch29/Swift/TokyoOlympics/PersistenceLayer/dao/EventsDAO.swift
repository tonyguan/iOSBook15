//
//  EventsDAO.swift
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

import Foundation

public class EventsDAO: BaseDAO {
    
    public static let sharedInstance: EventsDAO = {
        let instance = EventsDAO()
        return instance
    }()
    
    //插入方法
    public func create(_ model: Events) -> Int {
        
        if self.openDB() {
            let sql = "INSERT INTO Events (EventName, EventIcon,KeyInfo,BasicsInfo,OlympicInfo) VALUES (?,?,?,?,?)"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            var statement: OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql, -1, &statement, nil) == SQLITE_OK {
                
                let cEventName = model.EventName!.cString(using: String.Encoding.utf8)
                let cEventIcon = model.EventIcon!.cString(using: String.Encoding.utf8)
                let cKeyInfo = model.KeyInfo!.cString(using: String.Encoding.utf8)
                let cBasicsInfo = model.BasicsInfo!.cString(using: String.Encoding.utf8)
                let cOlympicInfo = model.OlympicInfo!.cString(using: String.Encoding.utf8)
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, cEventName, -1, nil)
                sqlite3_bind_text(statement, 2, cEventIcon, -1, nil)
                sqlite3_bind_text(statement, 3, cKeyInfo, -1, nil)
                sqlite3_bind_text(statement, 4, cBasicsInfo, -1, nil)
                sqlite3_bind_text(statement, 5, cOlympicInfo , -1, nil)
                
                //执行插入
                if (sqlite3_step(statement) != SQLITE_DONE) {
                    sqlite3_finalize(statement)
                    sqlite3_close(db)
                    assert(false, "插入数据失败。")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return 0
    }
    
    //删除方法
    public func remove(_ model: Events) -> Int {
        
        if self.openDB() {
            
            //先删除子表（比赛日程表）相关数据
            let sqlScheduleStr = String(format: "DELETE  from Schedule where EventID=%i", model.EventID!)
            let cSqlScheduleStr = sqlScheduleStr.cString(using: String.Encoding.utf8)
            
            //开启事务，立刻提交之前事务
            sqlite3_exec(db, "BEGIN IMMEDIATE TRANSACTION", nil, nil, nil)
            
            if sqlite3_exec(db, cSqlScheduleStr, nil, nil, nil) != SQLITE_OK {
                //回滚事务
                sqlite3_exec(db, "ROLLBACK TRANSACTION", nil, nil, nil)
                assert(false, "删除数据失败。")
            }
            
            //先删除主表（比赛项目）数据
            let sqlEventsStr = String(format: "DELETE  from Events where EventID =%i", model.EventID!)
            let cSqlEventsStr = sqlEventsStr.cString(using: String.Encoding.utf8)
            
            if sqlite3_exec(db, cSqlEventsStr, nil, nil, nil) != SQLITE_OK {
                //回滚事务
                sqlite3_exec(db, "ROLLBACK TRANSACTION", nil, nil, nil)
                assert(false, "删除数据失败。")
            }
            //提交事务
            sqlite3_exec(db, "COMMIT TRANSACTION", nil, nil, nil)
            
            sqlite3_close(db)
        }
        return 0
    }
    
    //修改方法
    public func modify(_ model: Events) -> Int {
        
        if self.openDB() {
            let sql = "UPDATE Events set EventName=?, EventIcon=?,KeyInfo=?,BasicsInfo=?,OlympicInfo=? where EventID =?"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            var statement: OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql, -1, &statement, nil) == SQLITE_OK {
                
                let cEventName = model.EventName!.cString(using: String.Encoding.utf8)
                let cEventIcon = model.EventIcon!.cString(using: String.Encoding.utf8)
                let cKeyInfo = model.KeyInfo!.cString(using: String.Encoding.utf8)
                let cBasicsInfo = model.BasicsInfo!.cString(using: String.Encoding.utf8)
                let cOlympicInfo = model.OlympicInfo!.cString(using: String.Encoding.utf8)
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, cEventName, -1, nil)
                sqlite3_bind_text(statement, 2, cEventIcon, -1, nil)
                sqlite3_bind_text(statement, 3, cKeyInfo, -1, nil)
                sqlite3_bind_text(statement, 4, cBasicsInfo, -1, nil)
                sqlite3_bind_text(statement, 5,cOlympicInfo , -1, nil)
                sqlite3_bind_int(statement, 6, Int32(model.EventID!))
                
                //执行插入
                if (sqlite3_step(statement) != SQLITE_DONE) {
                    sqlite3_finalize(statement)
                    sqlite3_close(db)
                    assert(false, "修改数据失败。")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return 0
    }
    
    //查询所有数据方法
    public func findAll() -> [Events] {
        
        var listData = [Events]()
        
        if self.openDB() {
            
            let sql = "SELECT EventName, EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID FROM Events"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            var statement: OpaquePointer? = nil
            
            //预处理过程
            if sqlite3_prepare_v2(db, cSql, -1, &statement, nil) == SQLITE_OK {
                
                //执行
                while sqlite3_step(statement) == SQLITE_ROW {
                    
                    let events = Events()
                    
                    if let strEeventName = getColumnValue(index:0, stmt:statement!) {
                        events.EventName = strEeventName
                    }
                    if let strEventIcon = getColumnValue(index:1, stmt:statement!) {
                        events.EventIcon = strEventIcon
                    }
                    if let strKeyInfo = getColumnValue(index:2, stmt:statement!) {
                        events.KeyInfo = strKeyInfo
                    }
                    if let strBasicsInfo = getColumnValue(index:3, stmt:statement!) {
                        events.BasicsInfo = strBasicsInfo
                    }
                    if let strOlympicInfo = getColumnValue(index:4, stmt:statement!) {
                        events.OlympicInfo = strOlympicInfo
                    }
                    events.EventID = Int(sqlite3_column_int(statement, 5))
                    
                    listData.append(events)
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return listData
    }
    
    //修改Note方法
    public func findById(_ model: Events) -> Events? {
        
        if self.openDB() {
            
            let sql = "SELECT EventName, EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID FROM Events where EventID =?"
           let cSql = sql.cString(using: String.Encoding.utf8)
            
            var statement: OpaquePointer? = nil
            
            //预处理过程
            if sqlite3_prepare_v2(db, cSql, -1, &statement, nil) == SQLITE_OK {
                //绑定参数开始
                sqlite3_bind_int(statement, 1, Int32(model.EventID!))
                //执行
                while sqlite3_step(statement) == SQLITE_ROW {
                    
                    let events = Events()
                    
                    if let strEeventName = getColumnValue(index:0, stmt:statement!) {
                        events.EventName = strEeventName
                    }
                    if let strEventIcon = getColumnValue(index:1, stmt:statement!) {
                        events.EventIcon = strEventIcon
                    }
                    if let strKeyInfo = getColumnValue(index:2, stmt:statement!) {
                        events.KeyInfo = strKeyInfo
                    }
                    if let strBasicsInfo = getColumnValue(index:3, stmt:statement!) {
                        events.BasicsInfo = strBasicsInfo
                    }
                    if let strOlympicInfo = getColumnValue(index:4, stmt:statement!) {
                        events.OlympicInfo = strOlympicInfo
                    }
                    events.EventID = Int(sqlite3_column_int(statement, 5))
                    
                    sqlite3_finalize(statement)
                    sqlite3_close(db)
                    return events
                }
                sqlite3_finalize(statement)
                sqlite3_close(db)
            }
        }
        
        return nil
    }
    
}
