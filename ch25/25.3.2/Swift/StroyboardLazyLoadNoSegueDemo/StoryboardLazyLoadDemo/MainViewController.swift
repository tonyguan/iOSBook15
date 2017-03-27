//
//  MainViewController.swift
//  StroyboardLazyLoadNotSegueDemo
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
        
        //获得当前故事板对象
        let mainStoryboard = self.storyboard
        
        //从故事板文件中创建MainStoryboard故事板对象
        //let mainStoryboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        
        //通过名为flipsideViewController的Storyboard ID创建视图控制器对象
        let flipsideViewController = mainStoryboard?.instantiateViewController(withIdentifier: "flipsideViewController") as! FlipsideViewController
        
        flipsideViewController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
        self.present(flipsideViewController, animated: true, completion: nil)
        
    }

}

