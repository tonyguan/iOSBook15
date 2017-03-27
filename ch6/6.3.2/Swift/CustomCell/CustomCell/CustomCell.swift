//
//  CustomCell.swift
//  CustomCell
//
//  Created by 关东升 on 2016-11-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//


import UIKit

class CustomCell: UITableViewCell {

    var myLabel: UILabel!
    var myImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //单元格的宽度
        //let cellWidth: CGFloat = self.frame.size.width
        let cellHeight: CGFloat = self.frame.size.height
        
        let imageViewWidth: CGFloat = 39
        let imageViewHeight: CGFloat = 28
        let imageViewLeftView: CGFloat = 300
        
        
        /// 1.添加ImageView
        self.myImageView = UIImageView(frame: CGRect(x: imageViewLeftView,  y: (cellHeight - imageViewHeight) / 2, width: imageViewWidth, height: imageViewHeight))
        
        self.addSubview(self.myImageView)
        
        /// 2.添加标签
        let labelWidth: CGFloat = 120
        let labelHeight: CGFloat = 21
        let labelLeftView: CGFloat = 15
        
        self.myLabel = UILabel(frame: CGRect(x: labelLeftView, y: (cellHeight - labelHeight) / 2, width: labelWidth, height: labelHeight))
        
        self.addSubview(self.myLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
