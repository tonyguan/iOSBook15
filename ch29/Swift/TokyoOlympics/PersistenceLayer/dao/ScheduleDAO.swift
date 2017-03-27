//
//  ScheduleDAO.swift
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

public class ScheduleDAO: BaseDAO {
    
    public static let sharedInstance: ScheduleDAO = {
        let instance = ScheduleDAO()
        return instance
    }()
    
    //插入方法
    public func create(_ model: Schedule) -> Int {
        
        if self.openDB() {
            let sql = "INSERT INTO Schedule (GameDate, GameTime,GameInfo,EventID) VALUES (?,?,?,?)"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql, -1, &statement, nil) == SQLITE_OK {
                
                let cGameDate = model.GameDate!.cString(using: String.Encoding.utf8)
                let cGameTime = model.GameTime!.cString(using: String.Encoding.utf8)
                let cGameInfo = model.GameInfo!.cString(using: String.Encoding.utf8)
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, cGameDate, -1, nil)
                sqlite3_bind_text(statement, 2, cGameTime, -1, nil)
                sqlite3_bind_text(statement, 3, cGameInfo, -1, nil)
                sqlite3_bind_int(statement, 4, Int32(model.Event!.EventID!))
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
    public func remove(_ model: Schedule) -> Int {
        
        if self.openDB() {
            let sql = "DELETE  from Schedule where ScheduleID =?"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql, -1, &statement, nil) == SQLITE_OK {
                
                //绑定参数开始
                sqlite3_bind_int(statement, 1, Int32(model.ScheduleID!))
                
                //执行插入
                if (sqlite3_step(statement) != SQLITE_DONE) {
                    sqlite3_finalize(statement)
                    sqlite3_close(db)
                    assert(false, "删除数据失败。")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        
        return 0
    }
    
    //修改方法
    public func modify(_ model: Schedule) -> Int {
        
        if self.openDB() {
            
            let sql = "UPDATE Schedule set GameInfo=?,EventID=?,GameDate =?, GameTime=? where ScheduleID=?"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            var statement:OpaquePointer? = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql, -1, &statement, nil) == SQLITE_OK {
                
                let cGameDate = model.GameDate!.cString(using: String.Encoding.utf8)
                let cGameTime = model.GameTime!.cString(using: String.Encoding.utf8)
                let cGameInfo = model.GameInfo!.cString(using: String.Encoding.utf8)

                //绑定参数开始
                sqlite3_bind_text(statement, 1, cGameInfo, -1, nil)
                sqlite3_bind_int(statement, 2, Int32(model.Event!.EventID!))
                sqlite3_bind_text(statement, 3, cGameDate, -1, nil)
                sqlite3_bind_text(statement, 4, cGameTime, -1, nil)
                sqlite3_bind_int(statement, 5, Int32(model.ScheduleID!))
                
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
    public func findAll() -> [Schedule] {
        
        var listData = [Schedule]()
        
        if self.openDB() {
            
            let sql = "SELECT GameDate, GameTime,GameInfo,EventID,ScheduleID FROM Schedule"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            var statement:OpaquePointer? = nil
            
            //预处理过程
            if sqlite3_prepare_v2(db, cSql, -1, &statement, nil) == SQLITE_OK {
                
                //执行
                while sqlite3_step(statement) == SQLITE_ROW {
                    
                    let schedule = Schedule()
                    let event  = Events()
                    schedule.Event = event
                    
                    if let strGameDate = getColumnValue(index:0, stmt:statement!) {
                        schedule.GameDate = strGameDate
                    }
                    if let strGameTime = getColumnValue(index:1, stmt:statement!) {
                        schedule.GameTime = strGameTime
                    }
                    if let strGameInfo = getColumnValue(index:2, stmt:statement!) {
                        schedule.GameInfo = strGameInfo
                    }
                    schedule.Event!.EventID = Int(sqlite3_column_int(statement, 3))
                    schedule.ScheduleID = Int(sqlite3_column_int(statement, 4))
                    
                    listData.append(schedule)
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        return listData
    }
    
    //修改Note方法
    public func findById(_ model: Schedule) -> Schedule? {
        
        if self.openDB() {
            
            let sql = "SELECT GameDate, GameTime,GameInfo,EventID,ScheduleID FROM Schedule where ScheduleID=?"
            let cSql = sql.cString(using: String.Encoding.utf8)
            
            var statement:OpaquePointer? = nil
            
            //预处理过程
            if sqlite3_prepare_v2(db, cSql, -1, &statement, nil) == SQLITE_OK {
                
                //绑定参数开始
                sqlite3_bind_int(statement, 1, Int32(model.ScheduleID!))
                
                //执行
                if sqlite3_step(statement) == SQLITE_ROW {
                    
                    let schedule = Schedule()
                    let event  = Events()
                    schedule.Event = event
                    
                    if let strGameDate = getColumnValue(index:0, stmt:statement!) {
                        schedule.GameDate = strGameDate
                    }
                    if let strGameTime = getColumnValue(index:1, stmt:statement!) {
                        schedule.GameTime = strGameTime
                    }
                    if let strGameInfo = getColumnValue(index:2, stmt:statement!) {
                        schedule.GameInfo = strGameInfo
                    }
                    schedule.Event!.EventID = Int(sqlite3_column_int(statement, 3))
                    schedule.ScheduleID = Int(sqlite3_column_int(statement, 4))
                    
                    sqlite3_finalize(statement)
                    sqlite3_close(db)
                    
                    return schedule
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        
        return nil
    }
}
