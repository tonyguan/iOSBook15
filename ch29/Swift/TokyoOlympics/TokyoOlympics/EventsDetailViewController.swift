//
//  EventsDetailViewController.swift
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

class EventsDetailViewController: UIViewController {
    
    var event: Events!
    
    var imgEventIcon: UIImageView!
    var lblEventName: UILabel!
    var txtViewKeyInfo: UITextView!
    var txtViewBasicsInfo: UITextView!
    var txtViewOlympicInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.main.bounds
        
        self.view.backgroundColor = UIColor.white
        
        /// 1.添加ImageView
        self.imgEventIcon = UIImageView(frame: CGRect(x: 10, y: 80, width: 102, height: 102))
        self.imgEventIcon.image = UIImage(named : self.event.EventIcon!)
        self.view.addSubview(self.imgEventIcon)
        
        /// 2.lblEventName标签
        self.lblEventName = UILabel(frame: CGRect(x: 160, y: 140, width: 200, height: 30))
        self.lblEventName.text = self.event.EventName
        self.lblEventName.font = UIFont.boldSystemFont(ofSize: 20)
        self.view.addSubview(self.lblEventName)
        
        /// 3.txtViewBasicsInfo标签
        self.txtViewKeyInfo = UITextView(frame: CGRect(x: 10, y: self.imgEventIcon.frame.origin.y + 120, width: screen.size.width - 20, height: 90))
        self.txtViewKeyInfo.isEditable = true
        self.txtViewKeyInfo.text = self.event.KeyInfo
        self.view.addSubview(self.txtViewKeyInfo)
        
        /// 4.静态标签The Basics
        var label = UILabel(frame: CGRect(x: 10, y: self.txtViewKeyInfo.frame.origin.y + 100, width: 200, height: 30))
        label.text = "The Basics"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        self.view.addSubview(label)
        
        /// 5.txtViewBasicsInfo标签
        self.txtViewBasicsInfo = UITextView(frame: CGRect(x: 10, y: label.frame.origin.y + 30, width: screen.size.width - 20, height: 90))
        self.txtViewBasicsInfo.isEditable = true
        self.txtViewBasicsInfo.text = self.event.BasicsInfo
        self.view.addSubview(self.txtViewBasicsInfo)
        
        /// 6.静态标签Olympic past and present
        label = UILabel(frame: CGRect(x: 10, y: self.txtViewBasicsInfo.frame.origin.y + 100, width: 300, height: 30))
        label.text = "Olympic past and present"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        self.view.addSubview(label)
        
        /// 7.txtViewOlympicInfo标签
        self.txtViewOlympicInfo = UITextView(frame: CGRect(x: 10, y: label.frame.origin.y + 30, width: screen.size.width - 20, height: 90))
        self.txtViewKeyInfo.isEditable = true
        self.txtViewOlympicInfo.text = self.event.KeyInfo
        self.view.addSubview(self.txtViewOlympicInfo)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
