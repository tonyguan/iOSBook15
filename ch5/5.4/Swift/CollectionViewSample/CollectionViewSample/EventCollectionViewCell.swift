//
//  EventCollectionViewCell.swift
//  CollectionViewSample
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

class EventCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //单元格的宽度
        let cellWidth: CGFloat = self.frame.size.width
        
        let imageViewWidth: CGFloat = 101
        let imageViewHeight: CGFloat = 101
        let imageViewTopView: CGFloat = 15
        
        /// 1.添加ImageView
        self.imageView = UIImageView(frame: CGRect(x: (cellWidth - imageViewWidth) / 2, y: imageViewTopView, width: imageViewWidth, height: imageViewHeight))
        
        self.addSubview(self.imageView)
        
        /// 2.添加标签
        let labelWidth: CGFloat = 101
        let labelHeight: CGFloat = 16
        let labelTopView: CGFloat = 120
        
        self.label = UILabel(frame: CGRect(x: (cellWidth - labelWidth) / 2, y: labelTopView, width: labelWidth, height: labelHeight))
        
        //字体左右居中
        self.label.textAlignment = .center
        //设置字体
        self.label.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(self.label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
