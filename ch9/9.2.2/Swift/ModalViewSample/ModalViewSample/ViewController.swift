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
        let screen = UIScreen.main.bounds
        
        self.navigationItem.title = "登录"
        
        /// 1.添加用户ID：标签
        let labelId = UILabel(frame: CGRect(x: 80,y: 115, width: 80, height: 21))
        labelId.text = "用户ID："
        self.view.addSubview(labelId)
        
        /// 2.添加用户ID TextField
        let textFieldId = UITextField(frame: CGRect(x: 170, y: 106, width: 100, height: 30))
        textFieldId.borderStyle = .roundedRect
        self.view.addSubview(textFieldId)
        
        /// 3.添加密码：标签
        let labelPwd = UILabel(frame: CGRect(x: 80, y: 178, width: 80, height: 21))
        labelPwd.text = "密码："
        self.view.addSubview(labelPwd)
        
        /// 4.添加密码 TextField
        let textFieldPwd = UITextField(frame: CGRect(x: 170, y: 169, width: 100, height: 30))
        textFieldPwd.borderStyle = .roundedRect
        self.view.addSubview(textFieldPwd)
        
        /// 5.添加 登录按钮
        let buttonLogin = UIButton(type: .system)
        buttonLogin.frame = CGRect(x: (screen.size.width - 30)/2, y: 231, width: 50, height: 30)
        buttonLogin.setTitle("登录", for: UIControlState())
        self.view.addSubview(buttonLogin)
        
        /// 6.添加 注册按钮
        let buttonReg = UIButton(type: .system)
        buttonReg.frame = CGRect(x: (screen.size.width - 30)/2, y: 294, width: 50, height: 30)
        buttonReg.setTitle("注册", for: UIControlState())
        buttonReg.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        self.view.addSubview(buttonReg)
        
        NotificationCenter.default.addObserver(self, selector: #selector(registerCompletion(_:)), name: Notification.Name(rawValue: "RegisterCompletionNotification"), object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NotificationCenter.default.removeObserver(self)
    }
    
    func onClick(_ sender: AnyObject) {
        
        let registerViewController = RegisterViewController()
        let navigationController = UINavigationController(rootViewController: registerViewController)
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func registerCompletion(_ notification: Notification) {
        
        let theData = notification.userInfo!
        let username = theData["username"] as! String
        
        print("username = ", username)
    }

}

