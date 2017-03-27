//
//  ViewController.swift
//  NavigationBarSample
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
        
        /// 1.创建NavigationBar
        let navigationBarHeight:CGFloat = 44 //44默认高度
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: screen.size.width, height: navigationBarHeight))
        
        let saveButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(ViewController.save(_:)))
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.add(_:)))
        
        let navigationItem = UINavigationItem(title: "")
        navigationItem.leftBarButtonItem = saveButtonItem
        navigationItem.rightBarButtonItem = addButtonItem
        
        navigationBar.items = [navigationItem]
        self.view.addSubview(navigationBar)
        
        ///2.添加标签
        let labelWidth:CGFloat = 84
        let labelHeight:CGFloat = 21
        let labelTopView:CGFloat = 198
        self.label = UILabel(frame: CGRect(x: (screen.size.width - labelWidth)/2 , y: labelTopView, width: labelWidth, height: labelHeight))
        
        self.label.text = "Label"
        //字体左右居中
        self.label.textAlignment = .center
        self.view.addSubview(self.label)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func save(_ sender: AnyObject) {
        self.label.text = "点击Save"
    }
    
    func add(_ sender: AnyObject) {
        self.label.text = "点击Add"
    }

}

