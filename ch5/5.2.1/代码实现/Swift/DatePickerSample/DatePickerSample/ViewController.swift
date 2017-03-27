//
//  ViewController.swift
//  DatePickerSample
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

class ViewController: UIViewController {
    
    
    var datePicker: UIDatePicker!
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.main.bounds
        
        /// 1.日期选择器
        let datePickerWidth:CGFloat = 320
        let datePickerHeight:CGFloat = 167
        self.datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: datePickerWidth, height: datePickerHeight))
        //zh-Hans简体中文
        self.datePicker.locale = Locale(identifier: "zh-Hans")
        //设置日期时间模式
        self.datePicker.datePickerMode = .dateAndTime
        self.view.addSubview(self.datePicker)
        
        ///2.添加标签
        let labelWidth:CGFloat = 200
        let labelHeight:CGFloat = 21
        let labelTopView:CGFloat = 281
        self.label = UILabel(frame: CGRect(x: (screen.size.width - labelWidth)/2 , y: labelTopView, width: labelWidth, height: labelHeight))
        
        self.label.text = "Label"
        //字体左右居中
        self.label.textAlignment = .center
        self.view.addSubview(self.label)
        
        /// 3.Button按钮
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Button", for: UIControlState())
        
        let buttonWidth:CGFloat = 46
        let buttonHeight:CGFloat = 30
        let buttonTopView:CGFloat = 379
        
        button.frame = CGRect(x: (screen.size.width - buttonWidth)/2 , y: buttonTopView, width: buttonWidth, height: buttonHeight)
        //指定事件处理方法
        button.addTarget(self, action: #selector(onclick(_:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func onclick(_ sender: AnyObject) {
        
        let theDate : Date = self.datePicker.date
        let desc = theDate.description(with: Locale.current)
        print("the date picked is: ", desc)
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        print("the date formate is: ", dateFormatter.string(from: theDate))
        
        self.label.text = dateFormatter.string(from: theDate)
        
    }
    
}
