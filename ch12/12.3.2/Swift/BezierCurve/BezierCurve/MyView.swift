//
//  MyView.swift
//  BezierCurve
//
//  Created by tony on 2017/3/23.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class MyView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        //填充白色背景
        UIColor.white.setFill()
        UIRectFill(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        context!.move(to: CGPoint(x: 333, y: 0))
        context!.addCurve(to:CGPoint(x: 330, y: 26) , control1: CGPoint(x: 333, y: 0), control2: CGPoint(x: 332, y: 26))
        context!.addCurve(to: CGPoint(x: 299, y: 17), control1: CGPoint(x: 330, y: 26), control2: CGPoint(x: 299, y: 20))
        context!.addLine(to: CGPoint(x: 296, y: 17))
        context!.addCurve(to: CGPoint(x: 291, y: 19), control1: CGPoint(x: 296, y: 17), control2: CGPoint(x: 296, y: 19))
        context!.addLine(to: CGPoint(x: 250, y: 19))
        context!.addCurve(to: CGPoint(x: 238, y: 19), control1: CGPoint(x: 250, y: 19), control2: CGPoint(x: 241, y: 24))
        context!.addCurve(to: CGPoint(x: 227, y: 24), control1: CGPoint(x: 236, y: 20), control2: CGPoint(x: 234, y: 24))
        context!.addCurve(to: CGPoint(x: 216, y: 19), control1: CGPoint(x: 220, y: 24), control2: CGPoint(x: 217, y: 19))
        context!.addCurve(to: CGPoint(x: 207, y: 20), control1: CGPoint(x: 214, y: 20), control2: CGPoint(x: 211, y: 22))
        context!.addCurve(to: CGPoint(x: 182, y: 21), control1: CGPoint(x: 207, y: 20), control2: CGPoint(x: 187, y: 20))
        context!.addLine(to: CGPoint(x: 100, y: 45))
        context!.addLine(to: CGPoint(x: 97, y: 46))
        context!.addCurve(to: CGPoint(x: 64, y: 72), control1: CGPoint(x: 97, y: 46), control2: CGPoint(x: 86, y: 71))
        context!.addCurve(to: CGPoint(x: 23, y: 48), control1: CGPoint(x: 42, y: 74), control2: CGPoint(x: 26, y: 56))
        context!.addLine(to: CGPoint(x: 9, y: 47))
        context!.addCurve(to: CGPoint(x: 0, y: 0), control1: CGPoint(x: 9, y: 47), control2: CGPoint(x: 0, y: 31))
        
        context!.strokePath()

    }
}
