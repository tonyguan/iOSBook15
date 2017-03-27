//
//  MyView.swift
//  CTMSample
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
        
        //创建UIImage图片对象
        let uiImage  = UIImage(named: "cat")
        //将UIImage图片对象转换为CGImage图片对象
        let cgImage = uiImage!.cgImage
        
        let context = UIGraphicsGetCurrentContext()
     
        //1.平移变换
        //context!.translateBy(x: 100, y: 50)
        
        //2.缩放变换
        //context!.scaleBy(x: 0.5, y: 0.75)
        
        //3.旋转变换
        //context!.rotate(by: CGFloat(45.0 * M_PI / 180.0))
        
        //4.组合变换
        context!.scaleBy(x: 1, y: -1)
        context!.translateBy(x: 0, y: -uiImage!.size.height)
        
        let imageRect = CGRect(x: 0, y: 0, width: uiImage!.size.width, height: uiImage!.size.height)
        context!.draw(cgImage!, in: imageRect)

    }
}
