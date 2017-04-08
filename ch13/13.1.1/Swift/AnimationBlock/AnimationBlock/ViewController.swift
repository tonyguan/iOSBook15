//
//  ViewController.swift
//  AnimationBlock
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

    //小球运动方向标志，1表示向下运行，-1表示向上运行
    var flag = 1;

    var ball: UIImageView!

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
        let button = UIButton(type: .custom)
        //设置按钮正常状态时显示图片
        button.setImage(UIImage(named: "ButtonOutline.png"), for: .normal)
        //设置按钮高亮状态时显示图片
        button.setImage(UIImage(named: "ButtonOutlineHighlighted.png"), for: .highlighted)
        //设置按钮触摸动作输出口
        button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)

        let buttonWidth: CGFloat = 130
        let buttonHeight: CGFloat = 50
        let buttonTopView: CGFloat = 500
        button.frame = CGRect(x: (screen.size.width - buttonWidth) / 2,
                y: buttonTopView, width: buttonWidth, height: buttonHeight)
        //添加按钮到当前视图
        self.view.addSubview(button)

    }

    func onClick(_ sender: AnyObject) {

        UIView.animate(withDuration: 1.5, animations: { () -> Void in
            var frame = self.ball.frame
            frame.origin.y += CGFloat(200 * self.flag)
            self.flag *= -1 //取反
            self.ball.frame = frame
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

