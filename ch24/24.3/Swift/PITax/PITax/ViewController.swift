//
//  ViewController.swift
//  PITax
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
    
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var txtRevenue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func onClick(_ sender: AnyObject) {
        //关闭键盘
        self.txtRevenue.resignFirstResponder()
        
        if let value = self.txtRevenue.text {
            guard value.characters.count > 0 else {
                let alertController: UIAlertController = UIAlertController(title: "警告",
                                                                           message: "请输入内容",
                                                                           preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(okAction)
                //显示
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            if let revenue = Double(value) {
                let bl = TaxRevenueBL()
                let resultValue = bl.calculate(revenue)
                let strTax = String(format:"%.2f", resultValue)
                self.lblTax.text = strTax
            }
        }
    }
}

