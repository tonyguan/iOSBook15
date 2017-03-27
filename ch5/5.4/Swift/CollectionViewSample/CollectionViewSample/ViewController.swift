//
//  ViewController.swift
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

//集合视图列数，即：每一行有几个单元格
let COL_NUM = 3

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var events : NSArray!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "events", ofType: "plist")
        //获取属性列表文件中的全部数据
        self.events = NSArray(contentsOfFile: plistPath!)
        
        self.setupCollectionView()
        
    }
    
    func setupCollectionView() {
        
        // 1.创建流式布局布局
        let layout = UICollectionViewFlowLayout()
        // 2.设置每个单元格的尺寸
        layout.itemSize = CGSize(width: 80, height: 80)
        // 3.设置整个collectionView的内边距
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 30, 15)
        
        let screenSize  = UIScreen.main.bounds.size;
        //重新设置iPhone 6/6s/7/7s/Plus
        if (screenSize.height > 568) {
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.sectionInset = UIEdgeInsetsMake(15, 15, 20, 15)
        }
        
        // 4.设置单元格之间的间距
        layout.minimumInteritemSpacing = 10
        
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        //设置可重用单元格标识与单元格类型
        self.collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier" )
        
        self.collectionView.backgroundColor = UIColor.white
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.view.addSubview(self.collectionView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -- UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        let num = self.events.count % COL_NUM
        if (num == 0) {//偶数
            return self.events.count / COL_NUM
        } else {        //奇数
            return self.events.count / COL_NUM + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return COL_NUM
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! EventCollectionViewCell
        
        //计算events集合下标索引
        let idx = indexPath.section * COL_NUM + indexPath.row;
        
        if (self.events.count <= idx) {//防止下标越界
            return cell;
        }
        
        let event = self.events[idx] as! NSDictionary
        cell.label.text = event["name"] as? String
        cell.imageView.image = UIImage(named: event["image"] as! String)
        
        return cell
    }
    
    //MARK: --UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let event = self.events[(indexPath as NSIndexPath).section * COL_NUM + (indexPath as NSIndexPath).row] as! NSDictionary
        print("select event name : ", event["name"]!)
        
    }
}
