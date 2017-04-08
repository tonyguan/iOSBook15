//
//  ViewController.swift
//  PanGestureRecognizer
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

    var boolTrashEmptyFlag = false
    //垃圾桶是否为空标志：false-桶满；true-桶空

    var imageTrashFull: UIImage!
    var imageTrashEmpty: UIImage!

    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //界面初始化
        let screen = UIScreen.main.bounds
        let imageViewWidth: CGFloat = 128
        let imageViewHeight: CGFloat = 128
        let imageViewTopView: CGFloat = 148
        let frame = CGRect(x: (screen.size.width - imageViewWidth) / 2, y: imageViewTopView, width: imageViewWidth, height: imageViewHeight)
        self.imageView = UIImageView(frame: frame)
        self.view.addSubview(self.imageView)

        //创建图片对象
        self.imageTrashFull = UIImage(named: "Blend Trash Full")
        self.imageTrashEmpty = UIImage(named: "Blend Trash Empty")

        self.imageView.image = self.imageTrashFull

        //创建Pan手势识别器
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(foundPan(_:)))
        //设置Pan手势识别器属性
        recognizer.minimumNumberOfTouches = 1
        recognizer.maximumNumberOfTouches = 1

        //Pan手势识别器关联到imageView
        self.imageView.addGestureRecognizer(recognizer)
        //设置imageView开启用户事件
        self.imageView.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func foundPan(_ sender: UIPanGestureRecognizer) {

        print("平移 state = ", sender.state.rawValue)

        if sender.state != .ended && sender.state != .failed {
            let location = sender.location(in: sender.view!.superview)
            sender.view!.center = location
        }
    }
}

