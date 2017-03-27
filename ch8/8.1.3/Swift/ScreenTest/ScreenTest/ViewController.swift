//
//  ViewController.swift
//  ScreenTest
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

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let iOSDeviceScreenSize : CGSize = UIScreen.main.bounds.size
        NSLog("%.0f x %.0f", iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)
        let s  = String(format: "%.0f x %.0f", iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)
        self.label.text = s
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone) {
            
            if (iOSDeviceScreenSize.height > iOSDeviceScreenSize.width) {//竖屏情况
                if (iOSDeviceScreenSize.height == 568) {//iPhone 5/5s/5c/SE设备
                    NSLog("iPhone 5/5s/5c/SE设备")
                } else if (iOSDeviceScreenSize.height == 667) {//iPhone 6/6s/7
                    NSLog("iPhone 6/6s/7设备")
                } else if (iOSDeviceScreenSize.height == 736) {//iPhone Plus
                    NSLog("iPhone Plus设备")
                } else {//其他设备
                    NSLog("其他设备")
                }
            }
            if (iOSDeviceScreenSize.width > iOSDeviceScreenSize.height) {//横屏情况
                if (iOSDeviceScreenSize.width == 568) {//iPhone 5/5s/5c/SE设备
                    NSLog("iPhone 5/5s/5c/SE设备")
                } else if (iOSDeviceScreenSize.width == 667) {//iPhone 6/6s/7
                    NSLog("iPhone 6/6s/7设备")
                } else if (iOSDeviceScreenSize.width == 736) {//iPhone Plus
                    NSLog("iPhone Plus设备")
                } else {//其他设备
                    NSLog("其他设备")
                }
            }
        }
        
    }

}

