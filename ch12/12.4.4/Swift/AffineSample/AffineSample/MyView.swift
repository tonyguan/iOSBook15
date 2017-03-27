//
//  MyView.swift
//  AffineSample
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
        
        let path = Bundle.main.path(forResource: "cat", ofType: "png")
        //创建UIImage图片对象
        let uiImage  = UIImage(contentsOfFile : path!)
        //将UIImage图片对象转换为CGImage图片对象
        let cgImage = uiImage!.cgImage
        
        let context = UIGraphicsGetCurrentContext()
        
        //缩放变换
        var myAffine = CGAffineTransform(scaleX: 1, y: -1)
        //平移变换
        myAffine = myAffine.translatedBy(x: 0, y: -uiImage!.size.height)
        //连接到CTM矩阵
        context!.concatenate(myAffine)
        
        let imageRect = CGRect(x: 0, y: 0, width: uiImage!.size.width, height: uiImage!.size.height)
        context!.draw(cgImage!, in: imageRect)

    }
}
