//
//  ViewController.swift
//  PageNavigation
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

//翻页的方向
enum DirectionForward : Int {
    case before = 1 //向前
    case after = 2  //向后
}

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //当前Page的索引
    var pageIndex = 0
    //翻页的方向变量
    var directionForward  =  DirectionForward.after
    
    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let page1ViewController = UIViewController()
        let page2ViewController = UIViewController()
        let page3ViewController = UIViewController()
        
        self.viewControllers = [page1ViewController, page2ViewController, page3ViewController]
        
        let imageView1 = UIImageView(frame: self.view.frame)
        imageView1.image = UIImage(named: "达芬奇-蒙娜丽莎.png")
        page1ViewController.view.addSubview(imageView1)
        
        let imageView2 = UIImageView(frame: self.view.frame)
        imageView2.image = UIImage(named: "罗丹-思想者.png")
        page2ViewController.view.addSubview(imageView2)
        
        let imageView3 = UIImageView(frame: self.view.frame)
        imageView3.image = UIImage(named: "保罗克利-肖像.png")
        page3ViewController.view.addSubview(imageView3)
        
        //设置UIPageViewController控制器
        self.pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        //设置首页
        self.pageViewController.setViewControllers([page1ViewController], direction: .forward, animated: true, completion: nil)
        
        self.view.addSubview(self.pageViewController.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: --实现UIPageViewControllerDataSource协议
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        pageIndex -= 1
        
        if (pageIndex < 0){
            pageIndex = 0
            return nil
        }
        
        directionForward = .before
        return self.viewControllers[pageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        pageIndex += 1
        
        if (pageIndex > 2){
            pageIndex = 2
            return nil
        }
        
        directionForward = .after
        return self.viewControllers[pageIndex]
    }
    
    // MARK: --实现UIPageViewControllerDelegate协议
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        self.pageViewController.isDoubleSided = false
        return .min
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (completed == false) {
            if (directionForward == .after) {
                pageIndex -= 1
            }
            if (directionForward == .before) {
                pageIndex += 1
            }
        }
    }
    
}
