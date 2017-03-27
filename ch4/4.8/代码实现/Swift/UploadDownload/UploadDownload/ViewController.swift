//
//  ViewController.swift
//  UploadDownload
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
    
    var activityIndicatorView: UIActivityIndicatorView!
    var progressView: UIProgressView!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        let screen = UIScreen.main.bounds
        
        ///1.获得指示器
        self.activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        var frame = self.activityIndicatorView.frame
        frame.origin = CGPoint(x: (screen.size.width - frame.size.width) / 2, y: 84)
        //重新设置控件的位置
        self.activityIndicatorView.frame = frame
        
        self.activityIndicatorView.hidesWhenStopped = false
        self.view.addSubview(self.activityIndicatorView)
        
        ///2.Upload按钮
        let buttonUpload = UIButton(type: UIButtonType.system)
        buttonUpload.setTitle("Upload", for: UIControlState())
        
        let buttonUploadWidth:CGFloat = 50
        let buttonUploadHeight:CGFloat = 30
        let buttonUploadTopView:CGFloat = 190
        
        buttonUpload.frame = CGRect(x: (screen.size.width - buttonUploadWidth)/2 , y: buttonUploadTopView, width: buttonUploadWidth, height: buttonUploadHeight)
        //指定事件处理方法
        buttonUpload.addTarget(self, action: #selector(startToMove(_:)), for: .touchUpInside)
        self.view.addSubview(buttonUpload)
        
        ///3.进度条
        let progressViewWidth:CGFloat = 200
        let progressViewHeight:CGFloat = 2
        let progressViewTopView:CGFloat = 283
        
        self.progressView = UIProgressView(frame: CGRect(x: (screen.size.width - progressViewWidth)/2 , y: progressViewTopView, width: progressViewWidth, height: progressViewHeight))
        
        self.view.addSubview(self.progressView)
        
        ///4.Download按钮
        let buttonDownload = UIButton(type: UIButtonType.system)
        buttonDownload.setTitle("Download", for: UIControlState())
        
        let buttonDownloadWidth:CGFloat = 69
        let buttonDownloadHeight:CGFloat = 30
        let buttonDownloadTopView:CGFloat = 384
        
        buttonDownload.frame = CGRect(x: (screen.size.width - buttonDownloadWidth)/2 , y: buttonDownloadTopView, width: buttonDownloadWidth, height: buttonDownloadHeight)
        //指定事件处理方法
        buttonDownload.addTarget(self, action: #selector(downloadProgress(_:)), for: .touchUpInside)
        
        self.view.addSubview(buttonDownload)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func startToMove(_ sender: AnyObject) {
        if (self.activityIndicatorView.isAnimating) {
            self.activityIndicatorView.stopAnimating()
        }else{
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func downloadProgress(_ sender: AnyObject) {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
                                          selector: #selector(download),
                                          userInfo: nil, repeats: true)
    }
    
    func download() {
        self.progressView.progress = self.progressView.progress + 0.1
        if (self.progressView.progress == 1.0) {
            self.timer.invalidate()
            
            let alertController: UIAlertController = UIAlertController(title: "download completed！", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            //显示
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
