//
//  RootViewController.swift
//  HelloWorld
//
//  Created by tonyguan on 2016/10/19.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.main.bounds
        let labelWidth:CGFloat = 90
        let labelHeight:CGFloat = 20
        let labelTopView:CGFloat = 150
        let frame = CGRect(x: (screen.size.width - labelWidth)/2, y: labelTopView, width: labelWidth, height: labelHeight)
        let label = UILabel(frame: frame)
        label.text = "HelloWorld"
        
        //字体左右居中
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
