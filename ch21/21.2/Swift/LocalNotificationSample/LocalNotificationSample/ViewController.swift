//
//  ViewController.swift
//  LocalNotificationSample
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


import UIKit
import UserNotifications

class ViewController: UITableViewController, UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func scheduleNotification(_ sender: UIButton) {
        // 创建通知内容
        let content = UNMutableNotificationContent()
        content.body = "通知内容：大家好，新年快乐！"
        //默认的通知提示音
        content.sound = UNNotificationSound.default()
        content.subtitle = "通知副标题"
        content.title = "通知标题"
        // 通知附件
        if let url = Bundle.main.url(forResource: "Icon", withExtension: "png") {
            do {
                let attach = try UNNotificationAttachment(identifier: "icon", url: url, options: nil)
                content.attachments = [attach]
            } catch {
                print("The attachment was not loaded.")
            }
        }
        // 设置通知内容的类别标识
        content.categoryIdentifier = "myCategory"
        
        // 创建触发器
        var trigger = self.createTimeTrigger()
        
        if (sender.tag == 300) {//300是点击日历触发器按钮，200是点击时间中断触发器按钮，
            trigger = self.createCalendarTrigger()
        }
        
        // 创建通知请求对象
        let request = UNNotificationRequest(identifier: "com.51work6.local.Notification" , content: content, trigger: trigger)
        
        // 添加通知
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("添加通知: \(error)")
            } else {
                print("添加通知请求到通知中心")
            }
        }
        
        // 通知接收后的处理
        let action = UNNotificationAction(identifier: "myAction", title: "OK", options: [])
        let category = UNNotificationCategory(identifier: "myCategory",
                                              actions: [action], intentIdentifiers: [], options: [])
        let categories: Set = [category]
        UNUserNotificationCenter.current().setNotificationCategories(categories)
        UNUserNotificationCenter.current().delegate = self
    }
    
    //创建时间中断触发器触发器
    private func createTimeTrigger() -> UNNotificationTrigger {
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        return timeTrigger
    }
    
    //创建日历触发器触发器
    private func createCalendarTrigger() -> UNNotificationTrigger {
        
        var components = DateComponents()
        components.hour = 7
        components.minute = 30
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        return calendarTrigger
    }
    
    //实现委托协议UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "myAction" {
            print("OK！")
        }
        completionHandler()
    }
}

