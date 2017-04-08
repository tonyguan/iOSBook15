//
//  ViewController.swift
//  LongPressGestureRecognizer
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

    var boolTrashEmptyFlag = false //垃圾桶是否为空标志：false-桶满；true-桶空
    
    var imageTrashFull : UIImage!
    var imageTrashEmpty : UIImage!
    
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //界面初始化
        let screen = UIScreen.main.bounds
        let imageViewWidth: CGFloat = 128
        let imageViewHeight: CGFloat = 128
        let imageViewTopView: CGFloat = 148
        let frame = CGRect(x: (screen.size.width - imageViewWidth)/2, y: imageViewTopView, width: imageViewWidth, height: imageViewHeight)
        self.imageView = UIImageView(frame: frame)
        self.view.addSubview(self.imageView)
        
        //创建图片对象
        self.imageTrashFull = UIImage(named: "Blend Trash Full")
        self.imageTrashEmpty = UIImage(named: "Blend Trash Empty")
        
        self.imageView.image = self.imageTrashFull
        
        //创建Long Press手势识别器
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(foundLongPress(_:)))
        
        //设置Long Press手势识别器属性
        recognizer.allowableMovement = 100.0
        recognizer.minimumPressDuration = 1.0
        
        //Long Press手势识别器关联到imageView
        self.imageView.addGestureRecognizer(recognizer)
        //设置imageView开启用户事件
        self.imageView.isUserInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func foundLongPress(_ sender: UITapGestureRecognizer) {
        
        print("长按 state = ", sender.state.rawValue)
        
        if (sender.state == .began) { //手势开始
            if boolTrashEmptyFlag {
                self.imageView.image = self.imageTrashFull
                boolTrashEmptyFlag = false
            } else {
                self.imageView.image = self.imageTrashEmpty
                boolTrashEmptyFlag = true
            }
        }
    }

}

