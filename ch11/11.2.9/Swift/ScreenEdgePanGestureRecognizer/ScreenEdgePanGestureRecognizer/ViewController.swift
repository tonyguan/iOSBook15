//
//  ViewController.swift
//  ScreenEdgePanGestureRecognizer
//
//  Created by tony on 2017/3/20.
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
        
        //初始化界面
        let screen = UIScreen.main.bounds
        let labelWidth: CGFloat = 400
        let labelHeight: CGFloat = 30
        let labelTopView: CGFloat = 150
        let frame = CGRect(x: (screen.size.width - labelWidth) / 2, y: labelTopView, width: labelWidth, height: labelHeight)
        self.label = UILabel(frame: frame)
        self.label.text = "屏幕边缘平移手势识别"
        //字体左右居中
        self.label.textAlignment = NSTextAlignment.center
        self.view.addSubview(self.label)
        
        //创建2个ScreenEdgePan手势识别器
        let edges: [UIRectEdge] = [.right, .left]
        for edge in edges {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(foundScreenEdgePan(_:)))
            //设置识别边缘平移方向
            recognizer.edges = edge
            //ScreenEdgePan手势识别器关联到View
            self.view.addGestureRecognizer(recognizer)
        }
        //设置View开启用户事件
        self.view.isUserInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func foundScreenEdgePan(_ sender: UIScreenEdgePanGestureRecognizer) {
        
        print("edge = ", sender.edges.rawValue)
        
        switch sender.edges {
        case UIRectEdge.left:
            self.label.text = "从左边缘向右平移"
        case UIRectEdge.right:
            self.label.text = "从右边缘向左平移"
        default:
            self.label.text = ""
        }
    }
    
}

