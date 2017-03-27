//
//  ViewController.swift
//  SwitchSliderSegmentedControl
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
    
    var leftSwitch: UISwitch!
    
    var rightSwitch: UISwitch!
    
    var sliderValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screen = UIScreen.main.bounds
        
        /// 1.添加rightSwitch控件
        //rightSwitch与屏幕左边距
        //leftSwitch与屏幕右边距
        let switchScreenSpace:CGFloat = 39
        
        self.rightSwitch = UISwitch()
        var frame = self.rightSwitch.frame
        frame.origin = CGPoint(x: switchScreenSpace, y: 98)
        //重新设置控件的位置
        self.rightSwitch.frame = frame
        //设置控件状态
        self.rightSwitch.isOn = true
        //指定事件处理方法
        self.rightSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        self.view.addSubview(self.rightSwitch)
        
        /// 2.添加leftSwitch控件
        self.leftSwitch = UISwitch()
        frame = self.leftSwitch.frame
        frame.origin = CGPoint(x: screen.size.width - (frame.size.width + switchScreenSpace), y: 98)
        //重新设置控件的位置
        self.leftSwitch.frame = frame
        //设置控件状态
        self.leftSwitch.isOn = true
        //指定事件处理方法
        self.leftSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        self.view.addSubview(self.leftSwitch)
        
        /// 3.添加segmentedControl控件
        let segments = ["Right", "Left"]
        let segmentedControl = UISegmentedControl(items: segments)
        
        let scWidth:CGFloat = 220
        let scHeight:CGFloat = 29 //29默认高度
        let scTopView:CGFloat = 186
        frame = CGRect(x: (screen.size.width - scWidth)/2 , y: scTopView, width: scWidth, height: scHeight)
        //重新设置控件的位置
        segmentedControl.frame = frame
        //指定事件处理方法
        segmentedControl.addTarget(self, action: #selector(touchDown(_:)), for: .valueChanged)
        
        self.view.addSubview(segmentedControl)
        
        /// 4.添加slider控件
        let sliderWidth:CGFloat  = 300
        let sliderHeight:CGFloat  = 31 //31默认高度
        let sliderdTopView:CGFloat  = 298
        let slider = UISlider(frame: CGRect(x: (screen.size.width - sliderWidth)/2 , y: sliderdTopView, width: sliderWidth, height: sliderHeight))
        
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.value = 50.00
        
        //指定事件处理方法
        slider.addTarget(self, action: #selector(sliderValueChange(_:)), for: .valueChanged)
        
        self.view.addSubview(slider)
        
        /// 5.添加SliderValue：标签
        //SliderValue：标签与Slider之间的距离
        let labelSliderValueSliderSpace:CGFloat = 30
        let labelSliderValue = UILabel(frame: CGRect(x: slider.frame.origin.x, y: slider.frame.origin.y - labelSliderValueSliderSpace, width: 103, height: 21))
        
        labelSliderValue.text = "SliderValue："
        self.view.addSubview(labelSliderValue)
        
        /// 6.添加sliderValue标签
        self.sliderValue = UILabel(frame: CGRect(x: labelSliderValue.frame.origin.x + 120, y: labelSliderValue.frame.origin.y, width: 50, height: 21))
        self.sliderValue.text = "50"
        self.view.addSubview(self.sliderValue)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //使两个开关的值保持一致
    func switchValueChanged(_ sender: AnyObject) {
        let witchSwitch = sender as! UISwitch
        let setting = witchSwitch.isOn
        self.leftSwitch.setOn(setting, animated: true)
        self.rightSwitch.setOn(setting, animated: true)
    }
    
    //点击分段控件控制开关控件的隐藏或显示
    func touchDown(_ sender: AnyObject) {
        
        let segmentedControl = sender as! UISegmentedControl
        print("选择的段 : ", segmentedControl.selectedSegmentIndex)
        
        if (self.leftSwitch.isHidden == true) {
            self.rightSwitch.isHidden = false
            self.leftSwitch.isHidden  = false
        }else {
            self.rightSwitch.isHidden = true
            self.leftSwitch.isHidden  = true
        }
    }
    
    //用标签显示滑块的值
    func sliderValueChange(_ sender: AnyObject) {
        let slider = sender as! UISlider
        let progressAsInt = Int(slider.value)
        let newText = String(format: "%d", progressAsInt)
        print("滑块的值 : ", newText)
        self.sliderValue.text = newText
    }
}

