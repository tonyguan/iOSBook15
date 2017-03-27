//
//  ViewController.swift
//  KeyframeAnimationPath
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

class ViewController: UIViewController, CAAnimationDelegate {

    var ball: UIImageView!
    var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        //界面初始化
        let screen = UIScreen.main.bounds

        let imageWidth: CGFloat = 86
        let imageHeight: CGFloat = 86
        let imageTopView: CGFloat = 150
        let imageFrame = CGRect(x: (screen.size.width - imageWidth) / 2,
                y: imageTopView, width: imageWidth, height: imageHeight)
        //创建Image View对象
        self.ball = UIImageView(frame: imageFrame)
        //设置Image View的图片属性
        self.ball.image = UIImage(named: "Ball.png")
        //添加Image View到当前视图
        self.view.addSubview(self.ball)

        //创建按钮对象
        self.button = UIButton(type: .custom)
        //设置按钮正常状态时显示图片
        self.button.setImage(UIImage(named: "ButtonOutline.png"), for: .normal)
        //设置按钮高亮状态时显示图片
        self.button.setImage(UIImage(named: "ButtonOutlineHighlighted.png"), for: .highlighted)
        //设置按钮触摸动作输出口
        self.button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)

        let buttonWidth: CGFloat = 130
        let buttonHeight: CGFloat = 50
        let buttonTopView: CGFloat = 500
        self.button.frame = CGRect(x: (screen.size.width - buttonWidth) / 2,
                y: buttonTopView, width: buttonWidth, height: buttonHeight)
        //添加按钮到当前视图
        self.view.addSubview(self.button)

    }

    func onClick(_ sender: AnyObject) {
        //设置按钮不可见
        self.button.alpha = 0.0
        
        //创建路径
        let starPath = CGMutablePath()
        starPath.move(to: CGPoint(x: 160.0, y: 100.0))
        starPath.addLine(to: CGPoint(x: 100.0, y: 280.0))
        starPath.addLine(to: CGPoint(x: 260.0, y: 170.0))
        starPath.addLine(to: CGPoint(x: 60.0, y: 170.0))
        starPath.addLine(to: CGPoint(x: 220.0, y: 280.0))
        //闭合路径
        starPath.closeSubpath()
        
        //创建位置变化的帧动画
        let animation = CAKeyframeAnimation(keyPath: "position")
        //设置动画持续时间
        animation.duration = 10.0
        //设置self为动画委托对象
        animation.delegate = self
        //设置动画路径
        animation.path = starPath
        
        self.ball.layer.add(animation, forKey : "position")
        
    }

    // MARK: --实现委托协议CAAnimationDelegate
    // 动画开始方法
    func animationDidStart(_ anim: CAAnimation) {
        print("动画开始...")
    }
    
    // 动画结束方法
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("动画开始...")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

