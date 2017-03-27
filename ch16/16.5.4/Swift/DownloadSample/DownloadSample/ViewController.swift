//
//  ViewController.swift
//  DownloadSample
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
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageView1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClick(_ sender: AnyObject) {
        
        let strURL = String(format: "http://www.51work6.com/service/download.php?email=%@&FileName=test1.jpg", "<你的51work6.com用户邮箱>")

        let destination = DownloadRequest.suggestedDownloadDestination()
        
        Alamofire.download(strURL, method: .post, to: destination)
            .downloadProgress { progress in
                print("下载进度: \(progress.fractionCompleted)")
                self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
            }
            .responseJSON { response in
                print("下载成功，保存文件: \(response.destinationURL!)")
                let data = NSData(contentsOf: response.destinationURL!)
                let img = UIImage(data: data as! Data)
                self.imageView1.image = img
        }
    }
    
}

