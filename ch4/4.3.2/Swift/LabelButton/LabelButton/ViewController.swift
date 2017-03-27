//
//  ViewController.swift
//  LabelButton
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
    
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.main.bounds
        
        let labelWidth:CGFloat = 90
        let labelHeight:CGFloat = 20
        let labelTopView:CGFloat = 150
        let labelFrame = CGRect(x: (screen.size.width - labelWidth)/2 ,
                           y: labelTopView, width: labelWidth, height: labelHeight)
        
        self.label = UILabel(frame: labelFrame)
        
        self.label.text = "Label"
        //字体左右居中
        self.label.textAlignment = NSTextAlignment.center
        self.view.addSubview(self.label)
        
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("OK", for: UIControlState.normal)
        
        let buttonWidth:CGFloat = 60
        let buttonHeight:CGFloat = 20
        let buttonTopView:CGFloat = 240
        
        button.frame = CGRect(x: (screen.size.width - buttonWidth)/2 ,
                              y: buttonTopView, width: buttonWidth, height: buttonHeight)
        button.addTarget(self, action: #selector(onClick(_:)),
                         for: UIControlEvents.touchUpInside)
        
//        button.addTarget(self, action: #selector(onClick(_:forEvent:)),
//                         for: UIControlEvents.touchUpInside)

        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onClick(_ sender: AnyObject) {
        self.label.text = "HelloWorld"
    }

//    func onClick(_ sender: AnyObject, forEvent event: UIEvent) {
//        print("OK Button onClick.")
//    }

}

