//
//  ViewController.swift
//  ExplicitAnimation
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

        //创建opacity动画
        let opAnim = CABasicAnimation(keyPath: "opacity")
        //设置动画持续时间
        opAnim.duration = 3.0
        //设置opacity开始值
        opAnim.fromValue = 0.25
        //设置opacity结束值
        opAnim.toValue = 1.0
        //设置累计上次值
        opAnim.isCumulative = true
        //设置动画重复2次
        opAnim.repeatCount = 2
        //设置动画结束时候处理方式
        opAnim.fillMode = kCAFillModeForwards
        //设置动画结束时是否停止
        opAnim.isRemovedOnCompletion = false
        //添加动画到层
        self.plane.layer.add(opAnim, forKey : "animateOpacity")
        
        //创建平移仿射变换
        let moveTransform = CGAffineTransform(translationX: 200, y: 300)
        //创建平移动画
        let moveAnim = CABasicAnimation(keyPath: "transform")
        moveAnim.duration = 6.0
        //设置结束位置
        moveAnim.toValue = NSValue(caTransform3D: CATransform3DMakeAffineTransform(moveTransform))
        moveAnim.fillMode = kCAFillModeForwards
        moveAnim.isRemovedOnCompletion = false
        self.plane.layer.add(moveAnim, forKey : "animateTransform")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
