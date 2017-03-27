//
//  ViewController.swift
//  SwipeGestureRecognizer
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
        let labelWidth: CGFloat = 300
        let labelHeight: CGFloat = 30
        let labelTopView: CGFloat = 150
        let frame = CGRect(x: (screen.size.width - labelWidth) / 2, y: labelTopView, width: labelWidth, height: labelHeight)
        self.label = UILabel(frame: frame)
        self.label.text = "Swipe（滑动）手势识别"
        //字体左右居中
        self.label.textAlignment = NSTextAlignment.center
        self.view.addSubview(self.label)

        //创建4个Swipe手势识别器
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left, .up, .down]
        for direction in directions {
            let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(foundSwipe(_:)))
            //设置识别滑动方向
            recognizer.direction = direction
            //Swipe手势识别器关联到View
            self.view.addGestureRecognizer(recognizer)
        }

        //设置View开启用户事件
        self.view.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func foundSwipe(_ sender: UISwipeGestureRecognizer) {

        print("direction = ", sender.direction.rawValue)

        switch sender.direction {
        case UISwipeGestureRecognizerDirection.down:
            self.label.text = "向下滑动"
        case UISwipeGestureRecognizerDirection.left:
            self.label.text = "向左滑动"
        case UISwipeGestureRecognizerDirection.right:
            self.label.text = "向右滑动"
        case UISwipeGestureRecognizerDirection.up:
            self.label.text = "向上滑动"
        default:
            self.label.text = "未知"
        }
    }
}

