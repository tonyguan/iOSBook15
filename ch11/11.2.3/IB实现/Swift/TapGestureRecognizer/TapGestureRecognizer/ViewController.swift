//
//  ViewController.swift
//  TapGestureRecognizer
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
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建图片对象
        self.imageTrashFull = UIImage(named: "Blend Trash Full")
        self.imageTrashEmpty = UIImage(named: "Blend Trash Empty")
        
        self.imageView.image = self.imageTrashFull
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Tap手势处理方法
    @IBAction func foundTap(_ sender: AnyObject) {
        print("Tap")
        if boolTrashEmptyFlag {
            self.imageView.image = self.imageTrashFull
            boolTrashEmptyFlag = false
        } else {
            self.imageView.image = self.imageTrashEmpty
            boolTrashEmptyFlag = true
        }
    }

}

