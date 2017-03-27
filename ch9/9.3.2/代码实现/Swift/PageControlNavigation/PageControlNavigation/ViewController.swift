//
//  ViewController.swift
//  PageControlNavigation
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
//定义获取屏幕宽度
let S_WIDTH: CGFloat = UIScreen.main.bounds.size.width
//定义获取屏幕高度
let S_HEIGHT: CGFloat = UIScreen.main.bounds.size.height

class ViewController: UIViewController, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    
    var imageView1: UIImageView!
    var imageView2: UIImageView!
    var imageView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView = UIScrollView()
        self.view.addSubview(self.scrollView)
        
        self.scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.scrollView.contentSize  = CGSize(width: S_WIDTH * 3, height: S_HEIGHT)
        self.scrollView.frame = self.view.frame
        
        self.imageView1 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: S_WIDTH, height: S_HEIGHT))
        self.imageView1.image = UIImage(named: "达芬奇-蒙娜丽莎.png")
        
        self.imageView2 = UIImageView(frame: CGRect(x: S_WIDTH, y: 0.0, width: S_WIDTH, height: S_HEIGHT))
        self.imageView2.image = UIImage(named: "罗丹-思想者.png")
        
        self.imageView3 = UIImageView(frame: CGRect(x: 2 * S_WIDTH, y: 0.0, width: S_WIDTH, height: S_HEIGHT))
        self.imageView3.image = UIImage(named: "保罗克利-肖像.png")
        
        self.scrollView.addSubview(self.imageView1)
        self.scrollView.addSubview(self.imageView2)
        self.scrollView.addSubview(self.imageView3)
        
        let pageControlWidth: CGFloat = 300.0
        let pageControlHeight: CGFloat = 37.0
        self.pageControl = UIPageControl(frame: CGRect(x: (S_WIDTH - pageControlWidth) / 2, y: S_HEIGHT - pageControlHeight, width: pageControlWidth, height: pageControlHeight))
        self.pageControl.numberOfPages = 3
        self.pageControl.addTarget(self, action: #selector(changePage(_:)), for: .valueChanged)
        self.view.addSubview(self.pageControl)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: --实现UIScrollViewDelegate委托协议
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        self.pageControl.currentPage = Int(offset.x / S_WIDTH)
    }
    
    // MARK: --实现UIPageControl事件处理
    func changePage(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.3, animations : {
            let whichPage = self.pageControl.currentPage
            self.scrollView.contentOffset = CGPoint(x: S_WIDTH * CGFloat(whichPage), y: 0)
        })
    }

}

