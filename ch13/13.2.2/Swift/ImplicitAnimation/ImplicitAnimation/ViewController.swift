//
//  ViewController.swift
//  ImplicitAnimation
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

    var plane: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //界面初始化
        let screen = UIScreen.main.bounds

        let imageWidth: CGFloat = 100
        let imageHeight: CGFloat = 100
        let imageTopView: CGFloat = 25
        let imageLeftView: CGFloat = 20
        let imageFrame = CGRect(x: imageLeftView,
                y: imageTopView, width: imageWidth, height: imageHeight)
        //创建Image View对象plane
        self.plane = UIImageView(frame: imageFrame)
        //设置plane的图片属性
        self.plane.image = UIImage(named: "clipartPlane.png")
        //设置plane视图上的层opacity属性
        self.plane.layer.opacity = 0.25
        //添加plane到当前视图
        self.view.addSubview(self.plane)

        //创建按钮对象
        let button = UIButton(type: .custom)
        //设置按钮正常状态时显示图片
        button.setImage(UIImage(named: "ButtonOutline.png"), for: .normal)
        //设置按钮高亮状态时显示图片
        button.setImage(UIImage(named: "ButtonOutlineHighlighted.png"), for: .highlighted)
        //设置按钮触摸动作输出口
        button.addTarget(self, action: #selector(movePlane(_:)), for: .touchUpInside)

        let buttonWidth: CGFloat = 130
        let buttonHeight: CGFloat = 50
        let buttonTopView: CGFloat = 500
        button.frame = CGRect(x: (screen.size.width - buttonWidth) / 2,
                y: buttonTopView, width: buttonWidth, height: buttonHeight)
        //添加按钮到当前视图
        self.view.addSubview(button)

    }

    func movePlane(_ sender: AnyObject) {

        //创建平移仿射变换
        let moveTransform = CGAffineTransform(translationX: 200, y: 300)
        //将仿射变换作用于plane视图上的层
        self.plane.layer.setAffineTransform(moveTransform)
        //设置层的opacity属性
        self.plane.layer.opacity = 1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

