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
import Foundation

class ViewController: UIViewController, URLSessionDownloadDelegate {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageView1: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClick(_ sender: AnyObject) {

        let strURL = String(format: "http://www.51work6.com/service/download.php?email=%@&FileName=test1.jpg", "<你的51work6.com用户邮箱>")
        let url = URL(string: strURL)!

        let defaultConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: defaultConfig, delegate: self, delegateQueue: OperationQueue.main)

        let downloadTask = session.downloadTask(with: url)

        downloadTask.resume()
    }

    //MARK: -- 实现NSURLSessionDownloadDelegate委托协议
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {

        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        self.progressView .setProgress(progress, animated: true)
        NSLog("进度= %f", progress)
        NSLog("接收: %lld 字节 (已下载: %lld 字节)  期待: %lld 字节.", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite)
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {

        NSLog("临时文件: %@", location.description)

        let downloadsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

        let downloadStrPath = downloadsDir + "/test1.jpg"
        let downloadURLPath = URL(fileURLWithPath: downloadStrPath)
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: downloadStrPath) == true {
            do {
                try fileManager.removeItem(atPath: downloadStrPath)
            } catch let error as NSError {
                NSLog("删除文件失败: %@", error.localizedDescription)
            }
        }

        do {
            try fileManager.moveItem(at: location, to: downloadURLPath)
            NSLog("文件保存: %@", downloadStrPath)            
            let img = UIImage(contentsOfFile: downloadStrPath)
            self.imageView1.image = img
            
        } catch let error as NSError {
            NSLog("保存文件失败: %@", error.localizedDescription)
        }
    }
}

