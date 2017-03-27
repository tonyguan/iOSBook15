//
//  ViewController.swift
//  PinchGestureRecognizer
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

    //缩放因子
    var currentScale : CGFloat  = 1.0
    var imageTrashFull : UIImage!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //界面初始化
        let screen = UIScreen.main.bounds
        let imageViewWidth: CGFloat = 128
        let imageViewHeight: CGFloat = 128
        let imageViewTopView: CGFloat = 300
        let frame = CGRect(x: (screen.size.width - imageViewWidth)/2, y: imageViewTopView, width: imageViewWidth, height: imageViewHeight)
        self.imageView = UIImageView(frame: frame)
        self.view.addSubview(self.imageView)
        
        //创建图片对象
        self.imageTrashFull = UIImage(named: "Blend Trash Full")
        self.imageView.image = self.imageTrashFull
        
        //创建Pinch手势识别器
        let recognizer = UIPinchGestureRecognizer(target: self, action: #selector(foundPinch(_:)))
        //Pinch手势识别器关联到imageView
        self.imageView.addGestureRecognizer(recognizer)
        //设置imageView开启用户事件
        self.imageView.isUserInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func foundPinch(_ sender: UIPinchGestureRecognizer) {
        
        print("缩放因子 = ", sender.scale)
        
        if sender.state == .ended {
            currentScale = sender.scale
        } else if sender.state == .began && currentScale != 0.0 {
            sender.scale = currentScale
        }
        
        self.imageView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }

}

