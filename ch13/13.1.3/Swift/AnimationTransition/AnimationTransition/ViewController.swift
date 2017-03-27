//
//  ViewController.swift
//  AnimationTransition
//
//  Created by tony on 2017/3/24.
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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func doUIViewAnimation(_ sender: AnyObject) {

        let button = sender as! UIButton
        print("tag = ", button.tag)

        switch button.tag {
        case 1:
            UIView.transition(with: self.view, duration: 1.5, options: [.curveEaseOut, .transitionFlipFromLeft], animations: nil, completion: nil)
        case 2:
            UIView.transition(with: self.view, duration: 1.5, options: [.curveEaseOut, .transitionFlipFromRight], animations: nil, completion: nil)
        case 3:
            UIView.transition(with: self.view, duration: 1.5, options: [.curveEaseOut, .transitionCurlUp], animations: nil, completion: nil)
        default:
            UIView.transition(with: self.view, duration: 1.5, options: [.curveEaseOut, .transitionCurlDown], animations: nil, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

