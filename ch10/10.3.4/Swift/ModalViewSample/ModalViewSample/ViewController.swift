//
//  ViewController.swift
//  ModalViewSample
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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///创建Full Screen按钮
        let buttonFullScreen = UIButton(type: .system)
        buttonFullScreen.setTitle("Full Screen", for: UIControlState())
        buttonFullScreen.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonFullScreen.addTarget(self, action: #selector(onclick(_:)), for:.touchUpInside)
        //设置tag区别其他的按钮
        buttonFullScreen.tag = 100
        self.view.addSubview(buttonFullScreen)
        
        ///创建Form Sheet按钮
        let buttonFormSheet = UIButton(type: .system)
        buttonFormSheet.setTitle("Form Sheet", for: UIControlState())
        buttonFormSheet.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonFormSheet.addTarget(self, action: #selector(onclick(_:)), for:.touchUpInside)
        //设置tag区别其他的按钮
        buttonFormSheet.tag = 200
        self.view.addSubview(buttonFormSheet)
        
        ///创建Page Sheet按钮
        let buttonPageSheet = UIButton(type: .system)
        buttonPageSheet.setTitle("Page Sheet", for: UIControlState())
        buttonPageSheet.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonPageSheet.addTarget(self, action: #selector(onclick(_:)), for:.touchUpInside)
        //设置tag区别其他的按钮
        buttonPageSheet.tag = 300
        self.view.addSubview(buttonPageSheet)
        
        ///创建Current Context按钮
        let buttonCurrentContext = UIButton(type: .system)
        buttonCurrentContext.setTitle("Current Context", for: UIControlState())
        buttonCurrentContext.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonCurrentContext.addTarget(self, action: #selector(onclick(_:)), for:.touchUpInside)
        //设置tag区别其他的按钮
        buttonCurrentContext.tag = 400
        self.view.addSubview(buttonCurrentContext)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLog("重新布局")
        
        let screen = UIScreen.main.bounds
        let buttonWidth: CGFloat = 200
        let buttonHeight: CGFloat = 20
        let buttonTopView: CGFloat = 115
        let buttonX: CGFloat = (screen.size.width - buttonWidth)/2
        
        ///创建Full Screen按钮
        let buttonFullScreen = self.view.viewWithTag(100)
        buttonFullScreen!.frame = CGRect(x: buttonX, y: buttonTopView, width: buttonWidth, height: buttonHeight)
        
        ///创建Form Sheet按按钮
        let buttonFormSheet = self.view.viewWithTag(200)
        buttonFormSheet!.frame = CGRect(x: buttonX, y: buttonFullScreen!.frame.origin.y + 100, width: buttonWidth, height: buttonHeight)
        
        ///创建Page Sheet按钮
        let buttonPageSheet = self.view.viewWithTag(300)
        buttonPageSheet!.frame = CGRect(x: buttonX, y: buttonFormSheet!.frame.origin.y + 100, width: buttonWidth, height: buttonHeight)
        
        ///创建Current Context按钮
        let buttonCurrentContext = self.view.viewWithTag(400)
        buttonCurrentContext!.frame = CGRect(x: buttonX, y: buttonPageSheet!.frame.origin.y + 100, width: buttonWidth, height: buttonHeight)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onclick(_ sender: AnyObject) {
        
        let modalViewController = ModalViewController()
        let navigationController = UINavigationController(rootViewController: modalViewController)
        navigationController.modalTransitionStyle = .coverVertical
        
        let button = sender as! UIButton
        
        switch (button.tag) {
        case 100:
            navigationController.modalPresentationStyle = .fullScreen
        case 200:
            navigationController.modalPresentationStyle = .formSheet
        case 300:
            navigationController.modalPresentationStyle = .pageSheet
        case 400:
            navigationController.modalPresentationStyle = .currentContext
        default :
            NSLog("默认分支")
        }
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
}

