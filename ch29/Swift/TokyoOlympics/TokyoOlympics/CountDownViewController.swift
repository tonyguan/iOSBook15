//
//  CountDownViewController.swift
//  TokyoOlympics
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

class CountDownViewController: UIViewController {
    
    //显示倒计时
    @IBOutlet weak var lblCountDownPhone: UILabel!
    @IBOutlet weak var lblCountDownPad: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建DateComponents对象
        var comps = DateComponents()
        //设置DateComponents日期
        comps.day = 24
        //设置DateComponents月
        comps.month = 7
        //设置DateComponents年
        comps.year = 2020
        
        //创建日历对象
        let calender = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
        
        //获得2020-7-24日的Date日期对象
        let destinationDate = calender!.date(from: comps  as DateComponents)
        
        let date = Date()
        //获得当前日期到2020-7-24时间的DateComponents对象
        let components = calender!.components(.day, from: date , to:destinationDate!, options:.wrapComponents)
        //获得当前日期到2020-7-24相差的天数
        let days = components.day
        
        let strDays = String(format:"%li天", days!)
        //设置iPhone中的标签
        self.lblCountDownPhone.text = strDays
        //设置Pad中的标签
        self.lblCountDownPad.text = strDays
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
