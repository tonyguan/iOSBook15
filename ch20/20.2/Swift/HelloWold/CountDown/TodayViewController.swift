//
//  TodayViewController.swift
//  CountDown
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
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var lblCountDown: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建DateComponents对象
        var comps = DateComponents()
        //设置DateComponents对象的日期属性
        comps.day = 24
        //设置DateComponents对象的月属性
        comps.month = 7
        //设置DateComponents对象的年属性
        comps.year = 2020
        
        //创建日历对象
        let calender = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
        
        //获得2020-7-24日的Date日期对象
        let destinationDate = calender!.date(from: comps)
        let date = Date()
        //获得当前日期到2020-7-24时间的DateComponents对象
        let components = calender!.components(.day, from: date, to:destinationDate!, options: .wrapComponents)
        //获得当前日期到2020-7-24相差的天数
        let days = components.day
        
        let strLabel = NSMutableAttributedString(string: String(format:"%i天", days!))
        
        strLabel.addAttribute(NSFontAttributeName,
                              value: UIFont.preferredFont(forTextStyle: .footnote),
                              range: NSMakeRange(strLabel.length - 1, 1))
        
        self.lblCountDown.attributedText = strLabel
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
