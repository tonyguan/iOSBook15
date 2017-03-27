//
//  YellowViewController.swift
//  SplitViewSample
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

class YellowViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detailFrame = self.navigationController!.view.frame
        
        self.view.backgroundColor = UIColor.yellow
        
        let buttonWidth:CGFloat = 60
        let buttonHeight:CGFloat = 20
        let buttonX: CGFloat = (detailFrame.size.width - buttonWidth)/2
        let buttonY: CGFloat = (detailFrame.size.height - buttonHeight)/2
        
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Tap", for: UIControlState())
        
        button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 28)
        button.setTitleColor(UIColor.black, for: UIControlState())
        
        button.addTarget(self, action: #selector(YellowViewController.onClick(_:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(button)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onClick(_ sender: AnyObject) {
        
        let alertController: UIAlertController = UIAlertController(title: "系统消息", message: "黄色视图", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        //显示
        self.present(alertController, animated: true, completion: nil)
    }
    
}

