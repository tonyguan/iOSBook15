//
//  MainViewController.swift
//  StoryboardLazyLoadDemo
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

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showInfo(_ sender: AnyObject) {
        
        //通过xib文件创建视图控制器对象
        let flipsideViewController = FlipsideViewController(nibName: "FlipsideViewController", bundle: nil)
        
        flipsideViewController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
        self.present(flipsideViewController, animated: true, completion:nil)
    }

}

