//
//  MyView.swift
//  ImageStringSample
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
        
        let image = UIImage(named: "dog")
        
        //设置一个rect矩形区域
        let imageRect = CGRect(x: 0, y: 40, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
        //绘制图片
        image!.draw(in: imageRect)
        //image!.draw(at: CGPoint(x: 0, y: 40))
        //image!.drawAsPattern(in: CGRect(x: 0, y: 0, width: 320, height: 400))
        
        let title: NSString = "我的小狗"
        let font = UIFont.systemFont(ofSize: 28)
        let attr = [NSFontAttributeName: font]
        //获得字符串大小
        let size = title.size(attributes: attr)
        //水平居中时x轴坐标
        let xpos = UIScreen.main.bounds.midX - size.width / 2;
        //绘制字符串
        title.draw(at: CGPoint(x: xpos, y: 20), withAttributes:attr)
        //let stringRect = CGRect(x: xpos, y: 60, width: 100, height: 40)
        //title.draw(in: stringRect, withAttributes: attr)

    }
    
}
