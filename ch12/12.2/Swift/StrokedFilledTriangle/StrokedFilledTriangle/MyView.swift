//
//  MyView.swift
//  StrokedFilledTriangle
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
        
        //自定义图形上下文
        let context = UIGraphicsGetCurrentContext()
        context!.move(to: CGPoint(x: 75, y: 10))
        context!.addLine(to: CGPoint(x: 10, y: 150))
        context!.addLine(to: CGPoint(x: 160, y: 150))
        context!.closePath()
        
        // 设置黑色描边参数
        UIColor.black.setStroke()
        // 设置红色条填充参数
        UIColor.red.setFill()
        //绘制路径
        context!.drawPath(using: CGPathDrawingMode.fillStroke)

    }
    
}
